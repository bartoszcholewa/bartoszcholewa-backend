build:
	docker-compose build

up:
	docker-compose up

stop:
	docker-compose stop

down:
	docker-compose down

restart:
	docker-compose down && docker-compose up -d

shell-web:
	docker-compose exec web bash

shell-db:
	docker-compose exec db bash

log-web:
	docker-compose logs web  

log-db:
	docker-compose logs db

logs:
	docker-compose logs -f

collectstatic:
	docker-compose exec -T web /bin/sh -c "python manage.py collectstatic --noinput"

migrate:
	docker-compose exec -T web /bin/sh -c "python manage.py migrate"

migrations:
	docker-compose exec -T web /bin/sh -c "python manage.py makemigrations"

test:
	docker-compose exec -T web /bin/sh -c "python manage.py test"

TEST_DATE=`date +'%y_%m_%d_%H-%M-%S'`
pytest:
	docker-compose exec -T web /bin/sh -c "python -m pytest --junitxml=./test-reports/pytest_$(TEST_DATE).xml"

dumpdata:
	docker-compose exec -T web /bin/sh -c "python manage.py dumpdata users auth.Group --natural-foreign --natural-primary --indent 4 > users/fixtures/users.json"
	docker-compose exec -T web /bin/sh -c "python manage.py dumpdata buildings --natural-foreign --natural-primary --indent 4 > buildings/fixtures/buildings.json"
	docker-compose exec -T web /bin/sh -c "python manage.py dumpdata audits --natural-foreign --natural-primary --indent 4 > audits/fixtures/audits.json"
	docker-compose exec -T web /bin/sh -c "python manage.py dumpdata buildings.PointKeyword audits.QuestionCategory audits.Question --natural-foreign --natural-primary --indent 4 > audits/fixtures/questions.json"

loaddata:
	docker-compose exec -T web /bin/sh -c "python manage.py loaddata users/fixtures/users.json"
	docker-compose exec -T web /bin/sh -c "python manage.py loaddata buildings/fixtures/buildings.json"
	docker-compose exec -T web /bin/sh -c "python manage.py loaddata audits/fixtures/audits.json"

touch:
	docker-compose exec -T web /bin/sh -c "touch /app/touch-wsgi-reload"

deploy: build backup-predeploy restart migrate collectstatic touch

# Backups
BACKUP = _backup_
   dummy_backup := $(shell mkdir -p ../../$(BACKUP))
VOLUMES = _volumes_
   dummy_backup := $(shell mkdir -p ../../$(VOLUMES))

WDAY_HOUR=`date +"%u_%H"`
HOUR=`date +"%H"`
include .env
export

backup: backup_db backup_media backup_static

backup_db:
	docker-compose exec -T -u postgres db pg_dump -U ${POSTGRES_USER} ${POSTGRES_DB} | gzip > ../../_backup_/${COMPOSE_PROJECT_NAME}_db-$(WDAY_HOUR).sql.gz

backup_media:
	tar -zcf ../../_backup_/${COMPOSE_PROJECT_NAME}_media-$(HOUR).tar.gz ../../_volumes_/media

backup_static:
	tar -zcf ../../_backup_/${COMPOSE_PROJECT_NAME}_static-$(HOUR).tar.gz ../../_volumes_/static

backup-predeploy:
	docker-compose up -d db
	sleep 5
	docker-compose exec -T -u postgres db pg_dump -U ${POSTGRES_USER} ${POSTGRES_DB} | gzip > ../../_backup_/${COMPOSE_PROJECT_NAME}_db-predeploy.sql.gz

load-predeploy:
	docker-compose down -v
	sleep 5
	docker-compose up -d db
	sleep 5
	zcat "../../_backup_/far_audyt_backend_stag_db-4_15.sql.gz" | docker-compose exec -T -u postgres db psql -U ${POSTGRES_USER} -d ${POSTGRES_DB}
	docker-compose down && docker-compose up -d
	sleep 5
	docker-compose exec -T web /bin/sh -c "python manage.py makemigrations"
	docker-compose exec -T web /bin/sh -c "python manage.py migrate"
	docker-compose exec -T web /bin/sh -c "python manage.py collectstatic"
	docker-compose ps