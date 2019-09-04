# Dockerfile for mybinder.org
#
# Test this Dockerfile:
#
#     docker build -t compiler2019fall .
#     docker run --rm -p 8888:8888 --name learn-you-a-haskell --env JUPYTER_TOKEN=x compiler2019fall:latest
#

FROM crosscompass/ihaskell-notebook:e763dc764d90

USER root

RUN mkdir /home/$NB_USER/part1
COPY part1/*.ipynb /home/$NB_USER/part1/
RUN chown --recursive $NB_UID:users /home/$NB_USER/part1

USER $NB_UID

ENV JUPYTER_ENABLE_LAB=yes
