#!/bin/bash

LOG_DONE="[\e[32mDONE\e[0m]"
LOG_ERROR="[\e[1;31mERROR\e[0m]"
LOG_INFO="[\e[34mINFO\e[0m]"
LOG_WARN="[\e[93mWARN\e[0m]"

uiBundleName="ui-bundle-ubuntu"
containerNameKroki="kroki-kobol-antora-build"

function krokiStart() {
    echo -e "$LOG_INFO start kroki server"
    docker run -d --rm --name $containerNameKroki -p 9001:8000 yuzutech/kroki:latest
    echo -e "$LOG_DONE kroki server up and running"
}

function krokiStop() {
    echo -e "$LOG_INFO stop kroki server"
    docker stop $containerNameKroki
    echo -e "$LOG_DONE stopped kroki server"
}

function buildDocs() {
    echo -e "$LOG_INFO build docs"
    #antora --stacktrace antora-playbook-public.yml
    DOCSEARCH_ENABLED=true DOCSEARCH_ENGINE=lunr antora generate antora-playbook.yml --stacktrace --generator antora-site-generator-lunr --clean --fetch
    echo -e "$LOG_DONE build docs"
}

################################################################################
#   antora build                                                               #
################################################################################

clear
mkdir -p target
rm -rf target/*
echo -e "$LOG_DONE clean"

krokiStart
buildDocs
# deploySnapshot $uiBundleName
krokiStop

echo -e "$LOG_DONE ------------------------------------------------------------------"
echo -e "$LOG_DONE Finished build"
echo -e "$LOG_DONE ------------------------------------------------------------------"

echo -e "$LOG_INFO starting webserver"
webserver 9000 target/public
