# Proposed Infrastructure — Reference Design

> **Important:** This is a proposed design for a future, safer and more reproducible lab. It is not the original VM/VLAN configuration. The original configuration was not present in the recovered files.

## 1. Design goals

- Keep the red-team exercise separate from the host and external networks.
- Restrict communication between the Kali test VM and the Windows target VM.
- Centralize logs so that attack activity can be observed and reviewed.
- Protect clean VM images and backups from the test environment.
- Make reset and recovery repeatable after each demonstration.

## 2. Reference topology

~~~text
                   Physical Host
                         |
                 VMware Workstation
                         |
             Isolated virtual lab networks
                         |
        +----------------+------------------+
        |                |                  |
   Red-Team Segment  Target Segment    Monitoring Segment
      Kali Linux       Windows 10       Log Collector
        |                |                  |
        +------ Controlled test traffic ---+
                         |
                 Backup / Recovery
              (isolated, no test access)
~~~

For a small two-VM demonstration, use a private VMware virtual network and keep the host's physical network outside the test path. For an expanded multi-segment lab, use a virtual firewall/router or a hypervisor platform that supports VLAN tagging and policy enforcement.

## 3. Example VLAN and IP plan

The following is an illustrative plan for a future expanded lab. These VLAN IDs and addresses are examples only; they were not recovered from the original project.

| VLAN | Name | Example subnet | Purpose |
|---:|---|---|---|
| 10 | Management | 10.10.10.0/24 | Hypervisor and administrative management |
| 20 | Red-Team | 10.10.20.0/24 | Kali Linux test VM |
| 30 | Target | 10.10.30.0/24 | Windows test VM |
| 40 | Monitoring | 10.10.40.0/24 | Log collector / monitoring tools |
| 50 | Backup | 10.10.50.0/24 | Offline or immutable recovery repository |

If the lab remains a two-VM VMware Workstation setup, these logical security zones can instead be implemented with separate host-only VMnet networks and a controlled virtual firewall. Do not describe the VLAN plan as implemented unless you actually configure and test it.

## 4. Example VM sizing

These are starting recommendations for a lightweight lab, not the original machine specifications.

| VM | vCPU | RAM | Disk | Role |
|---|---:|---:|---:|---|
| Kali Linux | 2 | 4 GB | 40 GB | Security testing and traffic generation |
| Windows 10 x64 | 2 | 4–8 GB | 60 GB | Authorized target and telemetry source |
| Log collector (optional) | 2 | 4 GB | 60 GB | Central log collection |
| Virtual firewall (optional) | 1–2 | 1–2 GB | 10 GB | Inter-zone traffic policy |

Adjust resources to the host's available CPU, RAM, and storage. Keep all VM images and test data in a dedicated lab directory.

## 5. Example inter-zone policy

Use a default-deny policy between zones and allow only flows required for a documented test.

| Source | Destination | Policy |
|---|---|---|
| Management | Hypervisor / VM management | Allow only from an authorized admin endpoint |
| Red-Team | Target | Allow only during a scheduled test and only for the required lab services |
| Target | Monitoring | Allow approved log forwarding |
| Red-Team | Management | Deny |
| Red-Team | Backup | Deny |
| Target | Backup | Deny by default; allow only a separate, controlled backup workflow |
| Lab segments | Home / corporate LAN | Deny |
| Lab segments | Public Internet | Deny by default; allow temporary, controlled updates only when required |

Record the exact rule, business/test reason, owner, and review date for each exception.

## 6. Backup and recovery design

A practical recovery plan should include:

1. **Clean baseline:** Keep a known-good Windows and Kali VM baseline.
2. **Pre-test snapshot:** Take a snapshot before each lab exercise.
3. **Independent backup:** Export or back up VM images to storage outside the lab network.
4. **Offline / immutable copy:** Keep at least one recovery copy that a compromised VM cannot modify.
5. **Separate credentials:** Do not reuse domain or local administrator credentials for backup administration.
6. **Restore validation:** Periodically restore a VM and verify that it boots and its test tools/configuration are intact.
7. **Post-exercise reset:** Revert to the clean baseline and verify that no test payload remains.

A VM snapshot is useful for a quick rollback but is not a substitute for an independent backup. A robust policy can use the 3-2-1-1-0 principle: multiple copies, different media, an off-site copy, an offline or immutable copy, and regular verification.

## 7. Monitoring and validation

For a future rebuild, collect and retain:

- VMware virtual-network configuration.
- Guest IP configuration and routing table.
- Firewall allow/deny logs.
- Windows Security and PowerShell logs.
- EDR alerts and process telemetry.
- DNS, proxy, and network-flow logs where available.
- Backup job results and restore-test evidence.

Suggested validation checks:

- Confirm that the Kali VM cannot reach the host management interface.
- Confirm that the target VM cannot access the backup zone.
- Confirm that only approved test traffic crosses between the Red-Team and Target zones.
- Confirm that Windows logs reach the monitoring VM.
- Confirm that the lab can be restored from a clean backup after a test.

## 8. Implementation checklist

- [ ] Create a dedicated lab directory and document host capacity.
- [ ] Create Kali Linux and Windows 10 x64 VMs.
- [ ] Configure Host-only networking or separate isolated virtual networks.
- [ ] Disable unnecessary shared folders and clipboard integration.
- [ ] Add a virtual firewall before introducing additional segments.
- [ ] Document IP addressing, routes, and allowed flows.
- [ ] Enable endpoint and event logging.
- [ ] Create a clean baseline snapshot.
- [ ] Export an independent backup to isolated storage.
- [ ] Perform and record a restore test.
- [ ] Capture screenshots and update this document with actual values.

When implementation is complete, replace example values with screenshots and verified configuration exports. Keep the proposed and implemented sections clearly separated.
