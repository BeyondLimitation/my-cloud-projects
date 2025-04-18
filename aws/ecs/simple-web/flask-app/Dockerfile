FROM --platform=$BUILDPLATFORM python:3.13-slim-bookworm AS builder

WORKDIR /root

# Copy textfile
COPY requirements.txt /root/

# Install Python Flask
RUN --mount=type=cache,target=/root/.cache/pip \
    pip3 install -r requirements.txt

# Copy applications
COPY app /root/app
COPY web.py /root/

# Set Environment variable
ENV FLASK_APP=web

# Expose Port number 5000
EXPOSE 5000

# Run Flask app
CMD ["flask", "run", "--host", "0.0.0.0", "--port", "5000"]