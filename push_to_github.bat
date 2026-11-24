@echo off
chcp 65001 >nul
echo ============================================================
echo   Pushing asahi-brewery-cyberattack-analysis (v2) to GitHub
echo ============================================================
echo.

REM 1. Initialize git repo if not already initialized
if not exist ".git" (
    echo [1/6] Initializing git repository...
    git init
) else (
    echo [1/6] Git repository already initialized.
)

REM 2. Configure remote origin URL
echo [2/6] Configuring remote origin...
git remote get-url origin >nul 2>&1
if errorlevel 1 (
    git remote add origin https://github.com/Hoangphuc187/asahi-brewery-cyberattack-analysis.git
) else (
    git remote set-url origin https://github.com/Hoangphuc187/asahi-brewery-cyberattack-analysis.git
)

REM 3. Sync remote main history if local branch has no commits yet
echo [3/6] Fetching remote branch state...
git fetch origin main 2>nul
git rev-parse --verify HEAD >nul 2>&1
if errorlevel 1 (
    git rev-parse --verify origin/main >nul 2>&1
    if not errorlevel 1 (
        git symbolic-ref HEAD refs/heads/main
        git update-ref refs/heads/main refs/remotes/origin/main
    )
)

REM 4. Stage all current project files
echo [4/6] Staging all files...
git branch -M main
git add -A

REM 5. Commit staged changes
echo [5/6] Creating commit...
git diff --cached --quiet
if errorlevel 1 (
    git commit -m "Update v2: complete docs, diagrams, slides PDF, full DOCX report, lab simulation, and demo video"
) else (
    echo No new file changes to commit.
)

REM 6. Push to GitHub
echo [6/6] Pushing to GitHub...
git push -u origin main

echo.
echo ============================================================
echo   Done! Check your repository at:
echo   https://github.com/Hoangphuc187/asahi-brewery-cyberattack-analysis
echo ============================================================
pause
