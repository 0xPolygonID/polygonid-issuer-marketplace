## Instructions for creating deployer image for new release of the application

The GCP project for this marketplace setup is in `polygon-public` which is under `polygon.technology` organisation.

## Tagging the new container images
When you make certain changes to your application container images or other supporting images, tag your container images in the following way. 

Example: For issuernode it will be 
```shell
docker tag your_container_image gcr.io/polygon-public/polygon-id/issuernode:RELEASE_TAG
```
RELEASE_TAG: New tag using semantic versioning in the *MAJOR.MINOR.PATCH* manner; if your current version is `1.0.1` and you had some kind of patch to your application then you should tag it like `1.0.2` if it is a minor release then it should be `1.1.0` and for major release it will be `2.0.0`.

Tag all the other images in the same way; for example issuernode-ui should be taggd like `gcr.io/polygon-public/polygon-id/issuernode-ui:RELEASE_TAG`

## Pushing updated images to the Container Registry

Once you have new version of the images, push the images. 

Example: For issuernode it will be  
 
```shell 
docker push gcr.io/polygon-public/polygon-id/issuernode:RELEASE_TAG
```
Push all the updated images in the same way.


## Making changes to the helm charts

If you want any changes to be made to the helm chart, make to the chart with under `chart/polygon-id-issuer`.

As long as you don't want to add/change any inputs to be given by end user you can modify the helm chart. If you want to add any values to be passed by end user then you need to add make certain changes to the marketplace specific configuration called `schema.yaml`

Every value we add in `schema.yaml` will be mapped to the helm `values.yaml` file. All the properties in the `schema.yaml` file will be enrty fields to the end user when they are deploying the application through marketplace UI. 

For example we have below snippet in the schema.yaml file

```shell
appdomain:
    type: string
    title: The App Domain Name
    description: The Domain Name for the App
```
This will be mapped to `appdomain:` in the values.yaml file

```shell
appdomain: app.example.com
```
Once we have value populated in the helm `values.yaml` we can use them wherever we want in the helm chart.


## Building deployer image

We have a deployer container image which will be responsible for deploying our setup to the end users GKE clusters.

Follow the below steps for building and pushing the deployer image.

```
# Set the registry to your project GCR repo.
export REGISTRY=gcr.io/$(gcloud config get-value project | tr ':' '/')
export APP_NAME=polygon-id
docker build --tag $REGISTRY/$APP_NAME/deployer:RELEASE_TAG .
```
Push the deployer image to the GCR repo

```shell
docker push $REGISTRY/$APP_NAME/deployer:RELEASE_TAG
```
Once you pushed the deployer image you need to run smoke test. Use the below command to do that.

```shell
mpdev verify --deployer=$REGISTRY/$APP_NAME/deployer:RELEASE_TAG
```
This test will create a random namespace in the GKE cluster, deployes the application and destroyes it once all the components are up and running.



## Submitting new deployer image in the producer portal

Once the smoke tests are passed, we need to submit the new deployer image in the [producer portal](https://console.cloud.google.com/producer-portal/listing-edit/polygon-id-issuer-node.endpoints.polygon-public.cloud.goog;stepId=kubernetesImages?project=polygon-public) for Google review.