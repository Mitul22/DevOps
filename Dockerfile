# Use an official Node.js runtime as a parent image
FROM node:14

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install project dependencies
RUN npm install

# Copy the rest of the application files to the working directory
COPY . .

# Expose port 3000 to the world outside the container
EXPOSE 3000

# Command to run the application
CMD ["node", "index.js"]
