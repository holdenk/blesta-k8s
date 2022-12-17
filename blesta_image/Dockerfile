FROM ubuntu/apache2:2.4-22.04_beta as base

LABEL Maintainer="Holden Karau" \
      Description="Blesta with Apache & PHP8 Ubuntu"

ENV BLESTA_VERSION=5.5.3 \
    DOWNLOAD_ID=218

# Install packages and remove default server definition
RUN apt-get update && apt-get upgrade -y && apt -y install software-properties-common && \
    apt-get install -y php8.1  php8.1-opcache php8.1-mysqli libapache2-mod-php8.1 php8.1-cli php8.1-curl php8.1-gmp \
    php8.1-xml php8.1-phar php8.1-intl php8.1-dom php8.1-xmlreader php8.1-ctype php8.1-imap \
    php8.1-mysql php8.1-db php8.1-mbstring php8.1-gd php8.1-iconv php8.1-simplexml php8.1-mailparse curl php8.1-phpdbg php8.1-cli php8.1-soap \
    zip

ARG TARGETARCH

# blesta uses either ioncube or source gaurdian for license management

# Download ioncube
RUN cd /tmp \
    && curl -sSL https://downloads.ioncube.com/loader_downloads/ioncube_loaders_lin_$(uname -m | tr "_" "-").tar.gz -o ioncube.tar.gz \
    && tar -xf ioncube.tar.gz \
    && mkdir -p /usr/lib/php/20210902 \
    && mv ioncube/ioncube_loader_lin_8.1.so /usr/lib/php/20210902/ioncube_loader_lin_8.1.so \
    && echo 'zend_extension = /usr/lib/php/20210902/ioncube_loader_lin_8.1.so' > /etc/php/8.1/apache2/conf.d/00-ioncube.ini \
    && rm -rf ioncube.tar.gz ioncube

# Download source gaurdian
RUN cd /tmp \
    && curl -sSL https://www.sourceguardian.com/loaders/download/loaders.linux-$(uname -m).tar.gz -o sg.tgz \
    && tar -xvf sg.tgz \
    && mv ixed.8.1.lin /usr/lib/php/20210902 \
    && echo 'extension=ixed.8.1.lin' > /etc/php/8.1/apache2/conf.d/01-sg.ini \
    && rm sg.tgz ixed*

# Create root directory
RUN mkdir -p /var/www/html

# Download blesta
RUN cd /var/www && \
    curl -Lo blesta.zip https://account.blesta.com/client/plugin/download_manager/client_main/download/${DOWNLOAD_ID}/blesta-${BLESTA_VERSION}.zip \
    && unzip blesta.zip \
    && rm blesta.zip \
    && cp -af ./hotfix-php8/* ./blesta/ \
    && mv html html_back \
    && mv blesta html \
    && chown -R www-data /var/www/html/config \
    && chown -R www-data /var/www/html/cache

# Healthcheck
HEALTHCHECK --timeout=10s CMD curl --silent --fail http://127.0.0.1:80/

