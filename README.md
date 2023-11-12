<div align="center">
    <h2>⚜️ V I T E &nbsp; D E P L O Y ⚜️</h2>
</div>

<div align="center">
    <h4>Follow the steps below to deploy your React application on GitHub.</h4>
    <a href="https://www.youtube.com/watch?v=XhoWXhyuW_I">
        <img src="https://img.shields.io/badge/Youtube_Video%20-%0A66C2.svg?&style=for-the-badge&logo=YouTube&logoColor=FF0000&color=282828" />
    </a>
</div>

<br />

#### 01. Create a vite react app
```npm
npm create vite@latest
```

#### 02. Create a new repository on GitHub and initialize GIT
```git
git init 
git add . 
git commit -m "add: initial files" 
git branch -M main 
git remote add origin https://github.com/[USER]/[REPO_NAME] 
git push -u origin main
```

#### 03. Setup base in *vite.config*
```js
base: "/[REPO_NAME]/"
```

#### 04. Create ./github/workflows/deploy.yml and add the code bellow
> [!WARNING]
> It is crucial that the `.yml` file has the exact code below. Any typing or spacing errors may cause deployment issues.
```yml
name: Deploy

on:
  push:
    branches:
      - main

jobs:
  build:
    name: Build
    runs-on: ubuntu-latest

    steps:
      - name: Checkout repo
        uses: actions/checkout@v2

      - name: Setup Node
        uses: actions/setup-node@v1
        with:
          node-version: 16

      - name: Install dependencies
        uses: bahmutov/npm-install@v1

      - name: Build project
        run: npm run build

      - name: Upload production-ready build files
        uses: actions/upload-artifact@v2
        with:
          name: production-files
          path: ./dist

  deploy:
    name: Deploy
    needs: build
    runs-on: ubuntu-latest
    if: github.ref == 'refs/heads/main'

    steps:
      - name: Download artifact
        uses: actions/download-artifact@v2
        with:
          name: production-files
          path: ./dist

      - name: Deploy to GitHub Pages
        uses: peaceiris/actions-gh-pages@v3
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          publish_dir: ./dist
```

#### 05. Push to GitHub
```git
git add . 
git commit -m "add: deploy workflow" 
git push
```

#### 06. Active workflow (GitHub)
```
Config > Actions > General > Workflow permissions > Read and Write permissions 
```
```
Actions > failed deploy > re-run-job failed jobs 
```
```
Pages > gh-pages > save
```

## 🛠 Helper

#### > For code changes
Whenever you push to GitHub, it will deploy automatically.
```git
git add . 
git commit -m "fix: some bug" 
git push
```

#### > Fixing the 404 page error on routes.
Watch my video on YouTube or check my repository.

<a href="https://youtu.be/uEEj2c3_ydg?si=XiUEL9h1WUmfjtkt">
    <img src="https://img.shields.io/badge/Video%20-%0A66C2.svg?&style=for-the-badge&logo=YouTube&logoColor=FF0000&color=282828" />
</a>
<a href="https://github.com/ErickKS/vite-react-router">
    <img src="https://img.shields.io/badge/Repository%20-%0A66C2.svg?&style=for-the-badge&logo=GitHub&logoColor=FFFFFF&color=282828" />
</a>

<br/>

#### > Do you want to automate the project setup process ( `.yml` and `vite.config` )?
To prevent possible errors in the deploy process, check out this pull request:

<a href="https://github.com/ErickKS/vite-deploy/pull/1">
    <img src="https://img.shields.io/badge/Pull_Request%20-%0A66C2.svg?&style=for-the-badge&logo=GitHub&logoColor=FFFFFF&color=282828" />
</a>
