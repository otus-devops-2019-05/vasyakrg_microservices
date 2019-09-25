# FROM python:3.6.0-alpine
FROM python:2.7
WORKDIR /app
ADD requirements.txt /app
RUN pip install -r requirements.txt
ADD . /app
EXPOSE  5000

ENV POST_DATABASE_HOST post_db
ENV POST_DATABASE post

ENTRYPOINT ["python", "post_app.py"]
