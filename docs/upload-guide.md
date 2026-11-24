# 🚀 GitHub Upload & Large File Guide

> Step-by-step instructions for publishing this repository to GitHub, verifying `.gitignore` safety exclusions, handling binary media files (`Demo_Full.mp4`, `.pdf`, `.docx`), and embedding an inline playable demo video.

---

## 1. Repository File Size Audit

GitHub enforces a **50 MB warning threshold** and a **100 MB hard per-file limit** for standard Git pushes. All files in this repository fit within standard GitHub limits out of the box:

| File | Path | Approximate Size | GitHub Standard Push (`<100 MB`) | Git LFS Recommended? |
| :--- | :--- | :---: | :---: | :--- |
| **Lab Demo Video** | `demo/Demo_Full.mp4` | **~18.6 MB** | ✅ Supported | Optional *(recommended if adding more videos)* |
| **Presentation Slides** | `docs/ASAHI_BREWERY_CYBERATTACK_Slides.pdf` | **~3.7 MB** | ✅ Supported | Not required |
| **Technical Report** | `docs/Bao_Cao_ASAHI_BREWERY_CYBERATTACK.docx` | **~1.34 MB** | ✅ Supported | Not required |
| **Analytical Diagrams** | `diagrams/*.png` *(8 files)* | **~0.03–0.59 MB each** | ✅ Supported | Not required |

---

## 2. Pre-Upload Safety Checklist

Before running `git add .`, verify that **no live malware binaries, VM disks, or credentials** exist in the working directory. The included [`.gitignore`](../.gitignore) automatically excludes:

- **VMware virtual machine images:** `*.vmdk`, `*.vmx`, `*.vmsn`, `*.ova`, `*.iso`, `*.vmem`
- **Executable / PoC binaries:** `*.exe`, `*.dll`, `*.msi`, `*.bin`
- **Temporary Office & OS files:** `~$*`, `.DS_Store`, `Thumbs.db`, `.env`

Run a quick dry-run check from PowerShell inside `Asahi-Brewery-Cyberattack-Analysis/`:

```powershell
git status --ignored
```

---

## 3. Option A — One-Click Upload on Windows (`push_to_github.bat`)

1. Create an **empty** repository on GitHub (do *not* initialize with a README or license if pushing an existing commit history), e.g.:
   `https://github.com/<your-username>/Asahi-Brewery-Cyberattack-Analysis.git`
2. *(If pushing to your own GitHub account)* Edit line 25 of [`../push_to_github.bat`](../push_to_github.bat) to match your repository URL:
   ```bat
   git remote add origin https://github.com/<your-username>/Asahi-Brewery-Cyberattack-Analysis.git 2>nul
   ```
3. Double-click `push_to_github.bat` or run it from PowerShell:
   ```powershell
   .\push_to_github.bat
   ```

---

## 4. Option B — Manual Git CLI Workflow

Open PowerShell or Terminal inside the `Asahi-Brewery-Cyberattack-Analysis` directory and run:

```bash
# 1. Initialize repository
git init

# 2. Stage all documentation, diagrams, lab scripts, and demo media
git add .

# 3. Verify staged files (confirm no .exe or .vmdk files appear)
git status

# 4. Commit changes
git commit -m "docs: add complete Asahi Brewery cyberattack analysis, diagrams, lab walkthrough, and docs suite"

# 5. Rename default branch to main
git branch -M main

# 6. Link remote repository and push
git remote add origin https://github.com/Hoangphuc187/asahi-brewery-cyberattack-analysis.git
git push -u origin main
```

> **Note:** If the remote repository already exists and has divergent commits on GitHub, pull/rebase first (`git pull --rebase origin main`) before running `git push -u origin main`.

---

## 5. Optional — Using Git LFS for Video / Binary Assets

If you plan to add higher-bitrate recordings (`>50 MB`) in the future, configure **Git Large File Storage (Git LFS)** *before* committing `.mp4` files:

```bash
# Install Git LFS hooks once on your machine
git lfs install

# Track MP4 recordings via Git LFS
git lfs track "*.mp4"

# Ensure .gitattributes is staged first
git add .gitattributes
git add .
git commit -m "chore: track demo video via Git LFS"
git push -u origin main
```

---

## 6. Rendering an Inline Video Player on GitHub

GitHub Markdown links to `demo/Demo_Full.mp4` download the file when clicked, whereas **GitHub User-Attachments URLs** render a native HTML5 video player directly inside `README.md`:

1. Push the repository to GitHub first.
2. Open `README.md` on GitHub.com and click the **Edit (pencil)** icon.
3. Scroll to the **`## 🎥 Live Demo`** section.
4. Drag and drop `demo/Demo_Full.mp4` from your computer directly into the Markdown editor text area.
5. Wait for GitHub to upload and generate a `https://github.com/user-attachments/assets/...` URL on its own line, then click **Commit changes**.

---

## Related Documentation

- **Lab Environment Overview:** [Lab Environment](lab-environment.md)
- **Archive & Recovery Status:** [Recovery & Limitations](recovery-and-limitations.md)
- **Back to Index:** [Documentation Index](README.md)
