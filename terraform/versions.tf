terraform {
  required_providers {
    selectel = {
      source  = "selectel/selectel"
      version = "5.2.1"
    }

    local = {
      source  = "hashicorp/local"
      version = "2.5.1"
    }
  }
  backend "s3" {
    bucket                      = "/webinar"
    endpoint                    = "s3.storage.selcloud.ru"
    key                         = "webinar.tfstate"
    region                      = "ru-1"
    skip_region_validation      = true
    skip_credentials_validation = true
    required_version            = ">= 1.0.0, <= 1.6.2"
  }
}