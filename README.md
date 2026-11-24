# Asahi Brewery Cyberattack — Case Study & Lab Demonstration

**Cybersecurity case study | Ransomware analysis | MITRE ATT&CK | NIST CSF 2.0 | VMware lab PoC**

> This repository is a **reconstructed project portfolio** based on the materials that remained after the original workstation was affected by malware. It is not a complete recovery of the original development environment.

## Repository recovery notice

The computer that stored the original project was infected by malware. After the incident, the original working files and development materials could not be recovered. The remaining materials are:

- The project report (DOCX).
- The presentation slides (PDF).
- A recorded lab demonstration (MP4).

The original source files, scripts, VMware snapshots, detailed network settings, and configuration exports are not available in this recovery copy. The repository is therefore organized around the surviving evidence and clearly labels any new infrastructure material as a **proposal**, not as an implementation that has already been completed.

## Project overview

This academic project studies the ransomware incident involving Asahi Group Holdings described in the submitted report and presentation. It examines the incident from a cybersecurity perspective, reconstructs a high-level attack chain, maps selected behaviors to MITRE ATT&CK, evaluates business and security impact, and proposes defensive improvements.

A separate recorded demonstration shows a small VMware lab with Kali Linux and Windows 10 x64. The video includes a logistics-invoice-themed phishing scenario and a custom ransomware proof-of-concept (PoC) that displays file-encryption/system-lockdown behavior. This is an **educational lab demonstration**; it is not Qilin's original malware and is not a reproduction of Asahi's production network.

## Objectives

1. Describe the business and IT/OT context of the Asahi case study.
2. Analyze the reported attack lifecycle from reconnaissance through ransomware impact.
3. Map selected techniques to MITRE ATT&CK.
4. Assess confidentiality, integrity, and availability using the CIA Triad.
5. Prioritize risks with a likelihood-impact matrix.
6. Evaluate security gaps using NIST Cybersecurity Framework (CSF) functions.
7. Recommend layered controls for identity, endpoint, network, monitoring, incident response, and recovery.
8. Preserve the surviving report, slides, and demonstration in one organized repository.

## What the demonstration shows

The submitted 1 minute 41 second recording visibly shows:

- VMware Workstation with Kali Linux and Windows 10 x64 virtual machines.
- A Kali-side demonstration workflow using Metasploit tooling.
- A logistics/shipping-invoice-themed phishing email scenario.
- A Windows-side custom PoC screen illustrating simulated file encryption and system-lockdown behavior.

The recording is evidence of a controlled demonstration workflow only. It does not prove that the same tools, indicators, steps, or infrastructure were used inside Asahi. Do not run the PoC outside an isolated lab.

## Analysis scope

### High-level attack chain

| Stage | Activity described in the report | Security concern |
|---|---|---|
| 1. Reconnaissance | Public-source discovery and identification of relevant IT/logistics roles | Exposure of organizational information |
| 2. Initial access | Logistics-themed spear-phishing / credential-harvesting scenario | User awareness, email security, identity protection |
| 3. Execution | User-triggered execution and scripting activity | Endpoint protection and application control |
| 4. Lateral movement | Use of remote administration paths and shared services | Flat networks, credential hygiene, privileged access |
| 5. Impact | Ransomware deployment and attempted impairment of recovery | Availability, backup isolation, incident response |

This is the report's analytical reconstruction from public material and threat-intelligence references, not an independently verified forensic timeline from Asahi's internal systems.

### Frameworks used

- **MITRE ATT&CK:** technique mapping for phishing, execution, credential access, remote services, defense evasion, exfiltration, and impact.
- **CIA Triad:** confidentiality, integrity, and availability impact.
- **Risk Matrix:** 5 × 5 likelihood-versus-impact prioritization.
- **NIST CSF 2.0:** Identify, Protect, Detect, Respond, Recover, and Govern.
- **Defense-in-Depth:** endpoint, network, identity, monitoring, and recovery layers.

