FROM python:3.8-slim-buster

COPY ./app/requirements.txt /app/
COPY ./app/api.py /app/

WORKDIR /app

RUN pip3 install -r requirements.txt

ENTRYPOINT [ "gunicorn", "-b", "0.0.0.0:8000", "--log-level", "debug", "api:app" ]

