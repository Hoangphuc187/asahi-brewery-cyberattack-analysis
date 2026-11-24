# Lab Environment — Surviving Evidence

## Purpose

This document records what can be supported by the surviving demo recording and project materials. It separates visible evidence from configuration details that were not recovered.

## Evidence visible in the demo

The supplied MP4 is approximately 1 minute 41 seconds long, 1780 × 1080 pixels, and 30 frames per second.

| Item | Observation |
|---|---|
| Virtualization platform | VMware Workstation |
| Virtual machine 1 | Kali Linux |
| Virtual machine 2 | Windows 10 x64 |
| Red-team tooling | Metasploit tooling is visible in the Kali-side terminal |
| Scenario | A logistics/shipping-invoice-themed email |
| Target-side outcome | A custom PoC screen illustrating simulated file encryption / system lockdown |

**Original demo:** [Watch the lab recording](https://drive.google.com/file/d/1euM46GtrGGJ4G-XNy_ITC11I61_uqxKK/view)

## Known versus unknown configuration

| Configuration item | Status |
|---|---|
| VMware Workstation | Visible |
| Kali Linux VM | Visible |
| Windows 10 x64 VM | Visible |
| VM CPU / RAM / disk allocation | Not recovered |
| VMware network mode (Host-only / NAT / Bridged) | Not confirmed by the recording |
| IP addressing and subnet | Not recovered |
| VLAN IDs and virtual-switch layout | Not recovered |
| Firewall rules between VMs | Not recovered |
| Windows local security policy | Not recovered |
| Central logging / SIEM configuration | Not shown |
| Backup destination, schedule, and restore test | Not recovered |
| Original VM snapshots or exported VM files | Not available in the recovery set |

Do not fill the unknown fields with guessed values. If original screenshots, VM settings, or notes are later recovered, update this document and identify the evidence used.

## Demonstration workflow at a high level

1. Start the VMware lab and review the Kali Linux and Windows 10 x64 guests.
2. Prepare the educational phishing-themed scenario.
3. Use the lab tooling to demonstrate the controlled test workflow.
4. Observe the Windows-side PoC behavior and the simulated lockdown screen.
5. Stop the demonstration and restore the lab from a known-clean state.

This is a high-level description only. The original scripts and exact commands were not recovered.

## Safety boundaries

- Use only virtual machines that you own or are explicitly authorized to test.
- Keep the lab isolated from home, school, and corporate networks.
- Prefer VMware Host-only networking for a fully contained lab.
- Do not use Bridged mode for malware or ransomware demonstrations.
- Disable shared folders, clipboard sharing, drag-and-drop, and unnecessary host integration during testing.
- Take a clean VM snapshot before each exercise.
- Do not use real customer data, real credentials, or real third-party email accounts.
- Do not upload executable payloads or ransomware samples to this repository.

## Recommended evidence to add if the lab is rebuilt

- VMware VM settings screenshots (vCPU, RAM, disk, firmware, virtual NICs).
- Virtual Network Editor screenshots showing VMnet mode and subnet.
- IP configuration from each guest.
- A network diagram showing permitted flows.
- Firewall policy export or screenshots.
- Windows event logging and endpoint-security settings.
- Backup / snapshot procedure and a successful restore-test record.
- A short test log containing test date, objective, expected result, and observed result.

Never publish secrets, live credentials, public IPs, personal data, or unredacted logs.
