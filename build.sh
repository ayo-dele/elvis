#!/bin/bash

set -ex

rebar3 escriptize
mv _build/default/bin/elvis .