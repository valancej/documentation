variable "routing_rules" {
  type = "string"
  default = <<EOF
	[{
			"Condition": {
				"KeyPrefixEquals": "classic/"
			},
			"Redirect": {
				"HostName": "documentation.codeship.com",
				"ReplaceKeyPrefixWith": "basic/",
				"HttpRedirectCode": "302"
			}
		}, {
			"Condition": {
				"KeyPrefixEquals": "docker/"
			},
			"Redirect": {
				"HostName": "documentation.codeship.com",
				"ReplaceKeyPrefixWith": "pro/",
				"HttpRedirectCode": "302"
			}
	}]
EOF
}

resource "aws_s3_bucket" "documentation" {
	bucket = "documentation.codeship.com"
	acl = "public-read"

	website {
    index_document = "index.html"
    error_document = "404/index.html"
		routing_rules = "${var.routing_rules}"
	}

	# expire staging deploys
	lifecycle_rule {
		id = "staging"
		prefix = "staging/"
		enabled = true
		abort_incomplete_multipart_upload_days = 7

    expiration {
      days = 14
    }
	}

	# expire private deploys
	lifecycle_rule {
		id = "private"
		prefix = "private/"
		enabled = true
		abort_incomplete_multipart_upload_days = 7

    expiration {
      days = 30
    }
	}

	tags {
    project = "documentation"
    environment = "production"
		owner = "customer-success"
  }
}

resource "aws_cloudfront_distribution" "documentation" {
	origin {
    domain_name = "${aws_s3_bucket.documentation.bucket_domain_name}"
    origin_id = "S3-documentation.codeship.com"

    s3_origin_config {
      origin_access_identity = "origin-access-identity/cloudfront/ABCDEFG1234567"
    }
  }

	enabled = true
	http_version = "http1.1"

	custom_error_response {
		error_caching_min_ttl = 300
		error_code = 403
		response_code = 404
		response_page_path = "/404/index.html"
	}

	aliases = [
		"documentation.codeship.com"
	]

	default_cache_behavior {
		allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "S3-documentation.codeship.com"
		compress = true

		forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

	restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

	viewer_certificate {
    iam_certificate_id = "ASCAIBD3LBV4ZPD45LLJG"
		minimum_protocol_version = "TLSv1"
		ssl_support_method = "sni-only"
  }

	tags {
    project = "documentation"
    environment = "production"
		owner = "customer-success"
  }
}
