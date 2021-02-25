#!/bin/bash

LOG_DONE="[\e[32mDONE\e[0m]"
LOG_ERROR="[\e[1;31mERROR\e[0m]"
LOG_INFO="[\e[34mINFO\e[0m]"

uiBundle="ui-bundle-ubuntu"

echo -e "$LOG_INFO Install npm modules"

rm -rf src/main/antora/$uiBundle/ui/node_modules
rm -rf node_modules
echo -e "$LOG_DONE clean"

# build docs
npm install
npm install mkdirp@latest
npm install antora-site-generator-lunr
echo -e "$LOG_DONE npm install for docs"
