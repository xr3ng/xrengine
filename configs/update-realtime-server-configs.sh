
if [ -z "$1" ]
  then
    echo "No argument supplied, You must supply the stage name."
    exit 1
fi

set -x
STAGE=$1

# ex -> beta-xrengine-realtime-server

kubectl delete cm/$STAGE-xrengine-realtime-server
kubectl create configmap $STAGE-xrengine-realtime-server --from-env-file=.env.realtime-server
kubectl get cm/$STAGE-xrengine-realtime-server -o yaml > $STAGE-xrengine-realtime-server-configmap.yaml