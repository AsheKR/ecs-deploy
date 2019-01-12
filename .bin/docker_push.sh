#! /bin/bash
# Push only if it's not a pull request
if [ -z "$TRAVIS_PULL_REQUEST" ] || [ "$TRAVIS_PULL_REQUEST" == "false" ]; then
# Push only if we're testing the master branch
if [ "$TRAVIS_BRANCH" == "master" ]; then

# This is needed to login on AWS and push the image on ECR
# Change it accordingly to your docker repo
eval $(aws ecr get-login --no-include-email --region ap-northeast-2)

# Build and push
docker build -t $IMAGE_NAME:base -f Dockerfile.base .
docker build -t $IMAGE_NAME .
echo "Pushing $IMAGE_NAME:latest"
docker tag $IMAGE_NAME:latest "$REMOTE_IMAGE_URL:latest"
docker tag $IMAGE_NAME:base "$REMOTE_IMAGE_URL:base"
docker push "$REMOTE_IMAGE_URL:base"
docker push "$REMOTE_IMAGE_URL:latest"
echo "Pushed $IMAGE_NAME:latest"
else
echo "Skipping deploy because branch is not 'master'"
fi
else
echo "Skipping deploy because it's a pull request"
fi
