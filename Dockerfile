# Use official Node.js runtime image
FROM node:18

# Create app directory inside container
WORKDIR /app

# Copy package.json (and package-lock.json if present)
COPY package*.json ./

# Install dependencies in the container
RUN npm install

# Copy the rest of the application code
COPY . .

# Expose port 3000 so we can reach the app
EXPOSE 3000

# Command to start the app when container runs
CMD ["npm", "start"]
