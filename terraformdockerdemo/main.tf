 #terraform {
  #required_providers {
   #null = {
    # source  = "hashicorp/null"
     #version = "~> 3.2"
    #}
  #}
#}

#resource "null_resource" "example" {
  #provisioner "local-exec" {
    #command = "echo '✅ Terraform executed successfully via GitHub Actions!  GREAT JOB'"
  #}
#}

terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.2"
    }
  }
}

provider "docker" {}

# Pull the Docker image (example: Nginx)
resource "docker_image" "nginx" {
  name = "nginx:latest"
}

# Create and run the container
resource "docker_container" "nginx_container" {
  name  = "nginx_server"
  image = docker_image.nginx.image_id
  ports {
    internal = 80
    external = 8080
  }
}
