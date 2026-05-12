FROM python:3.11-slim

# Install necessary system dependencies
RUN apt-get update && apt-get install -y \
    firefox-esr \
    wget \
    curl \
    tar \
    gnupg \
    && rm -rf /var/lib/apt/lists/*

# Set LANG as UTF-8 to prevent encoding issues
ENV LANG=C.UTF-8

# Set working directory
WORKDIR /app

# Set environment variables to use headless mode for Firefox
ENV MOZ_HEADLESS=1

# Copy the requirements.txt and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the entire project to the app folder
COPY . .

# Ensure permissions for app execution
RUN chmod +x src/main.py

# Default command to run the application
CMD ["python", "src/main.py"]
