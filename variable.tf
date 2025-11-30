variable "ami" {
}


variable "ebs_block_devices" {
    description = "Lista de mapas con ebs block devices adicionales. Cada item: { device_name=\"/dev/sdf\", volume_size=20, volume_type=\"gp3\", encrypted=false }"
    type = list(map(any))
    default = []
}


variable "monitoring" {
    description = "Habilita CloudWatch detailed monitoring."
    type = bool
    default = false
}


variable "disable_api_termination" {
    description = "Si true, evita que la API pueda terminar la instancia."
    type = bool
    default = false
}


variable "prevent_destroy" {
    description = "Usado en lifecycle.prevent_destroy. Si true, evita destruir la instancia con terraform destroy o apply."
    type = bool
    default = false
}


variable "source_dest_check" {
    description = "Valor para source_dest_check (útil para instancias NAT o appliances)."
    type = bool
    default = true
}


variable "tags" {
    description = "Mapa de tags a aplicar a la instancia (merge con default_tags)."
    type = map(string)
    default = {}
}


variable "default_tags" {
    description = "Tags por defecto que siempre se aplican y pueden ser sobrescritas por `tags`."
    type = map(string)
    default = {
        "ManagedBy" = "terraform-ec2-module"
    }
}