.PHONY: clean build all development

development:
	cd workshop && hugo server --disableFastRender --environment development

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
	cd workshop && hugo --environment ghpages
	echo "Updating gh-pages branch"
	cd workshop/public && git add --all && git commit -m "Publishing to gh-pages (publish.sh)" && git push
	echo "https://aws-samples.github.io/aws-service-catalog-tools-workshop/"

