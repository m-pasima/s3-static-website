# Kikivy Platform - Setup Guide 🚀

Welcome to the **Kikivy Platform** static website setup guide! This README provides step-by-step instructions to deploy your fashion e-commerce site on **AWS S3** as a static website. The site features a custom logo, curated product collections (Shoes, Clothes, Kids, Sales), a flashing sales banner, exclusive coupons, and a responsive design with a teal hero overlay. Follow these instructions to get your site live with a professional look and feel! 🛍️

---

## 📋 Prerequisites

Before you begin, ensure you have:

* An **AWS account** with access to the S3 console.
* The following files ready:
  * `index.html`: Main homepage with product sections, sales banner, and coupons.
  * `styles.css`: CSS styles for responsive design and animations.
  * `404.html`: Custom error page for handling invalid URLs.
  * `logo.webp`: Your custom logo, saved in the `/images/` folder.
* Basic familiarity with the AWS Management Console.
* A text editor (e.g., VS Code) to verify file paths if needed.

---

## 🛠️ Setup Instructions

### 1. Create an S3 Bucket 🪣

1. **Log in to AWS** :

* Navigate to the [AWS S3 Console](https://console.aws.amazon.com/s3/).

1. **Create a Bucket** :

* Click  **Create bucket** .
* Enter a unique **Bucket name** (e.g., `kikivy-platform`).
* Choose your preferred **AWS Region** (e.g., `eu-west-2` for London).
* Disable **Block all public access** to allow public read access (you’ll secure it with a policy later).
* Keep default settings for other options and click  **Create bucket** .

### 2. Upload Files 📤

1. **Access Your Bucket** :

* In the S3 console, select your bucket (e.g., `kikivy-platform`).

1. **Upload Website Files** :

* Click **Upload** and add:
  * `index.html` (root)
  * `styles.css` (root)
  * `404.html` (root)
  * `logo.webp` (inside `/images/` folder; create the folder if needed)
* Create the `/images/` folder:
  * Click  **Create folder** , name it `images`, and upload `logo.webp` inside.
* Verify file paths:
  * `index.html` → `/index.html`
  * `styles.css` → `/styles.css`
  * `404.html` → `/404.html`
  * `logo.webp` → `/images/logo.webp`

1. **Set File Permissions** :

* Select each file, go to  **Permissions** , and grant **Read** access to “Everyone (public access)” or set via the bucket policy (see Step 3).

1. **Set MIME Types** :

* For `logo.webp`, set:
  ```
  Content-Type: image/webp
  Cache-Control: max-age=31536000
  ```
* For `index.html` and `404.html`:
  ```
  Content-Type: text/html
  Cache-Control: max-age=3600
  ```
* For `styles.css`:
  ```
  Content-Type: text/css
  Cache-Control: max-age=3600
  ```

### 3. Configure Bucket Policy 🔒

1. **Set Public Read Access** :

* In your bucket, go to **Permissions** >  **Bucket Policy** .
* Paste the following policy, replacing `your-bucket-name` with your bucket name:
  ```json
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "PublicReadGetObject",
        "Effect": "Allow",
        "Principal": "*",
        "Action": "s3:GetObject",
        "Resource": "arn:aws:s3:::your-bucket-name/*"
      }
    ]
  }
  ```
* Click  **Save changes** .

1. **Verify Permissions** :

* Ensure `logo.webp`, `index.html`, `styles.css`, and `404.html` are publicly accessible by testing their URLs (e.g., `http://your-bucket-name.s3.amazonaws.com/images/logo.webp`).

### 4. Enable Static Website Hosting 🌐

1. **Enable Hosting** :

* In your bucket, go to **Properties** >  **Static website hosting** .
* Select  **Enable** .
* Set **Index document** to `index.html`.
* Set **Error document** to `404.html`.
* Click  **Save changes** .

1. **Note the Endpoint** :

* Copy the static website endpoint (e.g., `http://your-bucket-name.s3-website-your-region.amazonaws.com`).

### 5. Test Your Website 🧪

1. **Access the Site** :

* Open the S3 endpoint in a browser (e.g., `http://your-bucket-name.s3-website-your-region.amazonaws.com`).
* Use incognito mode or clear your browser cache to ensure fresh content loads.
* **Sales Banner** : Confirm the “Sale!” banner flashes with a pulsing animation.
* **Coupons** : Test the “Copy Code” buttons (`KIKIVY10`, `FREESHIP50`, `SALE20`) to ensure they copy codes to the clipboard.
* **Responsive Design** : Test on mobile devices to verify the mobile menu and layout.

1. **Check Browser Console** :

* Open the browser console (F12 > Console) to check for errors (e.g., 403 Forbidden, 404 Not Found).
* If images or the logo don’t load, verify S3 permissions and file paths.

### 6. Optional: Host Product Images in S3 📸

To avoid potential hotlinking issues with external image URLs (Pexels/Unsplash):

1. **Download Images** :

* Download product images from the URLs in `index.html` (e.g., Running Sneakers, Kids Sneakers).
* Convert to WebP format using a tool like [Squoosh](https://squoosh.app/).

1. **Upload to S3** :

* Upload to the `/images/` folder (e.g., `/images/running-sneakers.webp`).
* Set permissions and metadata:
  ```
  Content-Type: image/webp
  Cache-Control: max-age=31536000
  ```

1. **Update `index.html`** :

* Replace external URLs with S3 paths, e.g.:
  ```html
  <img src="/images/running-sneakers.webp" alt="Running Sneakers" loading="lazy">
  ```

1. **Re-upload `index.html`** and test again.

---

## 🛠️ Troubleshooting

* **Logo Not Displaying** :
* Verify `logo.webp` is uploaded to `/images/logo.webp` in your S3 bucket.
* Check public read access in S3 permissions or bucket policy.
* Test the URL: `http://your-bucket-name.s3.amazonaws.com/images/logo.webp`.
* Ensure `Content-Type: image/webp` is set.
* **Product Images Not Loading** :
* Check the browser console for errors (e.g., 403, 404, CORS).
* Consider hosting images in S3 (see Step 6).
* **Styles Not Applied** :
* Ensure `styles.css` is uploaded to `/styles.css` with `Content-Type: text/css`.
* Verify the bucket policy allows public access.
* **404 Errors** :
* Confirm `404.html` is set as the error document in static website hosting.
* Check navigation links (e.g., `#shoes`, `#clothes`) work correctly.
* **Need Help?** :
* Share browser console errors or contact `passypet@gmail.com` for support.

---

## 🎨 Site Features

* **Custom Logo** : Displays your branded logo at `/images/logo.webp` in the footer.
* **Product Sections** : Showcases Shoes, Clothes, Kids, and Sale items with responsive grids.
* **Flashing Sales Banner** : A pulsing “Sale!” banner draws attention to discounts.
* **Coupons Section** : Offers clickable coupon codes (`KIKIVY10`, `FREESHIP50`, `SALE20`).
* **Responsive Design** : Mobile-friendly with a hamburger menu for navigation.
* **SEO Optimized** : Includes meta tags for better search engine visibility.
* **Accessibility** : ARIA labels and lazy loading for improved user experience.
* **Contact Info** : Reachable at `passypet@gmail.com` and `+44 7533 020152`.

---

## 🚀 Going Live

Once deployed, your site will be accessible at the S3 endpoint (e.g., `http://your-bucket-name.s3-website-your-region.amazonaws.com`). For a custom domain, configure **Amazon Route 53** or another DNS provider to point to your S3 bucket. Enjoy showcasing your fashion collections with Kikivy Platform! ✨

---

*© 2025 DevOps Academy. Built with 💖 for style enthusiasts.*
