# VMware Workstation Lab Setup — Rebuild Guide

> This guide is a **future rebuild procedure**, not a record of the lost original network configuration. The actual VMnet IDs, IP addresses, VLAN IDs, and firewall rules used in the original project were not recovered.

## 1. Important distinction: VMnet separation versus VLAN tagging

VMware Workstation's virtual network options include Bridged, NAT, Host-only, Custom, and LAN Segment. Its Virtual Network Editor can also create multiple separate Host-only networks.

That means a lab can be divided into isolated virtual network segments using different VMnet networks. However, a VMnet label such as VMnet2 or VMnet3 is **not by itself proof of an IEEE 802.1Q VLAN**. Only claim that VLAN tagging was implemented when a VLAN-aware switching component and its tag configuration are actually present and tested.

For a small Workstation lab, describe the design as **isolated VMnet network segments / logical security zones**. For a true VLAN exercise, add a VLAN-aware virtual switch or a network-emulation platform and document the 802.1Q tags.

Official references:
- Broadcom KB — Using the Virtual Network Editor in VMware Workstation: https://knowledge.broadcom.com/external/article/339371/using-the-virtual-network-editor-in-vmwa.html
- VMware Workstation Pro documentation: https://docs.vmware.com/en/VMware-Workstation-Pro/

## 2. Basic two-VM isolated lab

This is the simplest version to rebuild the visible demo environment.

### Suggested logical layout

| VM | Operating system | Example IP | Network |
|---|---|---:|---|
| Red-team VM | Kali Linux | 192.168.56.10/24 | Host-only VMnet |
| Target VM | Windows 10 x64 | 192.168.56.20/24 | Same Host-only VMnet |

The IP addresses above are examples for a new build, not recovered project settings.

### VMware configuration steps

1. Power off both VMs.
2. Open **Edit → Virtual Network Editor** in VMware Workstation. Use administrator privileges if the editor requests them.
3. Add an unused VMnet, for example **VMnet2**.
4. Set the new network to **Host-only**.
5. For stronger isolation, clear **Connect a host virtual adapter to this network** if that option is available and the host does not need direct guest access.
6. Disable the local DHCP service if you want to use the example static IP plan below. Otherwise, document the DHCP range that you actually configure.
7. Open each VM's **VM → Settings → Network Adapter** page.
8. Select **Custom: Specific virtual network** and choose **VMnet2** for both Kali and Windows.
9. Do not select **Bridged**. Do not attach the test VMs to the normal home, school, or company LAN.
10. Start the VMs and configure their example static addresses. Keep the default gateway and DNS empty unless the lab has a documented, controlled need for them.
11. Verify that both guests are on the intended subnet and can communicate only as required for the authorized lab exercise.
12. Take clean snapshots before testing and revert after the exercise.

### Evidence to capture

- Virtual Network Editor showing VMnet2 is Host-only.
- Each VM's Network Adapter settings showing Custom: VMnet2.
- Kali output from `ip -br addr` and `ip route`.
- Windows output from `ipconfig /all`.
- A short verification note showing the expected connectivity and blocked external connectivity.

## 3. Expanded multi-zone lab

When the two-VM version is working, expand it into separate logical security zones. The table below is a proposed design for a future implementation.

| Logical zone | Example VMnet | Example subnet | Connected systems |
|---|---|---|---|
| Red-Team | VMnet2 | 10.10.20.0/24 | Kali Linux |
| Target | VMnet3 | 10.10.30.0/24 | Windows 10 x64 |
| Monitoring | VMnet4 | 10.10.40.0/24 | Log collector / monitoring VM |
| Backup | VMnet5 | 10.10.50.0/24 | Backup repository or recovery VM |
| Management | VMnet6 | 10.10.60.0/24 | Authorized administration only |

These VMnet names and subnets are illustrative. Change them if they overlap with networks already in use on the host.

### Suggested virtual firewall placement

