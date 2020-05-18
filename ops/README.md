# xrengine-ops
Deployment and Operations for xrengine services

## One-Click Deployment on Kubernetes using Helm

You can run the whole platfrom with the following commands:
``` bash
helm repo add xrengine https://xrengine.github.io/xrengine-ops/
helm repo update
helm install my-release xrengine/xrengine
```
For more details about the XRChat chart

- [XRChat helm chart](xrengine/)
- [Building the xrengine helm chart](docs/release-helm-chart.md)

For deployment on different cloud providers:

- [Deploying XRChat on AWS EKS](docs/deploy_on_eks.md)
- [Managing Remote Kubernets Clusters - TBD](docs/managing_remote_kubernets.md)

Requires Helm and access to a Kubernetes cluster, if you are new to those, check the following instructions:

- [Installing Helm v3](https://www.digitalocean.com/community/tutorials/how-to-install-software-on-kubernetes-clusters-with-the-helm-3-package-manager)
- [Installing Kubernetes Locally - microk8s](https://ubuntu.com/tutorials/install-a-local-kubernetes-with-microk8s#2-deploying-microk8s)
- [Installing Kubernetes Locally - MiniKube](https://minikube.sigs.k8s.io/docs/start/)
- [Helper Scripts](scripts/) contains useful scripts to speedup preparing your machine with Docker, Helm, k8s, etc.

## One-Click Deployment on your laptop Docker Compose

You can run the whole platfrom with the following commands:
``` bash
git clone git@github.com:xrengine/xrengine-ops.git
cd xrengine-ops
docker-compose up
```
To run specific services
```
docker-compose up <service-name>
```

This will pull images from [xrengine's docker hub repo](https://hub.docker.com/u/xrengine)

## XRChat services

- [server](https://github.com/xrengine/xrengine): backend server on http://localhost:3030/docs
- [client](https://github.com/xrengine/xrengine-client): frontend Next.js+react on http://localhost:3000
- [rts](https://github.com/xrengine/xrengine-realtime-server): Networked AFrame server on http://localhost:8081
- adminer: a lightweight web app to manage database, http://localhost:8080/?server=db&username=server&db=xrengine  (Note: password is "password")
- db: MariaDB on default port [mysql://localhost:3306]() 

## Build docker/compose stack yourself

If you want to build the whole compose stack on your machine, and not pull the containers from docker-hub

- install [docker](https://docs.docker.com/get-docker/).
- clone the 5 repos into the same folder with the same names:
    ```
    |
    +-- xrengine-client
    +-- xrengine
    +-- xrengine-ops
    +-- xrengine-realtime-server
    +-- Spoke
    ```
- `cd xrengine-ops`
- run `docker-compose -f docker-compose-local.yml build`
- run `docker-compose -f docker-compose-local.yml up`
- all services will be running as detailed in [service](Services) section.

## Build the Helm Chart yourself

