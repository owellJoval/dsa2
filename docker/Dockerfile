# Use the official Ballerina image as the base image
FROM ballerina/ballerina:2201.0.3

# Set the working directory
WORKDIR /app

# Copy the entire project into the container
COPY ./ /app/

# Expose the port for the services (you can change this according to your services)
EXPOSE 8080

# Set the command to run the Ballerina program (e.g., logistics service)
# You can modify this to point to different Ballerina services or the client
# Example for running the logistics service:
CMD ["bal", "run", "logistics/logistics_service.bal"]

# You can create other containers for different services by changing the CMD line
