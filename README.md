# Streama on OpenShift

This project contains the required resources to build and deploy streama into
OpenShift.

## Usage
To build and deploy the streama image locally with podman, run the following commands
(replacing podman with docker should work without issue, but I haven't tested it personally):

```
podman build -t ${IMAGE_NAME} .
podman run --add-host streama:127.0.0.1 -h streama --net=host ${IMAGE_NAME}
```

You will then be able to access the streama interface from `http://localhost:8080`.

You can also consume this image directly from docker.io/homecluster/streama
