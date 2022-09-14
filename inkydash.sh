#!/bin/sh
firefox --headless --screenshot --disable-gpu --window-size=600,448 file:///home/alpine/inkydash.html
yes '' | su - root 'python3 /home/alpine/inkydash.py'