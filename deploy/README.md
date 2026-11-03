# Other hosting options

The site is plain static HTML (`hugo --gc --minify` writes it to `public/`). Pick any option below, set `HUGO_BASEURL` to the new public URL, and disable or delete `.github/workflows/hugo.yml` if you leave GitHub.

## Cloudflare Pages
- Connect the repo in the Cloudflare dashboard.
- Build command: `hugo --gc --minify`
- Output directory: `public`
- Environment variables: `HUGO_VERSION=0.169.0`, `HUGO_BASEURL=https://<your-domain>/`

## Your own server (rsync + Caddy or nginx)
Build anywhere (CI, or `make build`), then copy the folder:

```bash
HUGO_BASEURL=https://blog.example.com/ hugo --gc --minify
rsync -az --delete public/ user@server:/var/www/blog/
```

Caddyfile:

```
blog.example.com {
    root * /var/www/blog
    encode gzip zstd
    file_server
}
```

## Docker
The root `Dockerfile` builds the site and serves it with nginx:

```bash
docker build --build-arg HUGO_BASEURL=https://blog.example.com/ -t blog .
docker run -d -p 8080:80 blog
```

## GitLab Pages / Netlify / Gitea
Copy `gitlab-ci.yml`, `netlify.toml` or `gitea-actions.yml` from this folder to the location named at the top of each file.
