# Build stage with Bun
FROM node AS development

WORKDIR /app

# Copy package.json and bun.lockb (if exists)
COPY package.json ./

# Install dependencies
RUN npm install

# Copy source code
COPY . .

# Build the application
RUN npm run build

# Production stage with Nginx
FROM nginx:alpine

# Copy built assets from development stage to Nginx html directory
# Replace 'dist' with your actual build output directory
COPY --from=development /app/public /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]