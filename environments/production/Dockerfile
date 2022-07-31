## BUILDER ###

# sciagnij oficialny obraz pythona
FROM python:3.10-slim-buster as builder

# Ustaw folder pracy
WORKDIR /app

# Ustaw zmienne srodowiskowe
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Zainstaluj wymagane pakiety dla entrypoint.sh i uWSGI
RUN apt-get -y update && apt-get install -y \
    build-essential \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

# Zainstaluj pakiety
COPY ./src/requirements.txt .
RUN pip wheel --no-cache-dir --no-deps --wheel-dir /app/wheels -r requirements.txt

# sciagnij oficialny obraz pythona
FROM python:3.10-slim-buster

LABEL org.opencontainers.image.source=https://github.com/bartoszcholewa/bartoszcholewa-backend

# Ustaw folder pracy
WORKDIR /app

# Ustaw zmienne srodowiskowe
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Zainstaluj pythonowe pakiety
COPY --from=builder /app/wheels /wheels
COPY --from=builder /app/requirements.txt .
RUN /usr/local/bin/python -m pip install --upgrade pip \
    &&pip install --no-cache /wheels/*

COPY ./src .

CMD ["uwsgi", "--ini", "/app/uwsgi.ini"]