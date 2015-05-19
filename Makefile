NAME = dariusbakunas/nginx
VERSION = latest

all: build

build:
	docker build -t $(NAME):$(VERSION) --rm=true .