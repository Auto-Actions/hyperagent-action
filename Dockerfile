FROM node:18-alpine

# Install git and other dependencies
RUN apk add --no-cache git openssh-client

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