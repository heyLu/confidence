#!/bin/sh

# Update my RSS/ATOM planet using `venus`.

cd /home/lu/t/venus
python2 planet.py
touch planet.updated
