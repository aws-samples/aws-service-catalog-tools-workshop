.PHONY: clean build all development gh-pages-on-travisci gh-pages docker-build docker

version := "$(shell git rev-parse --short HEAD)"
GH_REF := "$(shell git remote get-url origin | awk "{sub(/https:\/\//,\"https://${GH_TOKEN}@\")}; 1" | awk "{sub(/\.git/, \"\")} 1")"

development:
	cd workshop && version=Development hugo server --disableFastRender

clean:
	rm -rf workshop/public
	mkdir workshop/public
	git worktree prune
	rm -rf .git/worktrees/public/


gh-pages: clean
	echo "Checking out gh-pages branch into public"
	git worktree add -B gh-pages workshop/public origin/gh-pages
	echo "Removing existing files"
	rm -rf workshop/public/*
	echo "Generating site"
	cd workshop && version=$(version) hugo --environment ghpages
	echo "Updating gh-pages branch"
	cd workshop/public && git add --all && git commit -m "Publishing to gh-pages (publish.sh)" && git push
	echo "https://aws-samples.github.io/aws-service-catalog-tools-workshop/"


gh-pages-on-travisci: clean
	git config remote.origin.fetch +refs/heads/*:refs/remotes/origin/*
	git fetch --unshallow origin gh-pages
	git worktree add -B gh-pages workshop/public origin/gh-pages
	rm -rf workshop/public/*
	echo "Generating site"
	cd workshop && version=$(version) hugo --environment ghpages
	echo "Updating gh-pages branch"
	cd workshop/public && git add --all && git commit -m "Publishing to gh-pages (publish.sh)" && git push --quiet $(GH_REF) gh-pages  > /dev/null 2>&1

docker-build:
	docker build . -t hugo

docker:
	docker run --rm -v $$PWD/workshop:/content -p 1313:1313 hugo server --bind 0.0.0.0 --disableFastRender