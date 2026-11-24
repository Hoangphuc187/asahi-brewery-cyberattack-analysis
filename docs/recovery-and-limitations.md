# Recovery Note and Project Limitations

## Repository recovery statement

The original computer used to store the project was affected by malware. The original working directory and development artifacts could not be recovered. The remaining materials are:

- The written report in Google Docs.
- The original 16-slide presentation PDF.
- The recorded VMware lab demonstration in MP4 format.

This repository has been reconstructed from those surviving materials. The original report and MP4 remain linked to their supplied Google Docs / Drive locations. The presentation PDF is stored under `presentations/`. Six selected visual previews are direct page renders from the original PDF (slides 6, 7, 8, 9, 10, and 14) and are stored under `assets/slides/`. The previously added placeholder artwork and fabricated demo preview have been removed.

The repository does not claim to contain the original source code, scripts, VM exports, snapshots, network configuration, VLAN plan, firewall rules, or backup configuration.

## What is preserved

| Artifact | Current location | Preserved content |
|---|---|---|
| Report | External Google Docs link in `reports/README.md` | Case-study background, attack-chain analysis, MITRE ATT&CK mapping, CIA assessment, risk matrix, NIST CSF mapping, impact analysis, and recommendations |
| Presentation | `presentations/ASAHI_BREWERY_CYBERATTACK.pdf` | Original 16-slide presentation |
| Slide previews | `assets/slides/` | Direct page renders of original slides 6, 7, 8, 9, 10, and 14 |
| Demo video | External Drive link in `demo/README.md` | Short VMware-based lab demonstration with Kali Linux and Windows 10 x64 |

## Important distinction: incident analysis versus lab PoC

There are two separate elements in this project:

1. **Asahi incident case study:** research analysis built from the report's public-source discussion and cited material.
2. **Educational lab demonstration:** a separate VMware-based proof of concept shown in the recorded video.

The lab video does not demonstrate access to Asahi's real systems. It does not contain Qilin's original malware and should not be described as a reproduction of the production incident.

## Report/demo wording discrepancy

The submitted report's Section 5.4 lists the lack of a practical attack simulation as a research limitation. The separately supplied video, however, shows a lab PoC demonstration.

This repository treats the video as a supplementary demonstration artifact. It does not silently rewrite the original report or claim the PoC reproduces the real Asahi incident.

## Configuration gaps

The following information is not present in the surviving materials and should not be invented:

- VM vCPU, RAM, disk, and snapshot settings.
- VMware virtual network mode and VMnet settings.
- IP addresses, subnets, routes, and VLAN IDs.
- Firewall configuration and inter-zone access rules.
- Exact Windows security settings and endpoint protection policy.
- Central logging / SIEM setup.
- Backup target, isolation method, schedule, retention, and restore-test evidence.

A future rebuild should add screenshots or exported configuration files for these items. Proposed values are documented in `proposed-infrastructure.md` and `vmware-workstation-setup.md`; they must remain labelled as proposed until tested.

## Caution when quoting incident figures

The original report and slides contain figures that may differ by date or definition, such as data initially considered at risk versus records later described as confirmed exposed. Some impact figures are estimates. Do not merge these figures into one number without checking the corresponding date, definition, and cited source.

The case study is based on public reporting and project analysis. It is not an official Asahi incident report or independent forensic finding.

## Privacy before public sharing

The original report cover includes student names and student identification numbers. The repository links to the Google Docs source rather than duplicating the unredacted DOCX in public Git history. Confirm that all listed contributors agree before changing the Google Docs permission to public viewer access.

Do not upload the separate IT Infrastructure résumé to this repository. It contains personal contact information and is not a project deliverable.
