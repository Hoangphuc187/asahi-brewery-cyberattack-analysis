# 🧪 Lab Environment

This document describes the isolated laboratory environment used to demonstrate the spear-phishing delivery, reverse-shell command-and-control (C2), and file encryption workflow associated with the Asahi Brewery cyberattack case study. To preserve academic accuracy, it explicitly distinguishes between direct visual observations from the supplied demo recording and reconstructed configuration details that were not recovered.

## Evidence visible in the demo

The supplied MP4 is approximately 1 minute 41 seconds long, 1780 × 1080 pixels, and 30 frames per second.

| Item | Observation |
| :--- | :--- |
| Virtualization platform | VMware Workstation |
| Virtual machine 1 | Kali Linux |
| Virtual machine 2 | Windows 10 x64 |

> [!NOTE]
> **Archive limitation:** Due to a local workstation malware incident during post-lab cleanup, the original VMware `.vmx`/`.vmdk` snapshots, PoC source scripts, and compiled binaries were purged. Configuration details not directly visible as host-level metadata are documented below as **reconstructed** from [`../demo/Demo_Full.mp4`](../demo/Demo_Full.mp4) and the final project report.

---

## Reconstructed Lab Topology

All simulation activities were performed inside an isolated **VMware Host-Only** virtual network (`192.168.23.0/24`) with no external internet routing, NAT, or bridged adapters enabled.

```
╔═══════════════════════════════════════════════════════════════╗
║                  VMware Host-Only Network                     ║
║                   192.168.23.0/24 (Isolated)                  ║
║                                                               ║
║   ┌───────────────────┐         ┌───────────────────────┐     ║
║   │  ATTACKER         │         │  VICTIM               │     ║
║   │  Kali Linux       │◄───────►│  Windows 10 x64       │     ║
║   │  192.168.23.130   │  TCP    │  192.168.23.141       │     ║
║   │                   │  :4444  │  DESKTOP-4K30A40      │     ║
║   │  Tools:           │         │  User: ACERNITRO      │     ║
║   │  - msfvenom       │         │                       │     ║
║   │  - msfconsole     │         │  Target Desktop Data: │     ║
║   │  - sendEmail      │         │  - TaiLieu.txt        │     ║
║   └───────────────────┘         │  - *.docx, *.xlsx     │     ║
║                                 │  - *.pdf, *.dwg       │     ║
║                                 └───────────────────────┘     ║
╚═══════════════════════════════════════════════════════════════╝
```

### Node Roles & Addressing

| Node | OS / Build | Reconstructed IP | Hostname / User | Role in Simulation |
| :--- | :--- | :--- | :--- | :--- |
| **Attacker VM** | Kali Linux | `192.168.23.130` | `kali` | Generates disguised executable via `msfvenom`, delivers phishing invoice email, runs `exploit/multi/handler` C2 listener on TCP port `4444` |
| **Victim VM** | Windows 10 x64 (Build 19045) | `192.168.23.141` | `DESKTOP-4K30A40` / `ACERNITRO` | Receives spear-phishing email, executes disguised attachment, opens reverse Meterpreter session (`:59860` → `:4444`), undergoes Desktop file encryption |
| **Virtual Switch** | VMware Host-Only (`VMnet1`) | `192.168.23.0/24` | — | Air-gapped L2/L3 segment preventing accidental egress to LAN or Internet |

---

## Simulation Workflow Summary

| Phase | MITRE Technique | Activity in Lab | Artifacts |
| :--- | :--- | :--- | :--- |
| **1. Payload Creation** | `T1027`, `T1036.007` | `msfvenom` creates `windows/meterpreter/reverse_tcp` payload encoded with `x86/shikata_ga_nai` (5 iterations) and double-extension disguise | `File_hoa_don_chuyen_khoan_2026.pdf.exe` *(not retained in repo)* |
| **2. C2 Listener** | `T1071`, `T1095` | `msfconsole -r handler.rc` starts background listener on `192.168.23.130:4444` | [`../lab-simulation/handler.rc`](../lab-simulation/handler.rc) |
| **3. Spear-Phishing** | `T1566.001` | Fake logistics invoice email (`[URGENT] Invoice #AS-99281 — Global Logistics Services`) sent to victim | Visible in [`../demo/Demo_Full.mp4`](../demo/Demo_Full.mp4) |
| **4. Execution & C2** | `T1204.002`, `T1082`, `T1059` | Victim opens attachment → Meterpreter session established → `sysinfo` and interactive `cmd.exe` shell | Reconstructed in [`../lab-simulation/lab-walkthrough.md`](../lab-simulation/lab-walkthrough.md) |
| **5. Ransomware Impact** | `T1486` | PoC encryptor appends `.encrypted` to `.txt`, `.docx`, `.xlsx`, `.pdf`, `.dwg` files on Desktop and displays lock-screen ransom UI | Visible in [`../demo/Demo_Full.mp4`](../demo/Demo_Full.mp4) |

---

## Safety & Isolation Controls

1. **Strict Network Air-Gap:** Both virtual machines were attached exclusively to a Host-Only network (`VMnet1`) without default gateway or DNS forwarding to the physical host's internet connection.
2. **Synthetic Test Data Only:** All encrypted files on the Windows 10 Desktop (`TaiLieu.txt`, `BaoCao.docx`, `DuLieu.xlsx`, `HoaDon.pdf`, `ThietKe.dwg`) were dummy sample files containing no real personal or corporate data.
3. **No Live Malware Binaries Distributed:** In accordance with ethical research standards and GitHub Acceptable Use Policies, `.exe`, `.dll`, and raw VM disk images (`.vmdk`) are excluded via [`.gitignore`](../.gitignore).

---

## Related Documentation

- **Step-by-Step VMware Lab Setup:** [VMware Workstation Setup](vmware-workstation-setup.md)
- **Commands & Execution Walkthrough:** [`../lab-simulation/lab-walkthrough.md`](../lab-simulation/lab-walkthrough.md)
- **Archive & Scope Limitations:** [Recovery & Limitations](recovery-and-limitations.md)
- **Back to Index:** [Documentation Index](README.md)
