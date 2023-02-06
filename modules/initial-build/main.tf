resource "null_resource" "initial_building" {
    provisioner "local-exec" {
        command = "make build"
        working_dir = var.working_directory
    }
}