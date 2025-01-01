# Define the AWS Provider
provider "aws" {
  region = "eu-central-1"
}

# Create the S3 Bucket
resource "aws_s3_bucket" "restaurant_menu_webpage" {
  bucket = "restaurant-menu-webpage"
  acl    = "private"  # Set to private since access will be controlled via CloudFront
}

# Website Configuration for the S3 Bucket (recommended for static websites)
resource "aws_s3_bucket_website_configuration" "restaurant_menu_website_config" {
  bucket = aws_s3_bucket.restaurant_menu_webpage.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html"
  }
}

# Define the Origin Access Identity for CloudFront to access the S3 bucket securely
resource "aws_cloudfront_origin_access_identity" "restaurant_menu_identity" {
  comment = "OAI for restaurant-menu-webpage"
}

# S3 Bucket Policy to allow CloudFront to access the bucket via OAI
resource "aws_s3_bucket_policy" "restaurant_menu_policy" {
  bucket = aws_s3_bucket.restaurant_menu_webpage.id
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "AllowCloudFrontOAIReadOnly",
        "Effect": "Allow",
        "Principal": {
          "AWS": "${aws_cloudfront_origin_access_identity.restaurant_menu_identity.iam_arn}"
        },
        "Action": "s3:GetObject",
        "Resource": "${aws_s3_bucket.restaurant_menu_webpage.arn}/*"
      }
    ]
  })
}

# Upload the index.html file to the S3 bucket
resource "aws_s3_object" "index_html" {
  bucket       = aws_s3_bucket.restaurant_menu_webpage.bucket
  key          = "index.html"
  source       = "/Users/mohamedelzeini/Documents/AI Program - IU/Courses/4.Fourth Term/Cloud Programming/Terraform files/index.html"
  content_type = "text/html"  # Explicitly set MIME type
}

# Upload all files in the imgs folder to the S3 bucket
resource "aws_s3_object" "imgs" {
  for_each = fileset("/Users/mohamedelzeini/Documents/AI Program - IU/Courses/4.Fourth Term/Cloud Programming/Terraform files/imgs", "**")
  bucket   = aws_s3_bucket.restaurant_menu_webpage.bucket
  key      = "imgs/${each.value}"
  source   = "/Users/mohamedelzeini/Documents/AI Program - IU/Courses/4.Fourth Term/Cloud Programming/Terraform files/imgs/${each.value}"
}

# Configure CloudFront Distribution for Global Access
resource "aws_cloudfront_distribution" "restaurant_menu_distribution" {
  origin {
    domain_name = aws_s3_bucket.restaurant_menu_webpage.bucket_regional_domain_name
    origin_id   = "S3-restaurant-menu-webpage"

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.restaurant_menu_identity.cloudfront_access_identity_path
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"

  # Default Cache Behavior for CloudFront
  default_cache_behavior {
    target_origin_id       = "S3-restaurant-menu-webpage"
    viewer_protocol_policy = "redirect-to-https"

    allowed_methods = ["GET", "HEAD"]
    cached_methods  = ["GET", "HEAD"]

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    min_ttl     = 0
    default_ttl = 3600
    max_ttl     = 86400
  }

  # Viewer Certificate for HTTPS (using default CloudFront certificate)
  viewer_certificate {
    cloudfront_default_certificate = true
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  # Price Class (adjust for cost vs performance needs)
  price_class = "PriceClass_100"
}

# Output CloudFront Distribution URL for easy access
output "cloudfront_url" {
  value       = "https://dnbv8i18z5791.cloudfront.net"
  description = "The CloudFront distribution URL for the website"
}

# Output for CloudFront Origin Access Identity ID
output "cloudfront_oai_id" {
  value       = aws_cloudfront_origin_access_identity.restaurant_menu_identity.cloudfront_access_identity_path
  description = "The ARN of the CloudFront Origin Access Identity (OAI) for the S3 bucket."
}

# Output for CloudFront Distribution ID (for verification)
output "cloudfront_distribution_id" {
  value       = aws_cloudfront_distribution.restaurant_menu_distribution.id
  description = "The ID of the CloudFront distribution."
}
