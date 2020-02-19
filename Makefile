SHELL := /bin/bash

test:
	@docker build -t gatekeeper-manifests .

install-git-hooks:
	@-rm -r .git/hooks
	@ln -sv ../lib/git-hooks .git/hooks

# Hack to take arguments from command line
# Usage: `make release 3.1.0-beta.7`
# https://stackoverflow.com/questions/6273608/how-to-pass-argument-to-makefile-from-command-line
release:
	@sed -i 's#\(gatekeeper-manifests/.*?ref=\).*#\1$(filter-out $@,$(MAKECMDGOALS))#g' README.md example/kustomization.yaml

%:		# matches any task name
	@:	# empty recipe = do nothing
