.PHONY: clean build all development install-on-travisci

version := "$(shell git rev-parse --short HEAD)"

install-on-travisci:
	wget -O /tmp/hugo.deb https://github.com/gohugoio/hugo/releases/download/v0.59.1/hugo_0.59.1_Linux-64bit.deb
	sudo dpkg -i /tmp/hugo.deb

development:
	cd workshop && version=Development hugo server --disableFastRender --environment development

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

