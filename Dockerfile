# ARG MARKETPLACE_TOOLS_TAG
# FROM marketplace.gcr.io/google/c2d-debian11 AS build

# RUN apt-get update \
#     && apt-get install -y --no-install-recommends gettext

# ADD chart/chart /tmp/chart
# RUN cd /tmp && tar -czvf /tmp/polygon-id.tar.gz chart

# ADD schema.yaml /tmp/schema.yaml

# ARG REGISTRY
# ARG TAG

# RUN cat /tmp/schema.yaml \
#     | env -i "REGISTRY=$REGISTRY" "TAG=$TAG" envsubst \
#     > /tmp/schema.yaml.new \
#     && mv /tmp/schema.yaml.new /tmp/schema.yaml

FROM gcr.io/cloud-marketplace-tools/k8s/deployer_helm/onbuild:latest
# COPY --from=build /tmp/polygon-id.tar.gz /data/chart/
# COPY --from=build /tmp/schema.yaml /data/

COPY app-test/deployer/schema.yaml data-test/

ENV WAIT_FOR_READY_TIMEOUT 1800
# ENV TESTER_TIMEOUT 1800
