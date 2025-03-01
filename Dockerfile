FROM eclipse-temurin:21-jre-alpine

WORKDIR /app

# Install curl to download the latest release
RUN apk add --no-cache curl jq

# Create a directory for the application
RUN mkdir -p /app/data

# Download the latest release
RUN curl -s https://api.github.com/repos/tfyre/bambu-farm/releases/latest \
    | grep browser_download_url | grep runner.jar | cut -d'"' -f4 | xargs curl -L -o /app/bambu-web-runner.jar

# Create an empty styles.css file (for custom CSS if needed)
RUN touch /app/styles.css

# Add JVM options for Bouncy Castle support
ENV JAVA_OPTS="-Djdk.tls.useExtendedMasterSecret=false"

# Expose the default port
EXPOSE 8080

# Set volume for persistent data
VOLUME /app/data

# Command to run the application
CMD java $JAVA_OPTS -jar /app/bambu-web-runner.jar
