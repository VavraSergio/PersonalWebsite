#!/bin/bash

# Start Nginx in the background
nginx &

# Start Rasa
rasa run --enable-api --cors "*"

