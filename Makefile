.PHONY: serve build docker

serve:
	hugo server -D

build:
	hugo --gc --minify

docker:
	docker build -t blog . && docker run --rm -p 8080:80 blog