See the detailed notes in the **docs/** directory, including the proposed VMnet/VLAN architecture and the step-by-step VMware Workstation rebuild guide.

## Lab environment: evidence and boundaries

### Confirmed in the surviving materials

| Component | Evidence |
|---|---|
| Hypervisor | VMware Workstation is visible in the video |
| Red-team VM | Kali Linux is visible in the video |
| Target VM | Windows 10 x64 is visible in the video |
| Demonstration | A phishing-themed scenario and custom ransomware PoC are visible |

### Not recoverable / not verified

The surviving materials do not establish the original VM CPU/RAM allocations, IP addresses, subnet, VMware network mode, VLAN IDs, virtual switch configuration, firewall rules, Windows security policy, logging pipeline, or backup configuration. These values are intentionally not invented.

A proposed segmented lab design is documented separately in **docs/proposed-infrastructure.md**. It is a future/reference design, not a claim about the original lab.

## Repository structure

After the remaining assets are uploaded, the repository is intended to contain:

~~~text
asahi-brewery-cyberattack-analysis/
├── README.md
├── docs/
│   ├── attack-chain-and-mitre.md
│   ├── lab-environment.md
│   ├── proposed-infrastructure.md
│   ├── vmware-workstation-setup.md
│   ├── risk-assessment.md
│   ├── recovery-and-limitations.md
│   └── upload-guide.md
├── reports/
│   └── BaoCao_ASAHI_BREWERY_CYBERATTACK.docx
├── presentations/
│   └── ASAHI_BREWERY_CYBERATTACK.pdf
└── demo/
    └── Asahi_Cyberattack_Lab_Demo.mp4
~~~

## Deliverables

| Artifact | Repository path | Purpose |
|---|---|---|
| Project report (DOCX) | [reports/BaoCao_ASAHI_BREWERY_CYBERATTACK.docx](reports/BaoCao_ASAHI_BREWERY_CYBERATTACK.docx) | Full written case study and analysis |
| Presentation (PDF) | [presentations/ASAHI_BREWERY_CYBERATTACK.pdf](presentations/ASAHI_BREWERY_CYBERATTACK.pdf) | Summary of the research, findings, risk assessment, and recommendations |
| Demo recording (MP4) | [demo/Asahi_Cyberattack_Lab_Demo.mp4](demo/Asahi_Cyberattack_Lab_Demo.mp4) | Visual evidence of the educational VMware lab demonstration |
| Documentation (Markdown) | [docs/](docs/) | Scope, lab evidence, infrastructure proposal, and limitations |

The three binary paths are prepared in this repository. Upload the surviving local files using [docs/upload-guide.md](docs/upload-guide.md) to make the links above active.

## Key defensive recommendations

- Enforce phishing-resistant MFA for remote access and privileged accounts.
- Use EDR/NGAV with centralized telemetry and alerting.
- Apply least privilege and privileged access management.
- Segment IT, OT, user, management, and backup networks.
- Monitor suspicious PowerShell, remote service use, and unusual outbound transfers.
- Maintain immutable/offline backups and test restoration regularly.
- Prepare and exercise ransomware incident-response and business-continuity playbooks.

## Limitations and responsible use

- This is an academic case study based on public information and the team's submitted materials. It is not an official Asahi forensic report.
- Some incident details in the source documents are estimates, analytical assumptions, or time-dependent figures. Read them with the publication date and source context.
- The report's limitations section says that a practical attack simulation had not been performed, while the separate surviving video shows a lab PoC. This repository treats the video as a supplementary demonstration artifact and does not present it as a reproduction of the real incident.
- The original source code and detailed lab configuration were not recovered.
- The demonstration is for education in an isolated, authorized environment only. Do not execute payloads or test against third-party systems.

## Project team

The original report lists the following student contributors:

- Tiêu Hoàng Phúc
- Nguyễn Nam Trường
- Nguyễn Phú Đạt

Instructor: ThS. Phan Đình Duy Thông  
Institution: Ho Chi Minh City University of Technology (HUTECH)  
Original report/presentation: 2025

---

**Recovery status:** documentation structure initialized; surviving binary artifacts still need to be uploaded. See **docs/upload-guide.md** for the exact filenames and steps.