Use a dedicated virtual firewall/router with one network adapter connected to each required Host-only VMnet. The firewall should route between zones only when a documented rule permits it.

Example high-level policy:

| Source | Destination | Default policy |
|---|---|---|
| Red-Team | Target | Deny by default; temporary test-specific access only |
| Red-Team | Management | Deny |
| Red-Team | Backup | Deny |
| Target | Monitoring | Allow only required log forwarding |
| Target | Backup | Deny by default |
| Management | VM management | Allow only from an authorized admin endpoint |
| Any lab zone | Physical LAN | Deny |
| Any lab zone | Public Internet | Deny by default; controlled temporary updates only |

The backup zone should not be reachable using the same credentials or network path that a compromised test VM can access.

## 4. Example VM resource sizing

The following is a suggested starting point for a student lab. It is not the original VM sizing.

| VM | vCPU | RAM | Disk |
|---|---:|---:|---:|
| Kali Linux | 2 | 4 GB | 40 GB |
| Windows 10 x64 | 2 | 4–8 GB | 60 GB |
| Virtual firewall (optional) | 1–2 | 1–2 GB | 10 GB |
| Log collector (optional) | 2 | 4 GB | 60 GB |

Tune the values to the physical host's capacity. Keep adequate free space for snapshots and backup exports.

## 5. Backup and rollback procedure

A snapshot is a convenience for reverting a lab VM. It is not an independent backup and should not be the only recovery method.

1. Build and patch a clean baseline VM.
2. Take a named pre-exercise snapshot.
3. Export or copy a backup of the VM to storage outside the test network.
4. Maintain at least one offline or immutable copy that a compromised guest cannot alter.
5. Use separate credentials for backup administration.
6. Perform a restore test and record the date, duration, boot result, and validation checks.
7. After a demonstration, revert the VM to its clean baseline and verify that the test state is removed.

## 6. Logging and test evidence

For an infrastructure portfolio, retain evidence that demonstrates configuration and verification rather than just screenshots of tools running.

| Area | Evidence |
|---|---|
| Virtualization | VM settings screenshots: CPU, RAM, disk, NIC type |
| Network | Virtual Network Editor screenshots and guest IP configuration |
| Segmentation | Firewall interface map, policy table, allow/deny test results |
| Windows | Security log and PowerShell logging settings |
| Monitoring | Example log events received by the collector |
| Backup | Backup job result and a successful restore-test record |
| Operations | Short test plan, test date, expected result, actual result, and cleanup confirmation |

Redact usernames, personal paths, public addresses, secrets, tokens, and credentials before publishing screenshots.

## 7. Implementation checklist

- [ ] Create Kali Linux and Windows 10 x64 VMs.
- [ ] Create a dedicated Host-only VMnet.
- [ ] Attach only the two lab VMs to the isolated network for the initial test.
- [ ] Record real IP addressing and network settings.
- [ ] Disable unnecessary shared folders, shared clipboard, and drag-and-drop.
- [ ] Take a clean baseline snapshot.
- [ ] Verify that the lab cannot reach the physical LAN.
- [ ] Add a virtual firewall before introducing separate zones.
- [ ] Create distinct VMnet networks for Target, Monitoring, Management, and Backup.
- [ ] Configure and test default-deny inter-zone rules.
- [ ] Configure log forwarding and confirm receipt.
- [ ] Create an independent offline/immutable backup.
- [ ] Perform and document a restore test.
- [ ] Update this document with actual screenshots and tested values.

## 8. How to describe the rebuilt lab on a résumé

Only after you have performed and captured the work, a truthful project bullet could look like this:

> Built an isolated VMware Workstation security lab with Kali Linux and Windows 10; separated Red-Team, Target, and Monitoring networks using dedicated Host-only VMnets; documented firewall allow/deny policies, Windows event logging, and offline VM backup/restore validation.

If you have not yet implemented the expanded segmentation and backup, do not use that sentence as a completed achievement. Describe it as a proposed design until you have the evidence.
