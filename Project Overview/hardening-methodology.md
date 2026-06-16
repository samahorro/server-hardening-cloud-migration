# Hardening Methodology

## 1. Discovery

The first phase focuses on understanding the current state of the server.

Common review items:

- Operating system version and patch level
- Installed roles and features
- Running services
- Local administrators
- Firewall rules
- Open ports
- Authentication settings
- Audit policy
- Application dependencies

## 2. Risk Review

Each finding should be reviewed based on risk and business impact.

Example categories:

| Category | Example Risk | Example Action |
|---|---|---|
| Unneeded services | Increased attack surface | Disable service after validation |
| Weak authentication | Credential exposure | Enforce stronger policy |
| Missing logging | Reduced visibility | Enable audit policy |
| Broad firewall rules | Unauthorized access | Restrict source/destination |
| Unknown dependencies | Migration failure | Document and test |

## 3. Implementation

Hardening should be applied in stages:

1. Test changes in a non-production environment
2. Back up configuration or create restore points
3. Apply one category of change at a time
4. Validate server functionality
5. Document results and exceptions

## 4. Validation

Validation confirms that security improvements did not break required business functions.

Validation examples:

- Confirm required services still start
- Confirm users can access required shares or applications
- Confirm logging is being generated
- Confirm firewall rules allow only expected traffic
- Confirm administrative access still works through approved channels

## 5. Documentation

Every major change should include:

- What changed
- Why it changed
- Risk reduced
- Systems affected
- Validation performed
- Rollback option
- Remaining exceptions
