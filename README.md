# Docker FastAPI projects

Motivation: Without knowing the Docker, it was really painfull to get started with FastAPI to build production-ready application running in a Docker Container.

The best video source that I found about Docker for begginers: [Docker For Begginers: From Docker Desktop to Deployment](https://www.youtube.com/watch?v=i7ABlHngi1Q&t=2065s).

This repository allows you to create a simple Docker image with running FastAPI on localhost:80 presenting the basics of creating and running Docker Images. Each step is deeply described below.

# First project

## Project structure

```
.
├── .gitignore                   
├── .dockerignore     # similar to .gitignore    
|                     # but for Docker
|
├── requirements.txt  # pip freeze from
|                     # pip install fastapi[all]
|
├── Dockerfile        # commands to build
|                     # a Docker Image
├── app
|   |── main.py       # FastAPI simple app

```

## Files description

```requirements.txt```, ```.gitignore```, ```.dockerignore ```

Some common stuff. In ```.dockerignore``` I've added ```venv/ ``` and ```.vscode``` - we don't need it in our Container.

``` main.py ```

Basic endpoint from FastAPI tutorial.

``` Dockerfile ```

```dockerfile
# A Dockerfile is a text document that contains all the commands a user could call on the command line to assemble an image.

FROM python:3.9.4-buster
# Our Debian with python is now installed. Imagine we have folders /sys, /tmp, /bin etc. there - like we would install this system on our laptop.

RUN mkdir build
# We create folder named build for our stuff.

WORKDIR /build
# Basic WORKDIR is just /
# Now we just want to our WORKDIR to be /build

COPY . .
# FROM [current folder we run docker run] - TO [current WORKDIR]
# We copy our files (files from .dockerignore are ignored) to the WORKDIR

RUN pip install --no-cache-dir -r requirements.txt

# OK, now we pip install our requirements

EXPOSE 80

# Instruction informs Docker that the container listens on port 80

WORKDIR /build/app

# Now we just want to our WORKDIR to be /build/app for simplicity
# We could skip this part and then type 
# python -m uvicorn main.app:app ... below

CMD python -m uvicorn main:app --host 0.0.0.0 --port 80

# this command runs out uvicorn server
# See Troubleshoots to understand why we need to type --host 0.0.0.0 and --port 80
```

## Get started

