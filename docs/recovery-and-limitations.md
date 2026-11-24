# 🔄 Incident Recovery, Archive Notice & Research Limitations

> Analysis of Asahi Group Holdings' 4-month operational recovery trajectory, transparent documentation of this repository's archive recovery limitations, methodological boundaries, and future research directions.

---

## 1. Asahi Group Holdings Recovery Analysis (Sept 2025 – Mar 2026)

Unlike organizations that pay ransom demands hoping for rapid decryption, **Asahi Group Holdings refused to pay Qilin's ransom** and executed a ground-up containment, forensic investigation, and clean-environment rebuild.

### Recovery Timeline & Operational Milestones

| Date / Period | Recovery Phase | Key Technical & Operational Actions |
| :--- | :--- | :--- |
| **Sept 29, 2025 (07:00 JST)** | Detection | Simultaneous ransomware encryption detected across Japan data center servers and PCs |
| **Sept 29, 2025 (11:00 JST)** | Containment *(~4h delay)* | Wide-area network isolation initiated; ERP, WMS/TMS, and customer hotlines taken offline; public incident disclosure issued |
| **Early Oct 2025** | Manual Continuity | **300+ sites** switched to paper, fax, and offline Excel workflows; **6 core breweries** resumed manual batch production at **10–25% capacity** |
| **Oct 7–9, 2025** | Extortion Refusal | Qilin posted 29 sample internal images on its dark-web leak site claiming 27 GB stolen; Asahi confirmed no ransom payment |
| **Nov 27, 2025** | Forensic Report #1 | External forensics confirmed initial access via stolen credentials on site network equipment; **1.914M records** flagged for potential exposure |
| **Dec 2025** | Staged Rebuild | Rebuilt core ERP/order infrastructure with hardened controls; domestic production recovered to **70–80%** of pre-attack volume |
| **Feb 18–26, 2026** | Normalization & Audit | Logistics largely normalized (~4 months post-attack); confirmed leaked dataset narrowed to **115,513 records**; official downtime impact reported (~¥5B revenue / ~¥2B profit) |
| **Mar 10, 2026** | Financial Reporting | Delayed Q3 FY2025 financial statements formally filed; select secondary beverage SKUs continued phased catch-up |

### Why Recovery Took Over Four Months

1. **Destruction of Online Recovery Points (`T1490`):** Attackers deleted Volume Shadow Copies (`vssadmin delete shadows /all /quiet`) and tampered with online-reachable backups, preventing rapid snapshot rollback.
2. **Tightly Coupled IT/OT Dependencies:** Because centralized ERP/WMS systems directly fed production schedules and dispatch manifests to 30 factories and 2,000+ trucks, servers could not be reconnected piecemeal without verifying Active Directory and network trust boundaries from scratch.
3. **Forensic Preservation & Clean Rebuild:** Rebuilding domain controllers, replacing compromised perimeter appliances, and deploying new endpoint/Zero-Trust controls across hundreds of domestic sites required sequential validation to prevent re-encryption.

---

## 2. Repository Archive Notice & Artifact Recovery Status

> [!WARNING]
> **Local Workstation Cleanup Incident:** Following completion of the academic demonstration, the local workstation hosting the lab experienced a malware incident during post-lab cleanup. As a precaution and consequence of remediation, all raw VMware virtual disks (`.vmdk`), VM snapshots, PoC source files, and compiled test executables were permanently purged.

To maintain strict research integrity, this repository clearly separates **preserved primary artifacts**, **reconstructed documentation**, and **unrecovered files**:

