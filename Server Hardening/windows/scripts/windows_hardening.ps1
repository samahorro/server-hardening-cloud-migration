<#+
.SYNOPSIS
    Windows Server hardening helper script for portfolio/demo use.

.DESCRIPTION
    Reviews or applies selected Windows Server hardening settings, including
    audit policy, service review, firewall rule examples, and registry-based
    network/security settings.

    Run with -AuditOnly first. Test in a non-production environment before
    applying changes to production systems.

.EXAMPLE
    .\windows_hardening.ps1 -ServerType File -ComplianceLevel Medium -AuditOnly

.EXAMPLE
    .\windows_hardening.ps1 -ServerType File -ComplianceLevel Medium
#>

param(
    [Parameter(Mandatory = $true)]
    [ValidateSet("Web", "Database", "Domain", "File", "General")]
    [string]$ServerType,

    [Parameter(Mandatory = $true)]
    [ValidateSet("Low", "Medium", "High")]
    [string]$ComplianceLevel,

    [switch]$AuditOnly
)

$ErrorActionPreference = "Stop"
$LogDirectory = "C:\Logs"
$LogFile = Join-Path $LogDirectory "hardening_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"

function Write-Log {
    param([string]$Message)
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Line = "$Timestamp - $Message"
    $Line | Out-File -FilePath $LogFile -Append -Encoding utf8
    Write-Host $Line
}

function Invoke-Change {
    param(
        [string]$Description,
        [scriptblock]$Action
    )

    if ($AuditOnly) {
        Write-Log "AUDIT ONLY: $Description"
        return
    }

    Write-Log "APPLYING: $Description"
    & $Action
}

