# reference https://github.com/puppeteer/puppeteer/blob/main/docker/Dockerfile
FROM node:20-slim

# Install latest chrome dev package and fonts to support major charsets (Chinese, Japanese, Arabic, Hebrew, Thai and a few others)
# Note: this installs the necessary libs to make the bundled version of Chrome that Puppeteer
# installs, work.
RUN  apt-get update \
     && apt-get install -y wget gnupg ca-certificates procps libxss1 curl \
     && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | gpg --dearmor -o /usr/share/keyrings/googlechrome-linux-keyring.gpg \
     && sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/googlechrome-linux-keyring.gpg] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
     && apt-get update \
     && apt-get install -y google-chrome-stable fonts-freefont-ttf libxss1 dbus dbus-x11 --no-install-recommends \
     && apt-get upgrade -y \
     && service dbus start \
     && rm -rf /var/lib/apt/lists/* \
     && wget --quiet https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh -O /usr/sbin/wait-for-it.sh \
     && chmod +x /usr/sbin/wait-for-it.sh

# storage for node_modules
RUN mkdir -p /app/node_modules

# /app as the default work directory
WORKDIR /app

# log the image build date
RUN echo "docker-puppeteer="$(date +"%Y-%m-%d %H:%M %Z") >> /DOCKER_IMAGE_BUILD_HISTORY

# USER pptruser
EXPOSE 3001