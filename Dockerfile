FROM python:3.5.1

ARG user
ARG uid

RUN test -n "$user"
RUN test -n "$uid"

RUN apt-get update && apt-get install -y \
poppler-utils \
&& rm -rf /var/lib/apt/lists/*

RUN adduser --gecos "$user" --uid "$uid" --disabled-login "$user"

RUN easy_install distribute
RUN pip install --upgrade pip setuptools wheel
RUN pip install pylint tox coverage pep8 sphinx-pypi-upload sphinx

WORKDIR "/home/$user/pyboleto"
USER "$user"
