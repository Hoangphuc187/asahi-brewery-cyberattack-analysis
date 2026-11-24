# Recovery Note and Project Limitations

## Repository recovery statement

The original computer used to store the project was affected by malware. The original working directory and development artifacts could not be recovered. The materials that remain are:

- The written report in DOCX format.
- The presentation slide deck in PDF format.
- The recorded lab demonstration in MP4 format.

This repository is rebuilt from those surviving materials. It does not claim to contain the original source code, scripts, VM exports, snapshots, network configuration, VLAN plan, firewall rules, or backup configuration.

## What is preserved

| Artifact | Preserved content |
|---|---|
| Report | Case-study background, attack-chain analysis, MITRE ATT&CK mapping, CIA assessment, risk matrix, NIST CSF mapping, impact analysis, and defensive recommendations |
| Slides | Presentation summary, diagrams, risk assessment, and recommendations |
| Demo video | A short VMware-based lab demonstration with Kali Linux and Windows 10 x64 |

## Important distinction: incident analysis versus lab PoC

There are two separate elements in this project:

1. **Asahi incident case study:** A research analysis built from the report's public-source discussion and cited material.
2. **Educational lab demonstration:** A separate VMware-based proof of concept shown in the recorded video.

The lab video does not demonstrate access to Asahi's real systems. It does not contain Qilin's original malware and should not be described as a reproduction of the production incident.

## Report/demo wording discrepancy

The submitted report's Section 5.4 lists the lack of a practical attack simulation as a research limitation. The separately supplied video, however, shows a lab PoC demonstration.

To preserve this accurately, this repository treats the video as a supplementary demonstration artifact. If the report is revised later, update Section 5.4 to explain the scope and boundaries of the supplementary lab PoC rather than implying that the lab reproduces the real Asahi incident.

## Configuration gaps

The following information is not present in the surviving materials and should not be invented:

- VM vCPU, RAM, disk, and snapshot settings.
- VMware virtual network mode and VMnet settings.
- IP addresses, subnets, routes, and VLAN IDs.
- Firewall configuration and inter-zone access rules.
- Exact Windows security settings and endpoint protection policy.
- Central logging / SIEM setup.
- Backup target, isolation method, schedule, retention, and restore-test evidence.

A future rebuild should add screenshots or exported configuration files for these items. Proposed values are documented separately in **proposed-infrastructure.md** and must remain labelled as proposed until tested.

## Caution when quoting incident figures

The original report and slides contain values that are time-dependent or presented with different definitions, such as data initially considered at risk versus records later described as confirmed exposed. Some impact figures are estimates. Do not merge these figures into one number without checking the corresponding date, definition, and cited source.

The case study is based on public reporting and project analysis. It is not an official Asahi incident report or independent forensic finding.

## Privacy before making the repository public

The original report cover includes student names and student identification numbers. Before publishing the DOCX publicly, confirm that all listed contributors agree to public disclosure. If not, create a redacted public copy while retaining the original privately.

Do not upload the separate IT Infrastructure résumé to this repository. It contains personal contact information and is not a project deliverable.
