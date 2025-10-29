terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.2"
    }
  }
}

provider "docker" {}

# Pull image once
resource "docker_image" "nginx" {
  name = "nginx:latest"
}

# Create multiple containers with a loop
resource "docker_container" "nginx_server" {
  count = 3  # like a loop for 0..2

  name  = "nginx_server_${count.index + 1}"
  image = docker_image.nginx.image_id

  ports {
    internal = 80
    external = 8080 + count.index  # each container gets its own port
  }
}
