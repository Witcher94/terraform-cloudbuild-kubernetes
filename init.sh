set -e

PROJECT_ID=$(gcloud config get-value project)
NOTRANDOM=${RANDOM}
CB_SA_ID=$(gcloud projects describe ${PROJECT_ID} --format="value(projectNumber)")@cloudbuild.gserviceaccount.com

echo "Bucket name(default if not stated):"
read BUCKET
if [ -z ${BUCKET} ]
  then
    BUCKET="cb-tf-bucket"
fi
TERRAFORM_BUCKET="${BUCKET}-${NOTRANDOM}"

cat << EOF > bucket.conf
bucket = "$TERRAFORM_BUCKET"
EOF

echo "Enabling required API's"
gcloud services enable \
  cloudresourcemanager.googleapis.com \
  --project ${PROJECT_ID}

gcloud services enable \
  iam.googleapis.com \
  --project ${PROJECT_ID}

gcloud services enable \
  admin.googleapis.com \
  --project ${PROJECT_ID}

gcloud services enable \
  compute.googleapis.com \
  --project ${PROJECT_ID}

gcloud services enable \
  cloudkms.googleapis.com \
  --project ${PROJECT_ID}

gcloud services enable \
  cloudbuild.googleapis.com \
  --project ${PROJECT_ID}

gcloud services enable \
  sqladmin.googleapis.com \
  --project ${PROJECT_ID}

gcloud services enable \
  servicenetworking.googleapis.com \
    --project=${PROJECT_ID}

gcloud services enable \
  container.googleapis.com \
    --project=${PROJECT_ID}

gcloud services enable \
  secretmanager.googleapis.com \
    --project=${PROJECT_ID}

echo "Adding role roles/storage.admin..."
gcloud projects add-iam-policy-binding ${PROJECT_ID} \
    --member=serviceAccount:${CB_SA_ID} \
    --role="roles/storage.admin"


echo "Adding role roles/compute.networkAdmin..."
gcloud projects add-iam-policy-binding \
  "${PROJECT_ID}" \
  --member="serviceAccount:${CB_SA_ID}" \
  --role="roles/compute.networkAdmin" \
  --user-output-enabled false

echo "Adding role roles/resourcemanager.projectIamAdmin..."
gcloud projects add-iam-policy-binding \
  "${PROJECT_ID}" \
  --member="serviceAccount:${CB_SA_ID}" \
  --role="roles/resourcemanager.projectIamAdmin" \
  --user-output-enabled false

echo "Adding role roles/compute.storageAdmin..."
gcloud projects add-iam-policy-binding \
  "${PROJECT_ID}" \
  --member="serviceAccount:${CB_SA_ID}" \
  --role="roles/compute.storageAdmin" \
  --user-output-enabled false

echo "Adding role roles/iam.securityAdmin..."
gcloud projects add-iam-policy-binding \
  "${PROJECT_ID}" \
  --member="serviceAccount:${CB_SA_ID}" \
  --role="roles/iam.securityAdmin" \
  --user-output-enabled false

echo "Adding role roles/compute.admin..."
gcloud projects add-iam-policy-binding \
  "${PROJECT_ID}" \
  --member="serviceAccount:${CB_SA_ID}" \
  --role="roles/compute.admin" \
  --user-output-enabled false

echo "Adding role roles/container.serviceAgent..."
gcloud projects add-iam-policy-binding \
  "${PROJECT_ID}" \
  --member="serviceAccount:${CB_SA_ID}" \
  --role="roles/container.serviceAgent" \
  --user-output-enabled false

echo "Adding role roles/secretmanager.admin..."
gcloud projects add-iam-policy-binding \
  "${PROJECT_ID}" \
  --member="serviceAccount:${CB_SA_ID}" \
  --role="roles/secretmanager.admin" \
  --user-output-enabled false

echo "Adding role roles/cloudsql.admin..."
gcloud projects add-iam-policy-binding \
  "${PROJECT_ID}" \
  --member="serviceAccount:${CB_SA_ID}" \
  --role="roles/cloudsql.admin" \
  --user-output-enabled false

gsutil mb -p ${PROJECT_ID} -c regional -l "europe-central2" gs://${TERRAFORM_BUCKET}
gsutil versioning set on gs://${TERRAFORM_BUCKET}

echo "Terraform image build start"
(cd cloudbuild-tf-container && gcloud builds submit . --config=cloudbuild.yaml)
echo "Terraform image build ends"
echo "Redis image build starts"
(cd redis-container && gcloud builds submit . --config=cloudbuild.yaml)
echo "Redis image build ends"
echo "Running init terraform"
(gcloud builds submit . --config=cloudbuild.yaml)
echo "Terraform has finished it's work"

