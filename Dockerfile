#--- Clone the repo and install the project dependencies ---
# Use the Node.js base image
FROM node:latest AS build

#--- Use node to run app.js which will run the build job and expressJS server ---
FROM node:latest

# Expose the port the app runs on
EXPOSE 3000

# Set the working directory inside the container
WORKDIR /app

# Copy the app files and the node_modules folder from the build image
COPY app.js package.json /app/
COPY --from=build /quartz/ /quartz/
COPY --from=build /app/node_modules/ /app/node_modules/

# bring in the entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Set environment variables for vault and output directories
ENV OUTPUT_DIR=/output
ENV VAULT_DIR=/vault
ENV TIMER=20
ENV FOLDER=/public

# Create directories
RUN mkdir -p $OUTPUT_DIR $VAULT_DIR

# Run the app
CMD ["node", "/app/app.js"]
