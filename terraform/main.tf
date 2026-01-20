resource "aws_apprunner_service" "php_poc" {
  service_name = "harness-php-app"

  source_configuration {
    authentication_configuration {
      # This is the ARN of the AppRunnerECRAccessRole
      access_role_arn = "arn:aws:iam::491085423717:role/AppRunnerECRAccessRole"
    }
    image_repository {
      image_identifier      = "491085423717.dkr.ecr.us-east-2.amazonaws.com/php-sample-app:${var.image_tag}"
      image_repository_type = "ECR"
      image_configuration {
        port = "8080"
      }
    }
  }
}

variable "image_tag" {
  type        = string
  description = "The Docker image tag to deploy"
}
