@echo off
chcp 65001 >nul
cd /d "%~dp0"

git remote get-url origin | findstr /i "aluminum-rhythm" >nul
if errorlevel 1 (
  echo [停止] 這個資料夾連到的 GitHub 不是 aluminum-rhythm，沒有上傳。
  pause
  exit /b 1
)

powershell -NoProfile -Command "$v=Get-Date -Format 'yyyyMMddHHmmss'; (Get-Content sw.js -Raw) -replace 'const VERSION=.*;', ('const VERSION=''' + $v + ''';') | Set-Content sw.js -NoNewline"

git add -A
git commit -m "update"
git push origin main
echo.
echo 上傳完成，Vercel 約一分鐘後更新。
pause
