# David Pradeep's blog

A Markdown blog about mobile technology, self-hosted DevOps and AI. Built with [Hugo](https://gohugo.io) and the [Blowfish](https://blowfish.page) theme (vendored in `themes/blowfish`), published to GitHub Pages at <https://david-pradeep.github.io>.

> **Hugo version:** Blowfish supports Hugo **0.164.0 – 0.167.0**. The workflow, Dockerfile and deploy templates are pinned to **0.167.0**. Use the same version locally.

## Write a post (no local install needed)

1. Open this repo on GitHub and press `.` to open the web editor (or use **Add file → Create new file**).
2. Create `content/posts/my-post.md`:

   ```markdown
   ---
   title: "My post"
   date: 2026-11-03
   summary: "One-line summary shown in lists and search."
   tags: ["docker", "caddy"]
   categories: ["DevOps"]
   ---

   Content in Markdown.
   ```

3. Commit to `main`. GitHub Actions builds and publishes the site within a minute or two.

Set `draft: true` to keep a post unpublished. Future-dated posts are not published until their date. Add a cover image with `featureimage: "https://..."` (or put `feature.jpg` next to the post in a folder-style post: `content/posts/my-post/index.md`).

Use the existing categories (`Mobile`, `DevOps`, `AI`) so the landing-page tiles link to a populated page.

## Features

Dark/light mode, categories and tags, search (press `/` or the search icon), RSS (`/index.xml`), About page, reading time, table of contents, and syntax highlighting with copy buttons. Theme options are in `config/_default/params.toml`.

## Customize

| What | Where |
|---|---|
| Site title, author name, headline, avatar, social links | `config/_default/languages.en.toml` (avatar: `assets/img/avatar.svg`) |
| Landing-page headline, buttons, topic tiles, latest posts | `content/_index.md` |
| Landing layout (`landing`, `profile`, `hero`, `background`, `page`, `card`) | `[homepage] layout` in `config/_default/params.toml` |
| Colors | `colorScheme` in `params.toml` (`ocean`, `blowfish`, `forest`, `slate`, `noir`, `neon`, ... see `themes/blowfish/assets/css/schemes`) |
| Top menu / footer menu | `config/_default/menus.en.toml` |
| Analytics (GoatCounter, cookie-free) | `goatcounter` code in `params.toml` (disabled while empty) |

## One-time GitHub setup (already done for this repo)

1. Create the repo `David-Pradeep/David-Pradeep.github.io` and push this project to `main`.
2. In **Settings → Pages**, set **Source** to **GitHub Actions**.

## Build and deploy manually

### 0. Tooling (only for local builds)

Install **Hugo extended 0.167.0**, either:

```powershell
winget install Hugo.Hugo.Extended --version 0.167.0   # Windows
```

or download `hugo_extended_0.167.0_<os>` from <https://github.com/gohugoio/hugo/releases/tag/v0.167.0> and put it on your `PATH`. Check with `hugo version`.

### 1. Preview locally

```powershell
hugo server -D        # http://localhost:1313, live reload, shows drafts
```

### 2. Build the static site

```powershell
hugo --gc --minify    # output: public/
```

`public/` is plain HTML/CSS/JS and can be served from any web server. `baseURL` defaults to `https://david-pradeep.github.io/`. Override it for another host:

```powershell
$env:HUGO_BASEURL = "https://blog.example.com/"; hugo --gc --minify     # PowerShell
HUGO_BASEURL=https://blog.example.com/ hugo --gc --minify               # bash
```

### 3. Deploy

**A. GitHub Pages, trigger the existing pipeline by hand (no local tools)**

```powershell
gh workflow run hugo.yml --ref main
gh run watch
```

You can also use the **Actions → Deploy site to GitHub Pages → Run workflow** button.

**B. GitHub Pages, publish a local build yourself (`gh-pages` branch)**

Use this only if you do not want Actions to build. First change **Settings → Pages → Source** to **Deploy from a branch → `gh-pages` / `/ (root)`**, then:

```powershell
hugo --gc --minify
cd public
git init -b gh-pages
git add -A
git commit -m "Deploy site"
git push -f https://github.com/David-Pradeep/David-Pradeep.github.io.git gh-pages
cd ..
```

`public/` is git-ignored in this repo, so the nested repository is separate and the force-push only replaces the `gh-pages` branch. Re-run the same steps for every deployment. If GitHub ever processes the output with Jekyll, add an empty `.nojekyll` file to `public/` before committing.

**C. Your own server (rsync/scp + Caddy or nginx)**

```bash
HUGO_BASEURL=https://blog.example.com/ hugo --gc --minify
rsync -az --delete public/ user@server:/var/www/blog/      # or: scp -r public/* user@server:/var/www/blog/
```

Minimal Caddyfile:

```
blog.example.com {
    root * /var/www/blog
    encode gzip zstd
    file_server
}
```

**D. Docker (no Hugo needed on the host)**

```bash
docker build --build-arg HUGO_BASEURL=https://blog.example.com/ -t blog .
docker run -d --name blog -p 8080:80 blog
```

**E. Cloudflare Pages / Netlify / GitLab Pages**: see [deploy/](deploy/README.md). You can also drag-and-drop the `public/` folder in the Cloudflare Pages or Netlify dashboards.

### Updating the theme

Blowfish is vendored, so updates are manual. Download a release from <https://github.com/nunocoracao/blowfish/releases>, replace `themes/blowfish`, check its supported Hugo range in `themes/blowfish/config.toml`, and update the pinned Hugo version in `.github/workflows/hugo.yml`, `Dockerfile` and `deploy/`.

## Gitea mirror

A Gitea mirror of this repo needs no configuration. If Actions is enabled on the mirror, disable it so it does not try to run the GitHub workflow.

## Moving off GitHub

Only the deploy layer is GitHub-specific. Posts, theme and config are host-independent, and `HUGO_BASEURL` overrides the site URL at build time. See [deploy/](deploy/README.md) for Cloudflare Pages, Netlify, GitLab Pages, Gitea, rsync + Caddy, and the Docker image.
