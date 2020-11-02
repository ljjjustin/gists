#!/bin/bash

sudo npm uninstall npm -g
brew uninstall node

sudo rm -rf /usr/local/lib/dtrace/node.d \
            /usr/local/lib/node_modules \
            /usr/local/share/man/*/node* \
            /usr/local/share/man/*/npm* \
            /usr/local/bin/npm \
            /usr/local/bin/nodemon \
            /usr/local/bin/node \
            /usr/local/include/node \
            ~/.npm* ~/.node*
