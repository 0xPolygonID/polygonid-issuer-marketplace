# Installation for the Campaign

## Setup Issuer Node values

Note: STATIC_IP must be the name of the static IP you created in gcp.

```shell
export APP_INSTANCE_NAME=polygon-id-issuer-cp1
export NAMESPACE=cp1
export APP_DOMAIN=issuer-node-api-admin-cp1.polygonid.me
export API_DOMAIN=issuer-node-api-cp1.polygonid.me
export UI_DOMAIN=issuer-node-cp1.polygonid.me
export STATIC_IP=issuernode-k8s-cp1
export MAINNET=true
export ISSUER_ETHERUM_URL="https://polygon-mainnet.g.alchemy.com/v2/X2HI8cErI_6RYdUVS0SvSfCZCYDCSrzt"
export UI_PASSWORD="polygonid"
export ISSUER_NAME="My Issuer"
export PRIVATE_KEY="XXX"
export VAULT_PWD=password
```

## Install Helm Chart

```shell
helm install "$APP_INSTANCE_NAME" chart/polygon-id-issuer \
  --create-namespace --namespace "$NAMESPACE" \
  --set appdomain="$APP_DOMAIN" \
  --set uidomain="$UI_DOMAIN" \
  --set apidomain="$API_DOMAIN" \
  --set privatekey="$PRIVATE_KEY" \
  --set staticip="$STATIC_IP" \
  --set issuerName="$ISSUER_NAME" \
  --set uiPassword="$UI_PASSWORD" \
  --set mainnet="$MAINNET" \
  --set ethereumUrl="$ISSUER_ETHERUM_URL" \
  --set vaultpwd="$VAULT_PWD"

```

## Upgrade Helm Chart

```bash
helm upgrade "$APP_INSTANCE_NAME" chart/polygon-id-issuer
```
