# Cloud Migration Runbook

## 1. Before Migration

- Confirm system owner and approval
- Confirm maintenance window
- Confirm backup or snapshot
- Confirm current server configuration
- Confirm DNS records and dependencies
- Confirm firewall rules
- Confirm application testing plan

## 2. During Migration

- Stop or freeze application changes if needed
- Transfer data or deploy workload
- Apply target firewall/security group rules
- Update DNS or routing
- Validate application startup
- Monitor logs and performance

## 3. After Migration

- Test authentication
- Test application workflows
- Test file access or database connectivity
- Confirm monitoring alerts
- Confirm backups
- Document issues and exceptions

## 4. Rollback

Rollback should be performed if critical services fail and cannot be restored within the approved maintenance window.

Rollback steps:

1. Revert DNS or routing
2. Restore previous server or snapshot
3. Validate original service access
4. Notify stakeholders
5. Document root cause before retrying migration
