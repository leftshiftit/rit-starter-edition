# Supported tags and respective `Dockerfile` links

-	[`9.0`, `latest` (*9.0/Dockerfile*)](https://github.com/leftshiftit/rit-starter-edition/blob/master/Dockerfile)

[![](https://badge.imagelayers.io/leftshiftit/rit-starter-edition:latest.svg)](https://imagelayers.io/?images=leftshiftit/rit-starter-edition:latest)

(note: imagelayers.io doesn't currently support the new Docker storage model. Link above provided for layer tracability, but image is obviously not 0 bytes :p)

# What is Rational Integration Tester (SE)?

IBM® Rational® Integration Tester Starter Edition helps you get up and running with integration testing. With the starter edition, you can use graphical tools to create and run integration tests for your web, RESTful, and SOAP services, JMS-based messaging applications, and other technologies. You can also virtualize services (stubbing) to control the data and create scenarios for application testing, and run them for up to 5 minutes.

*(note: THIS IMAGE IS NOT OFFICIALLY ENDORSED / SUPPORTED BY IBM)*

> [Rational Integration Tester Starter Edition](https://developer.ibm.com/testing/docs/starter-editions/ibm-rational-integration-tester-starter-edition/)

![logo](https://raw.githubusercontent.com/leftshiftit/rit-starter-edition/master/rit-logo.png)

# How to use this image

This image has only been tested on an Ubuntu 14.04 host. It is unlikely to work on Windows / OSX (without some hacking) as it relies on mounting the X11 socket from the host into the container. This is more of a PoC right now so YMMV. 

**Security:** There are security implications with mounting the host X11 socket into the container. These are mitigated somewhat by the process not running as root inside the container (and mounting X11 as read-only) but you should still research and be aware of the risks if you are concerned.

## Starting a basic RIT image

Project data will be persisted in the container once RIT is closed. Restart the container to see your projects. A better alternative is to use volumes though (next section below).

```console
$ docker run --name <container-name> -e DISPLAY -v "/tmp/.X11-unix:/tmp/.X11-unix:ro" leftshiftit/rit-starter-edition:<image-tag>
```

... where `<container-name>` is the name you want to assign to your container (e.g. rit-se) and `<image-tag>` is the tag specifying the RIT version you want (e.g. 9.0). See the list above for relevant tags. If no tag is supplied then Docker will pull the `latest` version by default.

## Mount your existing projects as a volume

If you already have several RIT projects on your host machine, or want your projects available outside of your container then you will want to mount a host volume:

```console
$ docker run --name <container-name> -e DISPLAY -v "<path-to-local-projects>:/home/rit/projects" -v "/tmp/.X11-unix:/tmp/.X11-unix:ro" leftshiftit/rit-starter-edition:<image-tag>
```

... where `<path-to-local-projects>` is the path to the local projects folder you want to mount inside the container (e.g. `/home/john/rit-projects`).

## Running Virtual Services (Stubs)

If you want to run virtual services from your RIT container then you will need to map the ports you need. If you are running a virtual service inside your container on `localhost:8080` and want to be able to connect from outside the container, you need to do the following:

```console
$ docker run --name <container-name> -e DISPLAY -p <host-port>:8080 -v "<path-to-local-projects>:/home/rit/projects" -v "/tmp/.X11-unix:/tmp/.X11-unix:ro" leftshiftit/rit-starter-edition:<image-tag>
```

... where `<host-port>` is the port you want to be able to connect to on the host to hit your virtual service (e.g. `9000`). Once your virtual service is running you should be able to hit it from the host by exercising http://<host-name>:<host-port>.

# Supported Docker versions

This image is supported (& tested) on Docker version 1.10.3. Should work with older versions but YMMV.

Please see [the Docker installation documentation](https://docs.docker.com/installation/) for details on how to upgrade your Docker daemon.

# User Feedback

## Issues

This image is not officially endorsed or supported by IBM or LeftShift IT. Use at your own risk. That said...

If you have any problems with or questions about this image, please contact us through a [GitHub issue](https://github.com/leftshiftit/rit-starter-edition/issues).

## Contributing

You are invited to contribute new features, fixes, or updates, large or small; we are always thrilled to receive pull requests, and do our best to process them as fast as we can.

Before you start to code, we recommend discussing your plans through a [GitHub issue](https://github.com/leftshiftit/rit-starter-edition/issues), especially for more ambitious contributions. This gives other contributors a chance to point you in the right direction, give you feedback on your design, and help you find out if someone else is working on the same thing.