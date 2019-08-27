all:
	@docker build -t gatekeeper-manifests .

rego:
	@docker build -t gatekeeper-manifests-rego --target $@ .

kustomize:
	@docker build -t gatekeeper-manifests-kustomize --target $@ .

install-git-hooks:
	@-rm -r .git/hooks
	@ln -sv ../lib/git-hooks .git/hooks