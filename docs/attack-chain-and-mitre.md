# Attack Chain and MITRE ATT&CK Mapping

## Scope note

This document summarizes the attack-chain analysis and technique table in the submitted Asahi project report. It should be read as an **academic reconstruction based on public reporting and threat-intelligence references**, not as a validated list of every action observed in Asahi's internal telemetry.

## Five-stage attack chain

### Stage 1 — Reconnaissance

The report describes public-source intelligence gathering to identify relevant employees and roles in IT, network administration, logistics, and operations.

**Security lessons**
- Reduce unnecessary public exposure of employee roles and internal technology details.
- Review public documents and metadata for information leakage.
- Train employees to recognize targeted social-engineering attempts.

### Stage 2 — Initial access

The report analyzes a logistics-partner-themed spear-phishing scenario. The lure is framed as an invoice or delivery notification, with a malicious attachment or credential-harvesting link.

**Security lessons**
- Deploy email authentication and anti-phishing controls.
- Detonate suspicious attachments in a sandbox.
- Use phishing-resistant MFA and monitor for credential reuse.
- Provide role-specific awareness training to finance, logistics, and IT teams.

### Stage 3 — Execution

The report discusses user-triggered execution and script-based activity, including PowerShell. The accompanying demo video shows a separate lab workflow, not the real malware used against Asahi.

**Security lessons**
- Apply application control and script restrictions.
- Enable PowerShell logging and centralized endpoint telemetry.
- Use EDR behavior detection rather than relying only on static signatures.

### Stage 4 — Lateral movement

The report describes remote administration paths and SMB/RDP-related movement as part of the reconstructed scenario.

**Security lessons**
- Segment networks and restrict east-west traffic.
- Require privileged access controls for remote administration.
- Use unique administrative credentials and just-in-time access.
- Alert on unusual remote service use and authentication patterns.

### Stage 5 — Impact and recovery inhibition

The report describes ransomware impact, data encryption, and attempts to impair recovery by targeting backup or shadow-copy mechanisms.

**Security lessons**
- Keep recovery credentials separate from normal domain administration.
- Maintain immutable and offline recovery copies.
- Test clean restoration and business-continuity procedures.
- Isolate affected endpoints and network segments early in an incident.

## Technique mapping in the submitted report

The report includes the following ATT&CK technique mappings. The mapping is preserved here as the project's analysis; it is not an assertion that every technique has been independently confirmed in the incident.

| Tactic area | Technique | Name | How the report applies it |
|---|---|---|---|
| Initial Access | T1566.001 | Spearphishing Attachment | Logistics-themed email with a malicious attachment scenario |
| Initial Access | T1566.002 | Spearphishing Link | Link to a fake login / credential-harvesting page |
| Initial Access | T1078.002 | Valid Accounts: Domain Accounts | Use of valid domain credentials in the reconstructed scenario |
| Execution | T1204.002 | User Execution: Malicious File | User opens a file that triggers execution |
| Execution | T1059.001 | Command and Scripting Interpreter: PowerShell | PowerShell script execution |
| Persistence | T1547.001 | Registry Run Keys / Startup Folder | Reported persistence technique in the mapping table |
| Persistence | T1053.005 | Scheduled Task/Job: Scheduled Task | Reported scheduled-task persistence technique |
| Privilege Escalation / Credential Access | T1003.001 | OS Credential Dumping: LSASS Memory | Credential-dumping technique discussed in the report |
| Lateral Movement | T1021.002 | SMB/Windows Admin Shares | Remote service use over SMB |
| Lateral Movement | T1021.001 | Remote Desktop Protocol | Remote desktop access |
| Defense Evasion | T1562.001 | Impair Defenses: Disable or Modify Tools | Disabling or modifying endpoint defenses |
| Impact / Recovery | T1490 | Inhibit System Recovery | Attempts to remove or impair recovery mechanisms |
| Exfiltration | T1041 | Exfiltration Over C2 Channel | Data transfer over a command-and-control channel |
| Impact | T1486 | Data Encrypted for Impact | Ransomware encryption behavior |
| Impact | T1499 | Endpoint Denial of Service | Availability impact discussed in the report |

For authoritative technique definitions, consult the MITRE ATT&CK knowledge base: https://attack.mitre.org/

## Relationship to the demonstration video

The surviving video is approximately 101 seconds long and visibly shows VMware Workstation with Kali Linux and Windows 10 x64. It includes a logistics-themed email scenario and a custom ransomware PoC screen.

The video should be described as a **controlled proof-of-concept demonstration**. It is not proof that Asahi's real attacker used the same payload, exact command sequence, or lab configuration.

## Suggested detection opportunities

| Activity | Defensive telemetry to review |
|---|---|
| Phishing and suspicious attachments | Secure email gateway logs, URL reputation, attachment sandbox events |
| Unusual script execution | EDR process telemetry, PowerShell logging, script-block events |
| Credential access attempts | EDR alerts, privileged-account audit events |
| SMB/RDP lateral movement | Windows logon events, firewall flows, network detection telemetry |
| Defense impairment | EDR tamper alerts, service changes, security-policy changes |
| Data exfiltration | DNS/proxy/firewall logs, unusual outbound volume, DLP alerts |
| Recovery inhibition | Backup platform audit logs, snapshot deletion alerts, storage immutability events |

## References listed in the submitted report

- MITRE ATT&CK: https://attack.mitre.org/
- NIST Cybersecurity Framework: https://www.nist.gov/cyberframework
- Lockheed Martin Cyber Kill Chain: https://www.lockheedmartin.com/en-us/capabilities/cyber/cyber-kill-chain.html
- Qualys Qilin ransomware analysis: https://blog.qualys.com/vulnerabilities-threat-research/2025/10/qilin-ransomware
- The Japan Times article listed in the report: https://www.japantimes.co.jp/business/2025/10/10/asahi-beer-shortage-ransomware/

The list above reflects references recorded in the submitted report. Re-check the original sources before reusing incident figures in a formal publication.
