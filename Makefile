LOCAL=$(MAKE) -C environments/local

status-local:
	$(LOCAL) docker-compose ps

build-local:
	$(LOCAL) build

up-local:
	$(LOCAL) up

stop-local:
	$(LOCAL) stop

down-local:
	$(LOCAL) down

restart-local:
	$(LOCAL) restart

shell-web-local:
	$(LOCAL) shell-web

shell-db-local:
	$(LOCAL) shell-db

log-web-local:
	$(LOCAL) log-web

log-db-local:
	$(LOCAL) log-db

logs-local:
	$(LOCAL) logs

collectstatic-local:
	$(LOCAL) collectstatic

migrate-local:
	$(LOCAL) migrate

migrations-local:
	$(LOCAL) migrations

test-local:
	$(LOCAL) test

pytest-local:
	$(LOCAL) pytest

loaddata-local:
	$(LOCAL) loaddata

dumpdata-local:
	$(LOCAL) dumpdata

touch-local:
	$(LOCAL) touch

deploy-local:
	$(LOCAL) deploy