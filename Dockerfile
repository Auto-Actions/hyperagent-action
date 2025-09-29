FROM node:18-alpine

# Install git and other dependencies
RUN apk add --no-cache git openssh-client

# Configure git globally to avoid local config issues
RUN git config --global init.defaultBranch master
RUN git config --global user.name "HyperAgent"
RUN git config --global user.email "action@github.com"
RUN git config --global --add safe.directory '*'

# Set working directory
WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm ci --only=production

# Copy source code
COPY . .

# Set executable permissions
RUN chmod +x entrypoint.sh

# Set entrypoint
ENTRYPOINT ["/app/entrypoint.sh"]