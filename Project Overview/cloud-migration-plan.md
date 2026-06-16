# Cloud Migration Plan

## Migration Goals

- Move workloads to a more controlled and scalable environment
- Preserve application functionality
- Reduce unmanaged infrastructure risk
- Improve documentation of dependencies
- Align server access and logging with security expectations

## Pre-Migration Checklist

- Identify server role and owner
- Document applications and dependencies
- Document required ports and firewall rules
- Review local and domain groups
- Confirm backup status
- Confirm DNS records
- Identify scheduled tasks and services
- Review storage and file share requirements
- Identify authentication dependencies

## Migration Phases

### Phase 1: Assessment

- Inventory servers and applications
- Identify dependencies
- Review security baseline
- Define success criteria

### Phase 2: Preparation

- Apply hardening where appropriate
- Confirm backups and rollback plan
- Prepare target cloud or hybrid resources
- Configure access control and monitoring

### Phase 3: Migration

- Move data or workloads
- Update DNS or routing
- Validate application access
- Monitor performance and logs

### Phase 4: Post-Migration Validation

- Confirm users can access required services
- Confirm logs are being collected
- Confirm firewall rules are restricted
- Confirm backups are running
- Confirm old infrastructure is decommissioned safely

## Rollback Considerations

A rollback plan should include:

- Trigger conditions for rollback
- Known-good backup or snapshot
- DNS rollback steps
- Application owner contact
- Validation checklist after rollback
