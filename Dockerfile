FROM python:3.5.1

ARG user
ARG uid

RUN test -n "$user"
RUN test -n "$uid"

RUN apt-get update && apt-get install -y poppler-utils=0.26.5-2+deb8u13 \
    && rm -rf /var/lib/apt/lists/*

RUN adduser --gecos "$user" --uid "$uid" --disabled-login "$user"

RUN pip install -Iv distribute==0.7.3 pip==20.1 setuptools==46.1.3 wheel==0.34.2 pillow==6.2.0 \
    && pip install -Iv pylint==2.5.0 tox==3.14.6 coverage==5.1 pep8==1.7.1

WORKDIR "/home/$user/pyboleto"
USER "$user"
