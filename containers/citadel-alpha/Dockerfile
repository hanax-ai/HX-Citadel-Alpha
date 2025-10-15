# Citadel Alpha Dockerfile
# Modified Crawl4AI Agent for HX Platform Integration

FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Install system dependencies including Playwright requirements
RUN apt-get update && apt-get install -y \
    curl \
    ca-certificates \
    # Playwright browser dependencies
    libnss3 \
    libnspr4 \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libcups2 \
    libdrm2 \
    libdbus-1-3 \
    libxkbcommon0 \
    libxcomposite1 \
    libxdamage1 \
    libxfixes3 \
    libxrandr2 \
    libgbm1 \
    libasound2 \
    libpango-1.0-0 \
    libcairo2 \
    # Redis client tools (optional, for debugging)
    redis-tools \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Install Playwright browsers
RUN playwright install chromium
RUN playwright install-deps chromium

# Copy application source
COPY src/ ./src/

# Create directories for data and logs
RUN mkdir -p /app/data /app/logs

# Expose API port
EXPOSE 11236

# Health check endpoint
HEALTHCHECK --interval=30s --timeout=10s --start-period=40s --retries=3 \
  CMD curl -f http://localhost:11236/health || exit 1

# Run FastAPI application with Uvicorn
CMD ["uvicorn", "src.api.main:app", "--host", "0.0.0.0", "--port", "11236", "--log-level", "info"]
