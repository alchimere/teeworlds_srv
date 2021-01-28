#!/bin/bash
envsubst < tpl/cfg.tpl > config/config.cfg
teeworlds/teeworlds_srv -f config/config.cfg
