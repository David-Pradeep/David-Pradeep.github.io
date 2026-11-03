# David Pradeep's blog

A Markdown blog about mobile technology, self-hosted DevOps and AI. Built with [Hugo](https://gohugo.io) and the [PaperMod](https://github.com/adityatelange/hugo-PaperMod) theme (vendored in `themes/PaperMod`), published to GitHub Pages at <https://david-pradeep.github.io>.

## Write a post (no local install needed)

1. Open this repo on GitHub and press `.` to open the web editor (or use **Add file → Create new file**).
2. Create `content/posts/my-post.md`:

   ```markdown
   ---
   title: "My post"
   date: 2026-11-03
   summary: "One-line summary shown in lists and search."
   tags: ["docker", "self-hosted"]
   categories: ["DevOps"]
   ---

   Content in Markdown.
   ```

3. Commit to `main`. GitHub Actions builds and publishes the site within a minute or two.

Set `draft: true` to keep a post unpublished. Future-dated posts are not published until their date.

## Features

Dark/light mode, tags and categories, search (`/search/`), RSS (`/index.xml`), About page, reading time, syntax highlighting with copy buttons. All settings are in [hugo.yaml](hugo.yaml).

## One-time GitHub setup

1. Create the repo `David-Pradeep/David-Pradeep.github.io` and push this project to `main`.
2. In **Settings → Pages**, set **Source** to **GitHub Actions**.

## Analytics (optional)

Create a free site at [goatcounter.com](https://www.goatcounter.com) and set `params.analytics.goatcounter` in `hugo.yaml` to your code. It is cookie-free and disabled while empty.

## Preview locally (optional)

Install Hugo extended, then `make serve` (or `hugo server -D`). Without installing anything, use a GitHub Codespace.

## Gitea mirror

A Gitea mirror of this repo needs no configuration. If Actions is enabled on the mirror, disable it so it does not try to run the GitHub workflow.

## Moving off GitHub

Only the deploy layer is GitHub-specific. Posts, theme and config are host-independent, and `HUGO_BASEURL` overrides the site URL at build time. See [deploy/](deploy/README.md) for Cloudflare Pages, Netlify, GitLab Pages, Gitea, rsync + Caddy, and the Docker image.
