SHELL := /bin/bash

helm-init:
	source env.sh; \
	cd helm-zadig; \
	cp values.yaml.tpl values.yaml; \
	sed -i 's|##FQDN##|'$$FQDN'|g' values.yaml; \
	sed -i 's|##GLOBAL_SECRET##|'$$GLOBAL_SECRET'|g' values.yaml; \
	sed -i 's|##MYSQL_HOST##|'$$MYSQL_HOST'|g' values.yaml; \
	sed -i 's|##MYSQL_PORT##|'$$MYSQL_PORT'|g' values.yaml; \
	sed -i 's|##MYSQL_SECRET##|'$$MYSQL_SECRET'|g' values.yaml; \
	sed -i 's|##MONGO_DSN##|'$$MONGO_DSN'|g' values.yaml; \
	sed -i 's|##MONGO_SECRET##|'$$MONGO_SECRET'|g' values.yaml; \
	sed -i 's|##MINIO_DSN##|'$$MINIO_DSN'|g' values.yaml; \
	sed -i 's|##MINIO_AK##|'$$MINIO_AK'|g' values.yaml; \
	sed -i 's|##MINIO_SK##|'$$MINIO_SK'|g' values.yaml; \
	sed -i 's|##CLIENT_SECRET##|'$$CLIENT_SECRET'|g' values.yaml; \

helm-deploy:
	source env.sh; \
	export NAMESPACE=zadig; \
	helm upgrade \
	--install zadig --namespace $${NAMESPACE} --version=1.13.0 \
	--set gloo.gatewayProxies.gatewayProxy.service.httpPort=8080 \
	--set global.extensions.extAuth.extauthzServerRef.namespace=$${NAMESPACE}  ./helm-zadig

helm-undeploy:
	helm uninstall -n zadig zadig

helm-template:
	source env.sh; \
	export NAMESPACE=zadig; \
	helm template \
	--set gloo.gatewayProxies.gatewayProxy.service.httpPort=8080 \
	--set global.extensions.extAuth.extauthzServerRef.namespace=$${NAMESPACE} ./helm-zadig
