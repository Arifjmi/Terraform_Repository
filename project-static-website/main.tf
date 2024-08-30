terraform {
	required_providers {
	  aws = {
		source  = "hashicorp/aws"
		version = "~> 5.0"
	  }
	  random = {
		source = "hashicorp/random"
		version = "3.6.2"
	}
  }
}
  # Configure the AWS Provider
  provider "aws" {
	region = "us-east-1"
  }

//Generate random id //

  resource "random_id" "rand_id" {
	byte_length = 8
  }
// Creating s3 bucket
  resource "aws_s3_bucket" "mywebapp-bucket" {
	bucket = "mywebapp-bucket-${random_id.rand_id.hex}"
  
	
  }

//aws_s3_bucket_public_access_block

  resource "aws_s3_bucket_public_access_block" "example" {
	bucket = aws_s3_bucket.mywebapp-bucket.id
  
	block_public_acls   = false
	block_public_policy = false
  }
//aws_s3_bucket_policy

  resource "aws_s3_bucket_policy" "mywebapp" {
	bucket = aws_s3_bucket.mywebapp-bucket.id
	policy =jsonencode(
		{
			Id = "Policy1724824789124",
			Version = "2012-10-17",
			Statement = [
			  {
				Sid = "Stmt1724824786247",
				Action = "s3:GetObject",
				Effect = "Allow",
				Resource = "arn:aws:s3:::mywebapp-bucket-0570d7155e78bfee/*",
				Principal = "*"
			  }
			]
		  }
	)
  }

// aws_s3_bucket_website_configuration

  resource "aws_s3_bucket_website_configuration" "mywebapp" {
	bucket = aws_s3_bucket.mywebapp-bucket.id
  
	index_document {
	  suffix = "index.html"
	}
  
  }

// Upload file on s3 bucket(index.html)

  
resource "aws_s3_object" "index_html" {
	bucket = aws_s3_bucket.mywebapp-bucket.bucket
	key    = "index.html"
	source = "./index.html"
	content_type = "text/html"
  }
// Upload file on s3 bucket(styles.css)
  resource "aws_s3_object" "styles_css" {
	bucket = aws_s3_bucket.mywebapp-bucket.bucket
	key    = "styles.css"
	source = "./styles.css"
	content_type = "text/css"
  }

  output "id" {
	value = random_id.rand_id.hex
  }

  output "website-endpoint" {
	value = aws_s3_bucket_website_configuration.mywebapp.website_endpoint
  }
  
