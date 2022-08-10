SHELL := /bin/bash

helm-deploy:
	export NAMESPACE=zadig; \
	helm upgrade \
	--install zadig --namespace $${NAMESPACE} --version=1.13.0 \
	--set global.extensions.extAuth.extauthzServerRef.namespace=$${NAMESPACE}  ./helm-zadig

helm-undeploy:
	helm uninstall -n zadig zadig

helm-template:
	export NAMESPACE=zadig; \
	helm template \
	--set global.extensions.extAuth.extauthzServerRef.namespace=$${NAMESPACE} ./helm-zadig
