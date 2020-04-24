FROM python:3.5-buster

RUN apt-get update && apt-get install -y locales git cmake libpoppler82 \
&& rm -rf /var/lib/apt/lists/* \
&& localedef -i pt_BR -c -f UTF-8 -A /usr/share/locale/locale.alias pt_BR.UTF-8
ENV LANG pt_BR.UTF-8
ENV LC_ALL pt_BR.UTF-8

WORKDIR "/usr/src/poppler"
COPY poppler-0.40.0.tar.xz .


RUN tar -xJf poppler-0.40.0.tar.xz -C . \
    && cd poppler-0.40.0 \
    && mkdir build \
    && cd build \
    && cmake .. \
    && make \
    && make install
RUN cp /usr/local/lib/libpoppler.so.58 /usr/lib/

ARG user
ARG uid

RUN test -n "$user"
RUN test -n "$uid"

WORKDIR "/home/$user/pyboleto"

COPY requirements.txt .

RUN pip3 install -U pip setuptools \
    && pip3 install -r requirements.txt

RUN adduser --gecos "$user" --uid "$uid" --disabled-login "$user"

USER "$user"
