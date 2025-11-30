output "instance_id" {
    description = "ID de la instancia EC2 creada."
    value = aws_instance.this.*.id
}


output "public_ip" {
    description = "IP pública (si aplica)."
    value = aws_instance.this.*.public_ip
}


output "private_ip" {
    description = "IP privada asignada."
    value = aws_instance.this.*.private_ip
}


output "arn" {
    description = "ARN de la instancia (si aplica)."
    value = aws_instance.this.*.arn
}