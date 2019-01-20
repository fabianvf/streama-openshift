# Streama on OpenShift

This project contains the required resources to build and deploy streama into
OpenShift.

## Streama Image
To build and deploy the streama image locally with podman, run the following commands
(replacing podman with docker should work without issue, but I haven't tested it personally):

```
podman build -t ${IMAGE_NAME} .
podman run --add-host streama:127.0.0.1 -h streama --net=host ${IMAGE_NAME}
```

You will then be able to access the streama interface from `http://localhost:8080`.

You can also consume this image directly from docker.io/homecluster/streama:okd

### Development build
There is also a Dockerfile for building streama from the current master branch.
You can build that with:

```
podman build -t ${IMAGE_NAME} -f Dockerfile.dev .
```

You can also consume this image directly from docker.io/homecluster/streama:dev

## Kubernetes resources

The `deploy/` directory contains a `Deployment` and `Service` to deploy streama
into OpenShift or Kubernetes. You will need to make a `PersistentVolumeClaim`
named `media` in the same namespace as your `Deployment`. If you'd like to
access the streama interface, you can create a Route or Ingress resource.
