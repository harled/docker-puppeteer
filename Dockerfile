# initially from https://github.com/buildkite/docker-puppeteer/blob/master/Dockerfile
FROM node:18-slim
RUN  apt-get update \
     && apt-get install -y wget gnupg ca-certificates procps libxss1 curl \
     && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
     && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
     && apt-get update \
     # We install Chrome to get all the OS level dependencies, but Chrome itself
     # is not actually used as it's packaged in the node puppeteer library.
     # Alternatively, we could could include the entire dep list ourselves
     # (https://github.com/puppeteer/puppeteer/blob/master/docs/troubleshooting.md#chrome-headless-doesnt-launch-on-unix)
     # but that seems too easy to get out of date.
     && apt-get install -y google-chrome-stable \
     && rm -rf /var/lib/apt/lists/* \
     && wget --quiet https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh -O /usr/sbin/wait-for-it.sh \
     && chmod +x /usr/sbin/wait-for-it.sh

# install cve scanner for the OS
ADD https://github.com/devmatic-it/debcvescan/releases/download/v0.1.28/debcvescan_0.1.28_linux_amd64.deb /tmp/debcvescan_0.1.28_linux_amd64.deb
RUN dpkg -i /tmp/debcvescan_0.1.28_linux_amd64.deb && rm /tmp/debcvescan_0.1.28_linux_amd64.deb

# storage for node_modules
RUN mkdir -p /app/node_modules

# /app as the default work directory
WORKDIR /app

EXPOSE 3001