# Repository Maintenance and Optional Binary Upload

## Current repository layout

- `presentations/ASAHI_BREWERY_CYBERATTACK.pdf` is the recovered presentation PDF stored directly in GitHub.
- `reports/README.md` links to the original Google Docs report. The unredacted DOCX is not duplicated in the public repository because its cover contains student identification numbers.
- `demo/README.md` links to the original MP4 recording in Google Drive. The video is linked externally to avoid storing a large binary in Git history.
- `assets/diagrams/` contains vector diagrams created for this reconstructed project portfolio.
- `docs/` contains the technical analysis, infrastructure proposal, lab rebuild guide, and recovery limitations.

## Optional: mirror the report or video into GitHub

Only do this after confirming the public release is appropriate.

1. Download the report or video from its Google Drive link.
2. For the report, create a public copy with student identification numbers removed and obtain the contributors' approval.
3. Open the repository and navigate to the appropriate folder.
4. Choose **Add file → Upload files**, select the file, and commit it.
5. Update this guide and the README so the repository path points to the new file.

The browser upload limit is 25 MiB per file. The original demo recording is approximately 18.6 MB, so it is below that limit. Avoid committing VM disk images, memory dumps, executable payloads, secrets, credentials, or unredacted logs.

## Optional Git command line

After downloading and reviewing the files, copy them into the appropriate folders and run:

~~~bash
git add reports demo presentations assets docs README.md
git commit -m "Update recovered Asahi project portfolio"
git push origin main
~~~
