@echo off
cd /d %~dp0

echo 🔒 Creating .gitignore file...
(
echo # 🔒 Ignore secrets and keystore
echo /android/app/key.properties
echo /android/app/vaura.jks
echo .env

echo # ⚙️ Flutter build directories
echo /build/
echo /.dart_tool/
echo /.idea/
echo /.vscode/
echo /pubspec.lock

echo # 🗃️ OS and IDE files
echo *.iml
echo *.log
echo *.tmp
echo *.DS_Store

echo # 🔁 Generated
echo /generated_plugin_registrant.dart
echo /ios/Flutter/Flutter.podspec
) > .gitignore

echo ✅ .gitignore created.

REM Check if .git exists
IF NOT EXIST ".git" (
    echo 🧱 Initializing Git repo...
    git init
)

echo 🔄 Staging all files...
git add .

echo 📝 Committing...
git commit -m "🔐 Added .gitignore, release signing setup, deep link config"

echo 🔁 Renaming branch to main...
git branch -M main

echo 🔗 Setting remote...
git remote remove origin 2>nul
git remote add origin https://github.com/OlaCodez1/Vaura-AI.git

echo ☁️ Pushing to GitHub main branch...
git push -u origin main

echo 🟢 All done! Git repo is live at:
echo https://github.com/OlaCodez1/Vaura-AI

echo.
pause
