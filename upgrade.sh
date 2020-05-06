set -x

RELEASE=$1

helm repo add xrchat https://xrchat.github.io/xrchat-ops/
helm repo update

helm upgrade --install $RELEASE xrchat/xrchat --values values/$RELEASE.values.yaml
