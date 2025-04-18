terraform {
  cloud {
    organization = "Lee-personal-project"

    workspaces {
      name = "simple-web"
    }
  }
}