FROM python:3.9.4-buster

RUN mkdir build

WORKDIR /build

COPY . .

RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 80

WORKDIR /build/app

CMD python -m uvicorn main:app --host 0.0.0.0 --port 80