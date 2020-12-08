# https://docs.docker.com/engine/reference/builder/#from
#   "The FROM instruction initializes a new build stage and sets the
#    Base Image for subsequent instructions."
FROM erlang:20.3.8.1-alpine as builder
# https://docs.docker.com/engine/reference/builder/#label
#   "The LABEL instruction adds metadata to an image."
LABEL stage=builder

RUN ln -s /var/cache/apk /etc/apk/cache && \
    apk update && \
    apk add --update openssh-client git

# WORKDIR is located in the image
#   https://docs.docker.com/engine/reference/builder/#workdir
WORKDIR /root/elvis

# copy the entire src over and build
COPY . .

RUN rebar3 escriptize
RUN mv _build/default/bin/elvis .

# simply print out the version for visibility
ENTRYPOINT ["/root/elvis/elvis"]