| Artifact Category | Status | Details in This Repository |
| :--- | :--- | :--- |
| **Recorded Lab Video (`Demo_Full.mp4`)** | ✅ **Preserved (Original)** | [`../demo/Demo_Full.mp4`](../demo/Demo_Full.mp4) — 1m 41s (`1780 × 1080`, 30 fps) end-to-end recording of the VMware simulation |
| **Full Academic Report (`.docx`)** | ✅ **Preserved (Original)** | [`Bao_Cao_ASAHI_BREWERY_CYBERATTACK.docx`](Bao_Cao_ASAHI_BREWERY_CYBERATTACK.docx) — 40-page Vietnamese technical report |
| **Presentation Deck (`.pdf`)** | ✅ **Preserved (Original)** | [`ASAHI_BREWERY_CYBERATTACK_Slides.pdf`](ASAHI_BREWERY_CYBERATTACK_Slides.pdf) — 30+ presentation slides & analytical visuals |
| **Analytical Diagrams (`.png`)** | ✅ **Preserved / Extracted** | [`../diagrams/`](../diagrams/) — 8 high-resolution architecture, MITRE, Risk Matrix, NIST CSF, and impact charts |
| **Lab Commands & `handler.rc`** | 🔄 **Reconstructed** | [`../lab-simulation/lab-walkthrough.md`](../lab-simulation/lab-walkthrough.md) & [`../lab-simulation/handler.rc`](../lab-simulation/handler.rc) — transcribed from `Demo_Full.mp4` and report notes |
| **VMware Snapshots & PoC Binaries** | ❌ **Not Recovered** | Raw `.vmdk`/`.vmx` images and PoC encryptor binaries were lost (and are intentionally excluded via [`.gitignore`](../.gitignore) for safety) |

---

## 3. Research Scope & Methodological Limitations

1. **Reliance on Public Disclosures & Open-Source Threat Intelligence:**
   - Internal forensic artifacts from Asahi Group Holdings (such as raw EDR telemetry, firewall PCAPs, exact CVE/firmware builds of the entry network appliance, and internal Active Directory audit logs) are confidential and not publicly released.
   - Where specific sub-techniques were not itemized in Asahi's public filings (Nov 27, 2025 & Feb 18, 2026), technical analysis maps known, corroborated **Qilin (`G1242` / `S1242`)** affiliate TTPs published by MITRE, Qualys, Check Point Research, and Rescana.
2. **Bounded Lab Simulation Scope:**
   - The VMware lab simulation focused on validating **initial spear-phishing delivery (`T1566.001`)**, **reverse C2 establishment (`T1059` / `T1082`)**, and **endpoint file encryption (`T1486`)** across a two-node (`Kali Linux` ↔ `Windows 10 x64`) topology.
   - Multi-host **Active Directory lateral movement** (`Mimikatz` LSASS dumping, `PsExec` SMB pivoting across domain controllers), **27 GB C2 exfiltration**, and **industrial OT/SCADA PLC disruption** were analyzed theoretically rather than replicated in live multi-subnet hardware.
3. **Financial Estimation Variance:**
   - While Asahi officially disclosed ~¥5B revenue and ~¥2B operating profit impacts from the Q4/FY2025 disruption window, broader multi-year brand switching, delayed product launches, and infrastructure modernization costs (~¥10–15B total estimate) carry standard industry estimation intervals.

---

## 4. Future Research & Engineering Directions

1. **Enterprise AD + Simulated OT Range:** Expand the isolated lab into a multi-subnet cyber range incorporating a Windows Server Domain Controller, SMB file shares, an Industrial DMZ, and an open-source PLC/Modbus simulator (*OpenPLC* / *Conpot*) to test IT/OT containment boundaries.
2. **Detection Engineering (Sigma, YARA & Wazuh/ELK):** Author and benchmark concrete **Sigma** and **YARA** detection rules against simulated obfuscated PowerShell, `vssadmin` shadow deletion, and renamed `PsExec` service creation inside an open-source SIEM/EDR stack (*Wazuh* + *Sysmon*).
3. **AI/ML Behavioral Ransomware Early Warning:** Evaluate file-system entropy/I/O micro-burst models and UEBA off-hours graph anomaly detection to halt encryption before more than a handful of canary files are modified.
4. **Automated SOAR Containment Benchmarking:** Measure Mean Time to Contain (MTTC) reductions using automated host quarantine webhooks versus manual SOC ticket triage.

---

## Related Documentation

- **Lab Environment Details:** [Lab Environment](lab-environment.md)
- **GitHub Publishing Workflow:** [Upload Guide](upload-guide.md)
- **Back to Index:** [Documentation Index](README.md)
