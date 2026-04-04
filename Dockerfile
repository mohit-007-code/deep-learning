FROM python:3.10-slim

WORKDIR /app

# System dependencies (important for TF + OpenCV)
RUN apt-get update && apt-get install -y \
    build-essential \
    libglib2.0-0 \
    libsm6 \
    libxext6 \
    libxrender-dev \
    && rm -rf /var/lib/apt/lists/*

# Install uv
RUN pip install uv

# Copy ONLY docker-specific config
COPY pyproject.docker.toml pyproject.toml

# Install dependencies (Linux environment)
RUN uv sync --no-cache

# Copy project files
COPY . .

CMD ["uv", "run", "python", "main.py"]