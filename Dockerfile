# Stage 1: Build Stage
FROM node:20-alpine3.18 as builder

WORKDIR /app

COPY package.json package-lock.json ./

# Install dependencies
RUN npm install && npm cache clean --force

COPY . .

# Build your application
RUN npm run build

# Stage 2: Final Stage
FROM node:20-alpine3.18

WORKDIR /app

# Copy only necessary files from the builder stage
COPY --from=builder /app/.next /app/.next
COPY package.json package-lock.json ./

# Install only production dependencies
RUN npm install --production && npm cache clean --force

# Expose the port
EXPOSE 3000

# Start the application
CMD ["npm", "start"]
