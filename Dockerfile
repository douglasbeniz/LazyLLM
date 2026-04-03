FROM python:3.10-slim

# Install system dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    git \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy project files
COPY . .

# Install Python FULL dependencies (including support to CUDA)
RUN pip install --no-cache-dir -e . && \
    pip install --no-cache-dir --no-build-isolation -r tests/requirements_dev.txt
    #pip install --no-cache-dir --no-build-isolation -r requirements.full.txt

# Set Python path
#dENV PYTHONPATH=/app:$PYTHONPATH

# Tests
CMD ["pytest", "-v", "tests/basic_tests"]