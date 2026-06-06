@echo off
chcp 65001 >nul
title Đăng web Thuận Thiên lên GitHub

echo.
echo ============================================
echo   DANG WEB THUAN THIEN LEN GITHUB
echo ============================================
echo.

set "PATH=C:\Program Files\Git\cmd;C:\Program Files\GitHub CLI;%PATH%"
cd /d "%~dp0"

echo [1/3] Kiem tra dang nhap GitHub...
gh auth status >nul 2>&1
if errorlevel 1 (
    echo.
    echo Ban chua dang nhap GitHub.
    echo Cua so trinh duyet se mo - hay dang nhap va bam Authorize.
    echo.
    gh auth login -h github.com -p https -w
    if errorlevel 1 (
        echo.
        echo Dang nhap that bai. Thu lai sau.
        pause
        exit /b 1
    )
)

echo.
echo [2/3] Tao repository tren GitHub va day code len...
gh repo create web-thuan-thien --public --source=. --remote=origin --push --description "Landing page Thuận Thiên Xem Huyền Học & Đào Tạo"

if errorlevel 1 (
    echo.
    echo Repo co the da ton tai. Thu push truc tiep...
    git branch -M main
    git remote remove origin 2>nul
    for /f "delims=" %%i in ('gh api user -q .login') do set GHUSER=%%i
    git remote add origin https://github.com/%GHUSER%/web-thuan-thien.git
    git push -u origin main
)

echo.
echo [3/3] Hoan tat!
echo.
gh repo view --web 2>nul
echo.
echo Link GitHub: 
gh repo view --json url -q .url 2>nul
echo.
echo Buoc tiep theo tren Vercel:
echo   1. Vao https://vercel.com
echo   2. Add New - Project
echo   3. Import repo "web-thuan-thien"
echo   4. Bam Deploy
echo.
pause
