# Crawl4AI Agent Dockerfile
# Based on ottomator-agents/crawl4AI-agent-v2

FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    curl \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Install Playwright browsers
RUN playwright install

# Copy application source
COPY src/ ./src/

# Expose port
EXPOSE 11235

# Health check endpoint
HEALTHCHECK --interval=30s --timeout=10s --start-period=40s --retries=3 \
  CMD curl -f http://localhost:11235/health || exit 1

# Run application
CMD ["streamlit", "run", "src/streamlit_app.py", "--server.port=11235", "--server.address=0.0.0.0"]
