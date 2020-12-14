# Dockerfile Template for Payara Micro

This template provides a Dockerfile for Payara Micro. You can generate a compatible project with this [generator](https://start.microprofile.io/):

1. Fill the form
1. Select Payara Micro as the MicroProfile Runtime
1. Start the download
1. Unzip the project files

The zip contains two services (service-a and service-b). service-a contains the example implementations for the selected specifications. service-b contains the example code to send requests to service-a.
  
# Dockerfile

The Dockerfile conforms the best practices of this blog entry from docker.com: [Intro Guide to Dockerfile Best Practices](https://www.docker.com/blog/intro-guide-to-dockerfile-best-practices/)

## Usage

1. Copy the Dockerfile to the root of your service
1. Replace 'service' with your service name (COPY and ENTRYPOINT in the second stage)
1. Build the image and choose a tag `podman build --tag=service .`

`podman run --name service-name -p 8080:8080 -d localhost/service`

The application is accessible under [localhost:8080](http://localhost:8080/)

*You can use Docker instead. Just replace podman with docker.*

## Structure

The Dockerfile is composed of two stages which create respectively an image:

**First stage (build):**
- Based on [maven](https://hub.docker.com/_/maven)
- Builds the Jar file

**Second stage (runtime):**
- Based on [openjdk11](https://hub.docker.com/r/adoptopenjdk/openjdk11/)
- Copies the jar file from the first stage
- Provides the endpoint
