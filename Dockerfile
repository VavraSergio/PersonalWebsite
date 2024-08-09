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

# Copy project files
COPY . /app/
COPY bot.html /app/

# Configure Nginx
COPY nginx.conf /etc/nginx/nginx.conf

# Expose ports
EXPOSE 5005

# Run the start script
CMD ["nginx", "-g", "daemon off;"]

