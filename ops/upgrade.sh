set -x

RELEASE=$1

helm repo add xrengine https://xrengine.github.io/xrengine-ops/
helm repo update

helm upgrade --install $RELEASE xrengine/xrengine --values values/$RELEASE.values.yaml
