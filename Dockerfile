FROM erlang:20.3.8.1-alpine

# WORKDIR is located in the image
#   https://docs.docker.com/engine/reference/builder/#workdir
WORKDIR /root/elvis

RUN apk update && apk --no-cache add curl

RUN curl -lO https://github.com/emqx/rebar3/releases/download/3.14.3-emqx-1/rebar3
RUN chmod +x rebar3

# copy the entire src over and build
COPY . .

RUN ls -la
RUN rebar3 escriptize
RUN mv _build/default/bin/elvis .

# simply print out the version for visibility
ENTRYPOINT ["/root/elvis/elvis"]

