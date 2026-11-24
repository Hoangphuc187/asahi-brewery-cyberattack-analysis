# Risk Assessment and Defensive Recommendations

## 1. CIA Triad assessment

The submitted report evaluates the incident's impact as follows. The ratings below reflect the project's analysis, not an independent forensic audit.

| CIA property | Project rating | Analysis in the report |
|---|---|---|
| Confidentiality | High | Data exfiltration and disclosure risk |
| Integrity | Medium | Backup/log trust concerns; the report says direct integrity damage was less prominent |
| Availability | Critical | Production and logistics disruption were treated as the most severe business impact |

The report emphasizes that availability was the most significant operational consequence because order processing, logistics, and production depend on connected IT/OT services.

## 2. Risk register summary

| Threat | Main weakness identified in the report | Project risk rating | Priority control |
|---|---|---|---|
| Phishing / spear-phishing | Limited awareness and weak email filtering | High | Email security, attachment sandboxing, user training, phishing-resistant MFA |
| Credential theft | Password reuse and insufficient privileged-access controls | High | FIDO2/WebAuthn, PAM, credential monitoring |
| Malware execution | Insufficient endpoint behavior detection | Critical | EDR/NGAV, application control, script logging |
| Lateral movement | Flat network and excessive remote access | High | Micro-segmentation, least privilege, restrict SMB/RDP |
| Ransomware deployment | Backup not sufficiently isolated and network segmentation gaps | Critical | Immutable/offline backup, EDR, network isolation |
| Data exfiltration | Limited outbound data-loss monitoring | High | DLP, outbound traffic monitoring, encryption, alerting |

## 3. NIST CSF mapping

The submitted report uses the six NIST CSF 2.0 Functions.

| Function | Assessment in the report | Recommended improvement |
|---|---|---|
| Identify | Inventory exists, but remote-access and network-equipment risks need deeper assessment | Maintain asset inventory, business criticality, and recurring risk reviews |
| Protect | Weak identity and segmentation controls are identified | Strong MFA, PAM, least privilege, patch management, micro-segmentation |
| Detect | Monitoring and anomaly detection are treated as weak | EDR, SIEM, UEBA, centralized logs, tested alert rules |
| Respond | Initial containment is described as delayed | Ransomware playbooks, tabletop exercises, clear incident roles |
| Recover | Backup isolation and restore readiness are identified as weaknesses | Immutable/offline backups, restore drills, business-continuity plans |
| Govern | Policy execution and awareness are described as needing improvement | Security ownership, recurring audits, training, executive risk reporting |

NIST CSF reference: https://www.nist.gov/cyberframework

## 4. Defense-in-Depth proposal

The report proposes five defensive layers:

| Layer | Defensive focus | Example controls |
|---|---|---|
| 1. Endpoint | Prevent and detect malicious endpoint behavior | EDR, NGAV, application control |
| 2. Network | Reduce reachability and lateral movement | Next-generation firewall, IDS/IPS, segmentation |
| 3. Identity | Prevent credential abuse | MFA, PAM, least privilege, credential rotation |
| 4. Monitoring | Detect and investigate abnormal behavior | SIEM, SOAR, threat intelligence, centralized logs |
| 5. Recovery | Restore clean services after an incident | Immutable backup, offline copy, disaster-recovery site |

## 5. Practical priorities

### Priority 1 — Protect identity and endpoints
- Require phishing-resistant MFA for remote access and privileged accounts.
- Remove shared administrator accounts and enforce least privilege.
- Deploy EDR with tamper protection and centralized alerting.
- Restrict script execution where it is not required.

### Priority 2 — Limit lateral movement
- Separate user, server, management, OT, and backup zones.
- Deny unnecessary SMB/RDP paths between segments.
- Use privileged access workstations or controlled admin jump hosts.
- Review firewall rules and remote-access entitlements regularly.

### Priority 3 — Improve detection and response
- Centralize Windows, endpoint, identity, firewall, and backup logs.
- Alert on suspicious PowerShell, unusual remote logons, security-tool tampering, and abnormal outbound traffic.
- Maintain a ransomware incident-response playbook.
- Run tabletop exercises and record lessons learned.

### Priority 4 — Make recovery resilient
- Maintain immutable or offline backups.
- Use separate backup credentials and administrative boundaries.
- Test restoration regularly, including application-level validation.
- Document manual operating procedures for critical business processes.

## 6. Limitations

The risk ratings depend on the assumptions and evidence described in the team's report. The original repository, internal telemetry, and recovered system configurations are not available in this recovery copy. Treat ratings as a case-study assessment and validate incident-specific assertions against the original cited sources before making external claims.
