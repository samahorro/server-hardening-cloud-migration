# Validation Checklist

## Pre-Hardening

- [ ] Confirm server owner
- [ ] Confirm business function
- [ ] Confirm maintenance window
- [ ] Confirm backup or snapshot
- [ ] Export current firewall rules
- [ ] Export current audit policy
- [ ] Document running services
- [ ] Document local administrators

## Hardening Validation

- [ ] Required services still running
- [ ] Required ports still reachable
- [ ] Unnecessary services disabled only after approval
- [ ] Audit policy enabled
- [ ] Security event logs generating events
- [ ] Firewall rules reviewed
- [ ] Remote administration restricted to approved methods
- [ ] Password/account lockout policy reviewed

## Post-Migration Validation

- [ ] Application opens successfully
- [ ] Required users can authenticate
- [ ] Required file shares are accessible
- [ ] DNS resolves correctly
- [ ] Backups are configured
- [ ] Monitoring is active
- [ ] Security logs are visible
- [ ] Rollback plan documented
