# Docker Puppeteer

## Description

A simple image to help when running a node application that leverages Pupeteer with a headless Chromium.

## Versions

See the list of [Docker Hub tags](https://hub.docker.com/r/krsyoung/puppeteer/tags/) for Puppeteer versions available.


## Releasing

1. docker build --no-cache -t puppeteer:1.0.4 .
2. docker tag puppeteer:1.0.4 krsyoung/puppeteer:1.0.4
3. docker push krsyoung/puppeteer:1.0.4