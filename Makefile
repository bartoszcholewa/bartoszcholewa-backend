LOCAL=environments/local

status:
	cd $(LOCAL); docker-compose ps

build:
	cd $(LOCAL); docker-compose build

up:
	cd $(LOCAL); docker-compose up

stop:
	cd $(LOCAL); docker-compose stop

down:
	cd $(LOCAL); docker-compose down

restart:
	cd $(LOCAL); docker-compose down && docker-compose up -d

shell-web:
	cd $(LOCAL); docker-compose exec web bash

shell-db:
	cd $(LOCAL); docker-compose exec db bash

log-web:
	cd $(LOCAL); docker-compose logs web

log-db:
	cd $(LOCAL); docker-compose logs db

logs:
	cd $(LOCAL); docker-compose logs -f

collectstatic:
	cd $(LOCAL); docker-compose exec -T web /bin/sh -c "python manage.py collectstatic --noinput"

migrate:
	cd $(LOCAL); docker-compose exec -T web /bin/sh -c "python manage.py migrate"

migrations:
	cd $(LOCAL); docker-compose exec -T web /bin/sh -c "python manage.py makemigrations"

test:
	cd $(LOCAL); docker-compose exec -T web /bin/sh -c "python manage.py test"

TEST_DATE=`date +'%y_%m_%d_%H-%M-%S'`
pytest:
	cd $(LOCAL); docker-compose exec -T web /bin/sh -c "python -m pytest --junitxml=./test-reports/pytest_$(TEST_DATE).xml"

touch:
	cd $(LOCAL); docker-compose exec -T web /bin/sh -c "touch /app/touch-wsgi-reload"

deploy: build backup-predeploy restart migrate collectstatic touch