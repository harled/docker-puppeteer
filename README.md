# Docker Puppeteer

## Description

A simple image to help when running a node application that leverages Pupeteer with a headless Chromium.

## Versions

See the list of [Docker Hub tags](https://hub.docker.com/r/krsyoung/puppeteer/tags/) for Puppeteer versions available.


## Releasing

1. docker build -t puppeteer:1.0.2 .
2. docker tag puppeteer:1.0.2 krsyoung/puppeteer:1.0.2
3. docker push krsyoung/puppeteer:1.0.2