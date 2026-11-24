# 🖥️ VMware Workstation Lab Setup Guide

> Step-by-step instructions to build an **air-gapped VMware Workstation Host-Only laboratory** from scratch for safely reproducing the educational Spear-Phishing & C2 simulation documented in [`lab-environment.md`](lab-environment.md) and [`../lab-simulation/lab-walkthrough.md`](../lab-simulation/lab-walkthrough.md).

> [!CAUTION]
> **Mandatory Isolation Rule:** Never attach the Attacker or Victim VM to **Bridged** or **NAT** mode while generating or testing payloads. All steps below use an isolated **Host-Only (`VMnet1`)** virtual switch with no external gateway so traffic cannot leave the virtual subnet.

---

## 1. Host Prerequisites

| Requirement | Minimum Specification | Recommended Specification |
| :--- | :--- | :--- |
| **Hypervisor** | VMware Workstation Pro / Player 17+ | VMware Workstation Pro 17.5+ *(supports Snapshots & Virtual Network Editor)* |
| **Host CPU & RAM** | 4 cores / 8 GB RAM | 8+ cores / 16 GB RAM |
| **Free Disk Space** | 60 GB SSD | 100+ GB NVMe SSD |
| **Attacker Image** | Kali Linux 2025.x / 2026.x Pre-built VMware VM or ISO | Official Kali Linux VMware image (`kali.org`) |
| **Victim Image** | Windows 10 22H2 x64 Evaluation ISO | Windows 10 Enterprise Evaluation x64 (Build 19045) |

---

## 2. Configure the Isolated Host-Only Network (`192.168.23.0/24`)

1. Open **VMware Workstation Pro** as Administrator and navigate to **Edit → Virtual Network Editor** *(click **Change Settings** if prompted for UAC elevation)*.
2. Select **`VMnet1`** and configure the following settings:
   - **VMnet Information:** Select **Host-only (connect VMs internally in a private network)**
   - **Connect a host virtual adapter to this network:** *Uncheck* (recommended for strict host isolation) or firewall `VMware Network Adapter VMnet1` on the physical host
   - **Use local DHCP service to distribute IP address to VMs:** *Checked*
   - **Subnet IP:** `192.168.23.0`
   - **Subnet Mask:** `255.255.255.0`
3. Click **DHCP Settings...** and verify the DHCP range covers `192.168.23.128` – `192.168.23.254` (matching the lab addresses `.130` and `.141`).
4. Click **Apply** and **OK**.

---

## 3. Provision Virtual Machine 1 — Kali Linux (Attacker)

1. Import the official Kali Linux `.vmx` appliance (or install from ISO) with:
   - **Memory:** 2–4 GB RAM
   - **Processors:** 2 vCPUs
   - **Network Adapter:** **Custom: Specific virtual network → `VMnet1 (Host-only)`** *(or select **Host-only**)*
   - Remove any secondary network adapters, shared folders, and drag-and-drop/copy-paste integration with the physical host (`VM → Settings → Options → Guest Isolation → Uncheck Enable drag and drop / Enable copy and paste`).
2. Boot Kali Linux and configure or verify IP `192.168.23.130`:
   ```bash
   # Check assigned IP on eth0
   ip -4 addr show eth0

   # (Optional) Assign static IP 192.168.23.130/24 if DHCP assigns a different address
   sudo ip addr flush dev eth0
   sudo ip addr add 192.168.23.130/24 dev eth0
   sudo ip link set eth0 up
   ```
3. Verify required simulation tools are present on Kali:
   ```bash
   msfvenom --version
   msfconsole --version
   ```
4. Copy [`../lab-simulation/handler.rc`](../lab-simulation/handler.rc) (or recreate its 6 lines) inside `/home/kali/lab/handler.rc`.

---

## 4. Provision Virtual Machine 2 — Windows 10 x64 (Victim)

1. Create a new VM from the Windows 10 x64 ISO:
   - **Memory:** 4 GB RAM
   - **Processors:** 2 vCPUs
   - **Hard Disk:** 40 GB (split into multiple files)
   - **Network Adapter:** **`VMnet1 (Host-only)`**
   - **Guest Isolation:** Disable **Shared Folders**, **Drag and Drop**, and **Copy and Paste** to protect the host OS.
2. Complete offline Windows 10 setup (*"I don't have internet"* → local account).
3. Verify or set IP `192.168.23.141` in **Command Prompt (Admin)**:
   ```cmd
   netsh interface ip set address name="Ethernet0" static 192.168.23.141 255.255.255.0
   ipconfig
   ```
4. Create synthetic non-sensitive dummy files on `Desktop` to observe encryption behavior safely:
   ```powershell
   cd $env:USERPROFILE\Desktop
   "Sample logistics order manifest" | Out-File TaiLieu.txt -Encoding utf8
   "Dummy quarterly report"          | Out-File BaoCao.docx -Encoding utf8
   "Dummy warehouse inventory"       | Out-File DuLieu.xlsx -Encoding utf8
   "Dummy carrier invoice"           | Out-File HoaDon.pdf  -Encoding utf8
   "Dummy CAD layout"                | Out-File ThietKe.dwg -Encoding utf8
   ```
5. *(Lab-only configuration)* If demonstrating raw un-evaded `msfvenom` payloads for classroom visualization, configure controlled lab exclusions inside the isolated VM only **after** verifying complete network isolation in Section 5.

---

## 5. Verify Connectivity & Air-Gap Isolation

Run both checks before starting any simulation step:

1. **Internal Host-Only Reachability (Must Succeed):**
   - From Kali (`192.168.23.130`):
     ```bash
     ping -c 3 192.168.23.141
     ```
2. **External Internet Isolation (Must Fail):**
   - From both Kali and Windows 10:
     ```bash
     ping -c 2 8.8.8.8
     # Expected: "Network is unreachable" / 100% packet loss
     ```

> [!IMPORTANT]
> If `ping 8.8.8.8` replies on either VM, **STOP IMMEDIATELY** and re-check VMware adapter settings in Section 2 before generating any payload.

---

## 6. Take Clean Baseline Snapshots & Post-Lab Teardown

1. **Before running the simulation:** Shut down or pause both VMs and take a clean snapshot in VMware Workstation (`VM → Snapshot → Take Snapshot...` → name: `00-Clean-Isolated-Baseline`).
2. **Follow the simulation walkthrough:** Execute the steps documented in [`../lab-simulation/lab-walkthrough.md`](../lab-simulation/lab-walkthrough.md).
3. **Safe Post-Lab Cleanup:**
   - Revert both VMs directly to `00-Clean-Isolated-Baseline` (`VM → Snapshot → Revert to Snapshot`) rather than copying artifacts out to the host machine.
   - Never transfer `.exe` payloads or encrypted artifacts from the guest VMs onto your physical workstation.

---

## Related Documentation

- **Lab Topology & Demo Evidence:** [Lab Environment](lab-environment.md)
- **Simulation Commands & `handler.rc`:** [`../lab-simulation/lab-walkthrough.md`](../lab-simulation/lab-walkthrough.md)
- **Post-Lab Incident Lessons:** [Recovery & Limitations](recovery-and-limitations.md)
- **Back to Index:** [Documentation Index](README.md)
