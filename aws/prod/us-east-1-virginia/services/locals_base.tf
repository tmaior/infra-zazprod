locals {
  project_env = terraform.workspace
  project_name = "walter"
  region     = "us-east-1"
  infrastructure_suffix = format("%s-%s", local.project_env, local.project_name)
  azs            = ["${local.region}a", "${local.region}b", "${local.region}c"]
  domain = "${terraform.workspace}.walterwrites.ai"
}

locals {
    SERVICES_NAMES = {
        BACKEND = "backend"
        FRONTEND = "frontend"
        APP = "app"
        HUMANIZER = "humanizer"
    }
}