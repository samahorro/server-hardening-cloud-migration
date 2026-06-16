# Server Hardening & Cloud Migration Portfolio Project

> Sanitized portfolio version of a server hardening and cloud migration project focused on Windows Server security baselines, infrastructure documentation, access control, audit logging, and migration readiness.

## Overview

This repository documents a practical infrastructure security project where servers were reviewed, hardened, and prepared for migration into a more controlled cloud or hybrid environment. The project focuses on reducing unnecessary exposure, improving administrative consistency, and mapping technical hardening steps to recognized security controls.

The goal of this repo is to show the type of work I performed across system administration, infrastructure support, endpoint troubleshooting, server configuration, and security documentation.

## What This Project Demonstrates

- Windows Server hardening and baseline configuration
- Audit policy and logging improvements
- Local security policy review
- Firewall and service exposure reduction
- Least privilege and access control considerations
- Migration planning for cloud or hybrid infrastructure
- NIST SP 800-53 control mapping
- Validation checklists for post-hardening and post-migration review
- Documentation written for both technical and non-technical stakeholders

## Repository Structure

```text
server-hardening-cloud-migration-portfolio/
├── README.md
├── docs/
│   ├── project-overview.md
│   ├── hardening-methodology.md
│   ├── cloud-migration-plan.md
│   ├── nist-800-53-control-mapping.md
│   └── validation-checklist.md
├── hardening/
│   └── windows/
│       ├── scripts/
│       │   └── windows_hardening.ps1
│       └── checklists/
│           └── windows-server-hardening-checklist.md
├── migration/
│   └── cloud-migration-runbook.md
├── reports/
│   └── sample-findings-template.md
└── .gitignore
```

## Project Scope

This project is written as a sanitized portfolio case study. Sensitive company names, internal hostnames, IP addresses, users, and proprietary configurations have been removed or generalized.

The scope includes:

1. Reviewing Windows Server configuration and administrative exposure
2. Identifying unnecessary services, ports, and weak baseline settings
3. Applying hardening steps through PowerShell and manual validation
4. Mapping selected technical actions to NIST SP 800-53 controls
5. Preparing migration documentation for cloud or hybrid environments
6. Creating validation checklists for functional and security testing

## Key Technical Areas

### Server Hardening

The Windows hardening script and checklist cover:

- Password and account lockout policy review
- Audit policy configuration
- Windows Firewall rule review
- Legacy protocol and weak authentication reduction
- Unnecessary service review
- Network hardening registry settings
- Logging and validation steps

### Cloud Migration Readiness

The migration documentation covers:

- Server inventory and dependency mapping
- Application and service validation
- Identity and access considerations
- Backup and rollback planning
- DNS, firewall, and connectivity testing
- Post-migration security validation

### Control Mapping

The documentation maps technical work to security control families such as:

- Access Control
- Audit and Accountability
- Configuration Management
- Identification and Authentication
- System and Communications Protection
- System and Information Integrity

## Example Hardening Script

The PowerShell script is located here:

```text
hardening/windows/scripts/windows_hardening.ps1
```

Example usage:

```powershell
# Run in audit-only mode first
.\windows_hardening.ps1 -ServerType File -ComplianceLevel Medium -AuditOnly

# Apply selected baseline changes after testing
.\windows_hardening.ps1 -ServerType File -ComplianceLevel Medium
```

> Important: Always test hardening changes in a non-production environment first. Some firewall, service, or policy changes may affect business applications.

## Skills Highlighted

- Windows Server Administration
- PowerShell Scripting
- Infrastructure Documentation
- Server Hardening
- Firewall and Port Review
- Audit Policy Configuration
- Cloud Migration Planning
- Risk-Based Security Recommendations
- NIST SP 800-53 Control Mapping
- Technical Writing for IT Operations

## Portfolio Summary

This project reflects my experience working on infrastructure and security tasks that require balancing security improvements with business continuity. The focus was not just applying hardening settings, but documenting why each change matters, how it should be validated, and how it supports a more secure migration path.

## Disclaimer

This repository is for educational and portfolio purposes. It does not contain confidential company information, production server details, or proprietary configuration data.
