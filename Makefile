SHELL := /bin/bash

helm-init:
	source env.sh; \
	cd helm-zadig; \
	cp values.yaml.tpl values.yaml; \
	sed -i 's|##IP##|'$$IP'|g' values.yaml; \
	sed -i 's|##PORT##|'$$PORT'|g' values.yaml; \
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
	helm upgrade --install zadig --namespace $${NAMESPACE} --version=1.13.0 --set endpoint.type=IP \
	--set endpoint.IP=$${IP} \
	--set gloo.gatewayProxies.gatewayProxy.service.httpNodePort=$${PORT} \
	--set global.extensions.extAuth.extauthzServerRef.namespace=$${NAMESPACE} \
	--set gloo.gatewayProxies.gatewayProxy.service.type=NodePort ./helm-zadig

helm-undeploy:
	helm uninstall -n zadig zadig

helm-template:
	source env.sh; \
	export NAMESPACE=zadig; \
	helm template --set endpoint.type=IP \
	--set endpoint.IP=$${IP} \
	--set gloo.gatewayProxies.gatewayProxy.service.httpNodePort=$${PORT} \
	--set global.extensions.extAuth.extauthzServerRef.namespace=$${NAMESPACE} \
	--set gloo.gatewayProxies.gatewayProxy.service.type=NodePort ./helm-zadig

