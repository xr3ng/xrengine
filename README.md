[![Build Status](https://travis-ci.org/xrengine/xrengine.svg?branch=master)](https://travis-ci.org/xrengine/xrengine)
# xrengine

> Backend server for XREngine, built on Node + Feathers + Express + SQL

## About

XREngine is an end-to-end solution for hosting humans and non-humans in a virtual space. This project would literally not be possible without the community contributions of Mozilla Hubs, Janus VR, Avaer + Exokit, Mr Doob, Hayden James Lee and many others.

Our goal is an easy-to-use, well documented, end-to-end Javascript (or Typescript) exprience that anyone with a little bit of Javascript and HTML knowledge can dig into, deploy and make meaningful modifications and contributions to. If you fit this category and you are struggling with any aspect of getting started, we want to hear fromm you so that this can be a better exprience.

XREngine is a free, open source, MIT-licensed project. You are welcome to do anything you want with it. We hope that you use it to make something beautiful.

This is the server portion of XREngine. To deploy everything at once with Kubernetes or Docker Compose, check out the branches in xrengine-ops. Or you can start the server with NPM (check out scripts/start-db.sh to get the database runnning) run the xrengine-client client and everything should connect out of the box.

## Getting Started

Getting up and running is as easy as 1, 2, 3.

1. Make sure you have [NodeJS](https://nodejs.org/) and [npm](https://www.npmjs.com/) installed.
2. Install your dependencies

    ```
    cd path/to/xrengine
    npm install
    ```
3. Make sure you have a mysql database installed and running -- our recommendation is Mariadb. We've provided a docker container for easy setup:
```
cd scripts && ./start-db.sh
```

4. Start your app

    ```
    npm start
    ```
    
## Weird issues with your database?
Try
```
npm run dev-reinit-db
```


## Testing

Simply run `npm test` and all your tests in the `test/` directory will be run.

## Linting

`npm run lint`

## Scaffolding

Feathers has a powerful command line interface. Here are a few things it can do:

```
$ npm install -g @feathersjs/cli          # Install Feathers CLI

$ feathers generate service               # Generate a new Service
$ feathers generate hook                  # Generate a new Hook
$ feathers help                           # Show all commands
```

## Docker

You can run it using docker, if you don't have node installed or need to test.
``` bash
# Build the image
docker build --tag xrengine .

# Run the image (deletes itself when you close it)
docker run -d --rm --name server -e "MYSQL_URL=mysql://server:password@db:3306/xrengine" -p "3030:3030"  xrengine

# Stop the server
docker stop server
```

### Docker image configurations

Enviroment variables:
- `NODE_ENV` controls the config/*.js file for feathers.js to load [default: production]
- `PORT` controls the listening port [default: 3030]
- `MYSQL_URL` e.g. `mysql://<user>:<pass>@<host>:<port>/<db>` points to MariaDB server with a username and password

## Help

For more information on all the things you can do with Feathers visit [docs.feathersjs.com](http://docs.feathersjs.com).


### Run in Kubernetes locally

First, you'll need minikube installed and running, as well as kubectl. Next, you'll want to point your shell to minikube's docker-env
so that you don't need to push the Docker image to an external repository. Run the following:

```eval $(minikube docker-env)```

For now, this process will use a separate Dockerfile called 'Dockerfile-dev'. You'll have to build the image using
it by running the following command:

```docker build -t xrengine/xrengine:v0.0.0 -f Dockerfile-dev .```

Once that image is built, make sure that kubectl is pointed to minikube.
Run ```kubectl config get-contexts``` and there should be a '*' next to minikube; alternatively, run 
```kubectl config current-context```, and it should show minikube.
If it's not, run ```kubectl config set-context minikube``` to change to it.

You'll need to deploy two Kustomize scripts to Minikube.
The first one is the nginx-ingress setup.
Run ```kubectl apply -k kubernetes/nginx/base```.

You'll need to have a file called 'xrengine-dev-secrets.env' in kubernetes/xrengine/base.
This is in the gitignore to demonstrate that these sorts of files should never be committed.
The production one is expected to be called 'xrengine-secrets.env' and is also in the gitignore.
As these are very sensitive files, they should be transmitted to you securely.

Finally run ```kubectl apply -k kubernetes/xrengine/base``` to deploy the MariaDB server and xrengine.
The server is set up in dev mode to be behind the domain 'api.dev.xrengine.io' and is secured by a self-signed certificate.
If you wanted to call one of the endpoints with curl, you could run the following and get a 401 error: 
```curl https://192.168.99.109/user -H HOST:api.dev.xrengine.io --insecure```

NOTE: As of this writing, the MariaDB server sometimes finishes initializing after xrengine has already tried to
connect to it. To reboot xrengine, run the following:

```kubectl rollout restart -n xrengine deployments/xrengine```

## Migrations

### Generate Migration file

```node_modules/.bin/sequelize migration:generate --name "migration_name"```

### Migrate the database

Before run the server, you should migrate the db.
To do this, please run as following.
```yarn run compile```
```node_modules/.bin/sequelize db:migrate```

### For more information

For more information, please visit here
https://github.com/douglas-treadwell/sequelize-cli-typescript
