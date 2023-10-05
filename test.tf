terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.2"
    }
  }
}

provider "docker" {}

resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
}

resource "docker_image" "mysql" {
  name         = "mysql:latest"
  keep_locally = false
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.image_id
  name  = "nginx.test.loc"
  ports {
    internal = 80
    external = 8000
  }
}

resource "docker_container" "mysql" {
  image = docker_image.mysql.image_id
  name  = "mysql8.test.loc"
  
  ports {
    internal = 3306
    external = 33306
  }
}