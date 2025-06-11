# Kikivy Static Website

This repository contains a sample shopping platform for shoes and clothes called **Kikivy**. The site is designed for static hosting on Amazon S3.

## Structure

- `website/` – HTML and CSS files for the site
- `scripts/deploy_to_s3.sh` – helper script to create an S3 bucket, enable static hosting, and upload the site

## Deployment

1. Choose a unique bucket name and AWS region.
2. Ensure you have the AWS CLI installed and configured with appropriate credentials.
3. Run the deployment script:

```bash
./scripts/deploy_to_s3.sh <bucket-name> <region>
```

After the script completes, your site will be available at:

```
http://<bucket-name>.s3-website-<region>.amazonaws.com
```

The bucket will be configured with public read access and `index.html` as the index document.
