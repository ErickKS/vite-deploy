@echo off
setlocal enabledelayedexpansion

REM Step 1:Create the .github folder
mkdir .github

REM Step 2:Create the workflows folder
mkdir .github\workflows

REM Step 3:Create and input deploy.yml 
(
echo name: Deploy
echo.
echo on:
echo   push:
echo     branches:
echo       - main
echo.
echo jobs:
echo   build:
echo     name: Build
echo     runs-on: ubuntu-latest
echo.
echo     steps:
echo       - name: Checkout repo
echo         uses: actions/checkout@v2
echo.
echo       - name: Setup Node
echo         uses: actions/setup-node@v1
echo         with:
echo           node-version: 16
echo.
echo       - name: Install dependencies
echo         uses: bahmutov/npm-install@v1
echo.
echo       - name: Build project
echo         run: npm run build
echo.
echo       - name: Upload production-ready build files
echo         uses: actions/upload-artifact@v2
echo         with:
echo           name: production-files
echo           path: ./dist
echo.
echo   deploy:
echo     name: Deploy
echo     needs: build
echo     runs-on: ubuntu-latest
echo     if: github.ref == 'refs/heads/main'
echo.
echo     steps:
echo       - name: Download artifact
echo         uses: actions/download-artifact@v2
echo         with:
echo           name: production-files
echo           path: ./dist
echo.
echo       - name: Deploy to GitHub Pages
echo         uses: peaceiris/actions-gh-pages@v3
echo         with:
echo           github_token: ${{ secrets.GITHUB_TOKEN }}
echo           publish_dir: ./dist
) > .github\workflows\deploy.yml

REM Step 4:Edit vite.config.js

set "github_repo=!%cd%/../..!"
for /f "delims=" %%i in ('git config --get remote.origin.url') do set "github_repo=!github_repo:https://=!"
for /f "delims=" %%i in ('echo !github_repo!') do (
  set "github_repo=!github_repo:.git=!"
  echo base: "!github_repo!" >> vite.config.js
  echo remember // not \\ >> vite.config.js
)

endlocal
