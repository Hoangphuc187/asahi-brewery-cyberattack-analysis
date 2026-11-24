# Upload Guide for the Surviving Project Files

The repository documentation has been initialized. The original binary artifacts still need to be added from the local copies.

## 1. Use these filenames and paths

| Local file | GitHub repository path |
|---|---|
| ASAHI BREWERY CYBERATTACK.pdf (3.70 MB) | presentations/ASAHI_BREWERY_CYBERATTACK.pdf |
| BaoCaoASAHI BREWERY CYBERATTACK.docx (1.34 MB) | reports/BaoCao_ASAHI_BREWERY_CYBERATTACK.docx |
| Videodemo.mp4 (18.60 MB) | demo/Asahi_Cyberattack_Lab_Demo.mp4 |

Do not upload the separate file named _IT Infrastructure.pdf; it is a résumé and contains personal contact information.

## 2. Upload through the GitHub website

1. Open the repository: https://github.com/Hoangphuc187/asahi-brewery-cyberattack-analysis
2. Open the **presentations** folder (it has already been created). Click **Add file → Upload files**.
3. Select `ASAHI BREWERY CYBERATTACK.pdf` from your computer.
4. Enter the commit message `Add original presentation slides` and click **Commit changes**.
5. Return to the repository root, open **reports**, choose **Add file → Upload files**, select `BaoCaoASAHI BREWERY CYBERATTACK.docx`, and commit with `Add recovered project report`.
6. Open **demo**, choose **Add file → Upload files**, select `Videodemo.mp4`, and commit with `Add surviving lab demonstration recording`.
7. Open the README and click each deliverable link to verify it.

GitHub's browser upload limit is 25 MiB per file and supports up to 100 files in one upload. The supplied slide PDF (3.70 MB), DOCX report (1.34 MB), and MP4 demo (18.60 MB) are each below that per-file limit. See the official documentation: https://docs.github.com/en/repositories/working-with-files/managing-files/adding-a-file-to-a-repository

## 3. Suggested commit messages

- Add original presentation slides
- Add recovered project report
- Add surviving lab demonstration recording
- Document lab topology and recovery limitations

## 4. Verify after upload

- Confirm that all three files appear in their intended folders.
- Open the PDF from GitHub to verify that it renders.
- Download the DOCX and make sure it opens.
- Open the MP4 and check playback.
- Confirm that README links point to the exact uploaded filenames.
- Check that no passwords, tokens, private keys, live credentials, or unredacted personal data were uploaded.

## 5. Optional: upload from Git command line

If you prefer Git locally, clone the repository, copy the files into the folders above, then run:

~~~bash
git add README.md docs reports presentations demo
git commit -m "Add recovered Asahi project artifacts"
git push origin main
~~~

Do not commit VM disk images or large memory snapshots. If a future artifact is over 100 MiB, review Git Large File Storage or GitHub Releases before adding it to the repository.
