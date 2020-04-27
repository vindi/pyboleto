FROM python:3.5.1

ARG user
ARG uid

RUN test -n "$user"
RUN test -n "$uid"

RUN apt-get update && apt-get install -y \
poppler-utils \
&& rm -rf /var/lib/apt/lists/*

RUN adduser --gecos "$user" --uid "$uid" --disabled-login "$user"

WORKDIR "/home/$user/pyboleto"

USER "$user"
