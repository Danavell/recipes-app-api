FROM python:3.7-alpine
LABEL author="James"

# Creates environmental variable that tells python to run 
# in unbuffered mode. Recommended when running python in containers.
# It doesn't allow python to buffer outputs. Avoids complications
# with docker image 
ENV PYTHONUNBUFFERED 1

# copies the requirements text from the directory into the image
COPY ./requirements.txt /requirements.txt

RUN pip install -r /requirements.txt

# Makes directory in image for storing the source code of the app.
# Creates new directory  
RUN mkdir /app
# Switches to this directory as the default working directory.
# Any application using the container will start running from this 
# location unless otherwise specified
WORKDIR /app    
# Copies app folder from local machine and copies it into the image
COPY ./app /app


# Creates new user. -D means create a user which will be used ONLY
# for running applications
RUN adduser -D user
# Switch to the user
USER user
# THis is fone for security reasons. If a user -D is not created, 
# the image will be run using the root account. This is not 
# recommmended since any intruder can have root access to the entire
# image. Creating a seperate user for the image limits the scope 
# an attacker would have in the docker image