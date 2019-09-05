test:
	@docker build -t gatekeeper-manifests .

install-git-hooks:
	@-rm -r .git/hooks
	@ln -sv ../lib/git-hooks .git/hooks