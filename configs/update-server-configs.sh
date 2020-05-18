
if [ -z "$1" ]
  then
    echo "No argument supplied, You must supply the stage name."
    exit 1
fi

set -x

# ex -> beta-xrengine-realtime-server

STAGE=$1

kubectl delete cm/$STAGE-xrengine
kubectl create configmap $STAGE-xrengine --from-env-file=.env.server
kubectl get cm/$STAGE-xrengine -o yaml > $STAGE-xrengine-configmap.yaml