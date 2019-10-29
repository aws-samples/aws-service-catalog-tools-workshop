
clean:
	rm -rf public
	mkdir public
	git worktree prune
	rm -rf .git/worktrees/public/

build:
	echo "Checking out gh-pages branch into public"
	git worktree add -B gh-pages public origin/gh-pages
	echo "Removing existing files"
	rm -rf public/*
	echo "Generating site"
	cd workshop && hugo -d ../public
	echo "Updating gh-pages branch"
	cd public && git add --all && git commit -m "Publishing to gh-pages (publish.sh)" && git push