function Test-Administrator {
    $CurrentIdentity = [Security.Principal.WindowsIdentity]::GetCurrent()
    $Principal = New-Object Security.Principal.WindowsPrincipal($CurrentIdentity)
    return $Principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

function Ensure-LogDirectory {
    if (!(Test-Path $LogDirectory)) {
        New-Item -ItemType Directory -Path $LogDirectory -Force | Out-Null
    }
}

function Export-CurrentState {
    Write-Log "Exporting current firewall and audit state for review."

    $ExportDirectory = Join-Path $LogDirectory "baseline_$(Get-Date -Format 'yyyyMMdd_HHmmss')"

    Invoke-Change "Create baseline export directory: $ExportDirectory" {
        New-Item -ItemType Directory -Path $ExportDirectory -Force | Out-Null
        Get-NetFirewallRule | Select-Object DisplayName, Enabled, Direction, Action, Profile |
            Export-Csv -Path (Join-Path $ExportDirectory "firewall_rules.csv") -NoTypeInformation
        auditpol /get /category:* | Out-File -FilePath (Join-Path $ExportDirectory "audit_policy.txt") -Encoding utf8
        Get-Service | Select-Object Name, DisplayName, Status, StartType |
            Export-Csv -Path (Join-Path $ExportDirectory "services.csv") -NoTypeInformation
    }
}

function Set-PasswordAndLockoutPolicy {
    Write-Log "Configuring password and lockout policy."

    $Commands = @(
        "net accounts /minpwlen:12",
        "net accounts /maxpwage:90",
        "net accounts /minpwage:1",
        "net accounts /uniquepw:24",
        "net accounts /lockoutthreshold:5",
        "net accounts /lockoutduration:30",
        "net accounts /lockoutwindow:15"
    )

    foreach ($Command in $Commands) {
        Invoke-Change "Run: $Command" {
            cmd.exe /c $Command | Out-Null
        }
    }
}

function Configure-AuditPolicy {
    Write-Log "Configuring audit policy."

    $AuditCommands = @(
        'auditpol /set /subcategory:"Logon" /success:enable /failure:enable',
        'auditpol /set /subcategory:"Logoff" /success:enable /failure:disable',
        'auditpol /set /subcategory:"Account Lockout" /success:enable /failure:enable',
        'auditpol /set /subcategory:"User Account Management" /success:enable /failure:enable',
        'auditpol /set /subcategory:"Security Group Management" /success:enable /failure:enable',
        'auditpol /set /subcategory:"Policy Change" /success:enable /failure:enable',
        'auditpol /set /subcategory:"System Integrity" /success:enable /failure:enable'
    )

    foreach ($Command in $AuditCommands) {
        Invoke-Change "Run: $Command" {
            cmd.exe /c $Command | Out-Null
        }
    }
}

function Disable-UnnecessaryServices {
    Write-Log "Reviewing services commonly disabled when not required."

    $ServicesToReview = @(
        "RemoteRegistry",
        "TlntSvr",
        "Tftpd",
        "SNMP"
    )

    if ($ServerType -ne "File" -and $ServerType -ne "Domain") {
        $ServicesToReview += "Spooler"
    }

    foreach ($ServiceName in $ServicesToReview | Select-Object -Unique) {
        $Service = Get-Service -Name $ServiceName -ErrorAction SilentlyContinue
        if ($null -eq $Service) {
            Write-Log "Service not present: $ServiceName"
            continue
        }

        Invoke-Change "Disable service if approved: $ServiceName" {
            Stop-Service -Name $ServiceName -Force -ErrorAction SilentlyContinue
            Set-Service -Name $ServiceName -StartupType Disabled
        }
    }
}

function Set-RegistryValueSafe {
    param(
        [string]$Path,
        [string]$Name,
        [object]$Value,
        [ValidateSet("String", "ExpandString", "Binary", "DWord", "MultiString", "QWord")]
        [string]$Type = "DWord"
    )

    Invoke-Change "Set registry value $Path\$Name to $Value" {
        if (!(Test-Path $Path)) {
            New-Item -Path $Path -Force | Out-Null
        }
        New-ItemProperty -Path $Path -Name $Name -Value $Value -PropertyType $Type -Force | Out-Null
    }
}

function Set-RegistrySecurity {
    Write-Log "Configuring registry-based security settings."

    Set-RegistryValueSafe -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa" -Name "NoLMHash" -Value 1
    Set-RegistryValueSafe -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa" -Name "RestrictAnonymousSAM" -Value 1
    Set-RegistryValueSafe -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa" -Name "RestrictAnonymous" -Value 1
    Set-RegistryValueSafe -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" -Name "ClearPageFileAtShutdown" -Value 1
}

function Configure-NetworkSecurity {
    Write-Log "Configuring network security settings."

    Set-RegistryValueSafe -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" -Name "EnableICMPRedirect" -Value 0
    Set-RegistryValueSafe -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" -Name "DisableIPSourceRouting" -Value 2
    Set-RegistryValueSafe -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" -Name "EnableDeadGWDetect" -Value 0
}

function Configure-FirewallExamples {
    Write-Log "Creating example firewall baseline rules. Review before production use."

    $Rules = @(
        @{ Name = "Portfolio-Allow-HTTP"; Direction = "Inbound"; Action = "Allow"; Protocol = "TCP"; Port = 80 },
        @{ Name = "Portfolio-Allow-HTTPS"; Direction = "Inbound"; Action = "Allow"; Protocol = "TCP"; Port = 443 }
    )

    foreach ($Rule in $Rules) {
        $ExistingRule = Get-NetFirewallRule -DisplayName $Rule.Name -ErrorAction SilentlyContinue
        if ($ExistingRule) {
            Write-Log "Firewall rule already exists: $($Rule.Name)"
            continue
        }

        Invoke-Change "Create firewall rule: $($Rule.Name)" {
            New-NetFirewallRule `
                -DisplayName $Rule.Name `
                -Direction $Rule.Direction `
                -Action $Rule.Action `
                -Protocol $Rule.Protocol `
                -LocalPort $Rule.Port `
                -Profile Domain,Private `
                -Description "Portfolio hardening example rule" | Out-Null
        }
    }
}

function Main {
    Ensure-LogDirectory

    Write-Log "Starting Windows Server hardening workflow."
    Write-Log "ServerType: $ServerType | ComplianceLevel: $ComplianceLevel | AuditOnly: $AuditOnly"

    if (!(Test-Administrator)) {
        throw "This script must be run as Administrator."
    }

    Export-CurrentState
    Set-PasswordAndLockoutPolicy
    Configure-AuditPolicy
    Disable-UnnecessaryServices
    Set-RegistrySecurity
    Configure-NetworkSecurity
    Configure-FirewallExamples

    Write-Log "Hardening workflow completed. Restart may be required for some settings."
}

Main
