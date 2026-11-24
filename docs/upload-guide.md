# Upload Guide for the Surviving Project Files

The repository documentation has been initialized. The original binary artifacts still need to be added from the local copies.

## 1. Use these filenames and paths

| Local file | GitHub repository path |
|---|---|
| ASAHI BREWERY CYBERATTACK.pdf | presentations/ASAHI_BREWERY_CYBERATTACK.pdf |
| BaoCaoASAHI BREWERY CYBERATTACK.docx | reports/BaoCao_ASAHI_BREWERY_CYBERATTACK.docx |
| Videodemo.mp4 | demo/Asahi_Cyberattack_Lab_Demo.mp4 |

Do not upload the separate file named _IT Infrastructure.pdf; it is a résumé and contains personal contact information.

## 2. Upload through the GitHub website

1. Open the repository: https://github.com/Hoangphuc187/asahi-brewery-cyberattack-analysis
2. Open the **presentations** folder. If it does not exist yet, choose **Add file → Create new file**, name it presentations/.gitkeep, and commit it. Repeat for **reports** and **demo** if necessary.
3. Open a folder, choose **Add file → Upload files**, and select the corresponding local file.
4. Enter a descriptive commit message, such as **Add original presentation slides**.
5. Commit the upload to the main branch.
6. Repeat for the report and demo video.
7. Open the README and check that each artifact link resolves correctly.

GitHub's browser upload limit is 25 MiB per file and supports up to 100 files in one upload. The supplied slide PDF, DOCX report, and MP4 demo are each below that per-file limit. See the official documentation: https://docs.github.com/en/repositories/working-with-files/managing-files/adding-a-file-to-a-repository

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
