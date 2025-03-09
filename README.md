# Node.js Docker Image

A Node.js Docker image based on `node:alpine` with package managers (npm, yarn, and corepack) removed, reducing image size by `11.5%`.

[![Docker Pulls](https://img.shields.io/docker/pulls/utsavladani/node)](https://hub.docker.com/r/utsavladani/node)
[![Docker Image Size](https://img.shields.io/docker/image-size/utsavladani/node/latest)](https://hub.docker.com/r/utsavladani/node)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

## Image Details

- **Node.js Version**: 23.9.0
- **Base Image**: alpine:3.21
- **Size**: 140.59MB
- **Docker Hub**: [utsavladani/node](https://hub.docker.com/r/utsavladani/node)
- **Tags**: `latest`
- **GitHub**: [Utsav-Ladani/node-image](https://github.com/Utsav-Ladani/node-image)

## Why Use This Image?

While there are many Node.js Docker images available, this image is specifically designed for production deployments where:

- **Smaller size** is crucial for faster deployments and reduced attack surface
- **Package managers** are not needed in production

## How to Use This Image

### Simple Application (No Build Step)

For applications that don't require package managers or build steps:

```dockerfile
FROM utsavladani/node:latest

WORKDIR /app

# Copy application code
COPY . .

EXPOSE 3000

CMD ["node", "index.js"]
```

### Complex Application (With Build Step)

For applications requiring npm packages and build process:

```dockerfile
FROM node:23.9.0-alpine3.21 AS base

# ---------------------------------
# Stage: Build
FROM base AS builder
WORKDIR /app
COPY . .
RUN npm ci
RUN npm run build

# ---------------------------------
# Stage: Production Dependencies
FROM base AS production-dependencies
WORKDIR /app
COPY package*.json ./
RUN npm ci --omit=dev

# ---------------------------------
# Stage: Runtime
FROM utsavladani/node:latest
WORKDIR /app
COPY --from=builder /app/dist ./
COPY --from=production-dependencies /app/node_modules ./node_modules
EXPOSE 3000
CMD ["node", "index.js"]
```

### Building and Running

```bash
# Build the image
docker build -t my-app:latest .

# Run the image
docker run -it --rm -p 3000:3000 --name my-app my-app:latest
```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---
Made with ❤️ by [Utsav Ladani](https://github.com/Utsav-Ladani)
