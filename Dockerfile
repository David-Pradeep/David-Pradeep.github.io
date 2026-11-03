FROM ghcr.io/gohugoio/hugo:v0.169.0 AS build
WORKDIR /src
COPY . .
ARG HUGO_BASEURL=http://localhost:8080/
ENV HUGO_BASEURL=$HUGO_BASEURL
RUN hugo --gc --minify

FROM nginx:alpine
COPY --from=build /src/public /usr/share/nginx/html
EXPOSE 80
