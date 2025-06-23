# Dockerfile
FROM python:3.11-slim

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt


# Copy app code
COPY . .


# Expose port
EXPOSE 8000

# Run using Daphne (ASGI server for WebSockets support)
CMD ["daphne", "-b", "0.0.0.0", "-p", "8000", "a_core.asgi:application"]
