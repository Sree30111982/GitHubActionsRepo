terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.2"
    }
  }
}

provider "docker" {}

# Pull Nginx image
resource "docker_image" "nginx" {
  name = "nginx:latest"
}

# Create Nginx container
resource "docker_container" "nginx_server1" {
  name  = "nginx_server1"
  image = docker_image.nginx.image_id
  ports {
    internal = 80
    external = 8080
  }
  depends_on = [ docker_container.nginx_server2 ]
}

# Create Nginx container
resource "docker_container" "nginx_server2" {
  name  = "nginx_server2"
  image = docker_image.nginx.image_id
  ports {
    internal = 80
    external = 8081
  }
  
}