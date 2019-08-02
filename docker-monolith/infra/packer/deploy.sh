#!/bin/bash

packer build -var-file=docker-monolith/infra/packer/variables.json docker-monolith/infra/packer/dockerpuma.json
