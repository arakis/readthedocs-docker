FROM readthedocs/build:5.0

# https://docs.readthedocs.io/en/stable/development/install.html

ENV PYTHON python3.6
ENV PIP pip3.6

USER root

# PDF support
RUN apt-get update
RUN apt-get install -y inkscape
RUN rm -rf /var/lib/apt/lists/*

RUN mkdir /data \
    && chown docs:docs /data

USER docs
WORKDIR /home/docs

#RUN git clone --recurse-submodules https://github.com/rtfd/readthedocs.org.git
RUN git clone -b '3.5.3' --single-branch https://github.com/rtfd/readthedocs.org.git
WORKDIR /home/docs/readthedocs.org
RUN $PIP install -r requirements.txt                    \
    && pip3.6 install sphinxcontrib-svg2pdfconverter    \
    && pip3.7 install sphinxcontrib-svg2pdfconverter

ENV DJANGO_SETTINGS_MODULE=readthedocs.settings.dev

COPY entrypoint.sh /
COPY django-rtd-create-users.py /home/docs/readthedocs.org
COPY dev.py /home/docs/readthedocs.org/readthedocs/settings
#COPY local_settings.py /home/docs/readthedocs.org/readthedocs/settings

WORKDIR /home/docs/readthedocs.org

RUN ln -s /data/media/json media/       \
    && ln -s /data/media/htmlzip media/ \
    && ln -s /data/media/pdf media/     \
    && ln -s /data/media/epub media/    \
    && ln -s /data/public_web_root .    \
    && ln -s /data/user_builds .

ENTRYPOINT ["/entrypoint.sh"]