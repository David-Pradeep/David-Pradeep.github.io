---
title: "Welcome to the blog"
date: 2026-11-03T09:00:00+05:30
summary: "What this blog covers and how it is built: Markdown files in a Git repo, published as a static site."
tags: ["meta", "markdown"]
categories: ["Blog"]
---

Welcome! This blog covers **mobile technology**, **self-hosted DevOps** and **AI**.

## How it works

Every post is a single Markdown file in `content/posts/`. Committing a new file to the repository rebuilds and publishes the site automatically.

```markdown
---
title: "My new post"
date: 2026-11-03
tags: ["example"]
categories: ["Blog"]
---

Post content goes here.
```

The site is plain static HTML, so it can be hosted anywhere, today on GitHub Pages and tomorrow on whatever service makes sense.
