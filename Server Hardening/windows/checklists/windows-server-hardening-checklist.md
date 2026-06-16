# Windows Server Hardening Checklist

## Identity and Access

- [ ] Review local Administrators group
- [ ] Remove unused local accounts
- [ ] Confirm domain groups are role-based
- [ ] Enforce password complexity requirements
- [ ] Configure account lockout policy

## Services

- [ ] Review running services
- [ ] Disable unused legacy services
- [ ] Confirm Print Spooler is needed before leaving enabled
- [ ] Disable Remote Registry unless required
- [ ] Document exceptions

## Firewall and Network

- [ ] Export existing firewall rules
- [ ] Restrict inbound management ports
- [ ] Allow only required application ports
- [ ] Remove broad any/any rules where possible
- [ ] Confirm server-to-server dependencies

## Logging and Audit

- [ ] Enable logon/logoff auditing
- [ ] Enable account management auditing
- [ ] Enable policy change auditing
- [ ] Confirm logs are retained long enough for investigation
- [ ] Confirm logs are forwarded or reviewed

## System Maintenance

- [ ] Confirm patch status
- [ ] Confirm backup status
- [ ] Confirm time synchronization
- [ ] Confirm endpoint protection is active
- [ ] Document baseline configuration
