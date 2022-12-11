#!/bin/bash
# exit on error
set -e
set -u


PATH=$PATH:/gcloud/bin
gcloud auth activate-service-account --key-file=scripts/key.json
gcloud config set auth/impersonate_service_account "${GOOGLE_IMPERSONATE_SERVICE_ACCOUNT}"
gcloud config set project "${PROJECT_ID}"



echo "Deploying '$1' image ${IMAGE_NAME}, using SA ${GOOGLE_IMPERSONATE_SERVICE_ACCOUNT}"
gcloud run deploy "$1" \
        --image="${IMAGE_NAME}"  \
        --region=northamerica-northeast1 \
        --allow-unauthenticated \
        --service-account="cloud-run-sa@${PROJECT_ID}.iam.gserviceaccount.com"  \
        --set-env-vars=PROJECT_ID=$PROJECT_ID


