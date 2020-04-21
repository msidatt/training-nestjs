### BUILD STAGE

# Starts a build container based on https://hub.docker.com/_/node image (using the Alpine minimal linux)
FROM node:lts-alpine as build-stage

# Creates the app directory inside the build container and CDs into the directory
WORKDIR /app

# Copies package.json and package-lock.json into the working directory (above)
COPY package*.json ./

# Installs all dependencies in the build container
RUN npm ci

# Copies all non-ignored files in the development folder into the container's working directory
COPY . .

# Executes the app build process
RUN npm run build

### PRODUCTION STAGE

# Starts a production container based on https://hub.docker.com/_/node image (using the Alpine minimal linux)
FROM node:lts-alpine as production-stage

# Creates the app directory inside the production container and CDs into the directory
WORKDIR /app

# Copies the output of the build stage into the production container
COPY --from=build-stage /app/dist ./dist

# Copies package.json and package-lock.json into the working directory (above)
COPY --from=build-stage /app/package*.json ./

# Installs production dependencies in the production container
RUN npm ci --only=production

# Define the network port that this container will listen on at runtime
EXPOSE 3000

# Provide defaults for an executing the container
CMD ["npm", "run", "start:prod"]