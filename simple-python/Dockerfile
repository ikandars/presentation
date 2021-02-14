FROM python:3.9

COPY ./requirements.txt .
RUN pip install -r requirements.txt

ENV PORT 80
ENV PYTHONPATH ./
ENV LANG en_US.UTF-8
ENV FLASK_APP app.py
ENV FLASK_DEBUG false
ENV FLASK_ENV production

ADD . .

CMD LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8 gunicorn --timeout 300 --threads 2 --workers 3 --bind 0.0.0.0:$PORT app:app

# docker build -t localhost:5000/simple-python:latest .