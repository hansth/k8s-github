#!/bin/bash

# setup mise activation when starting the devcontainer and install the project packages
/usr/local/bin/mise trust /workspaces/$DEVPOD_WORKSPACE_ID/mise.toml && /usr/local/bin/mise install
