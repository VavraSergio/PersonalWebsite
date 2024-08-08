# Use a lightweight Python image
FROM python:3.9-slim

# Environment variables
ENV LANG=C.UTF-8
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Install system dependencies
RUN apt-get update && apt-get install -y \
    nginx \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy and install Python dependencies
COPY requirements.txt /app/
RUN pip install --upgrade pip \
    && pip install -r requirements.txt

# Copy project files
COPY . /app/
COPY rasa /app/rasa
COPY bot.html /app/

# Configure Nginx
COPY nginx.conf /etc/nginx/nginx.conf

# Expose ports
EXPOSE 80 5005

# Start script to run both Nginx and Rasa
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

# Run the start script
CMD ["/app/start.sh"]

