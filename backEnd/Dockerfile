FROM python:alpine

WORKDIR /app

ENV FLASK_APP=server.py

COPY requirements.txt .

RUN pip install -r requirements.txt

COPY . .

ENTRYPOINT ["flask", "run", "--host=0.0.0.0"]

