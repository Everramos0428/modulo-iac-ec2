# Módulo Terraform: EC2 Instance


Este módulo crea una o varias instancias EC2 en AWS. A continuación se muestra cómo usarlo, todas las variables disponibles y ejemplos prácticos.


## Requisitos
- Terraform >= 1.2
- Provider AWS configurado con credenciales y región.


## Uso básico (ejemplo)


Archivo `examples/main.tf`

## Todas las variables disponibles


| Nombre | Tipo | Defecto | Descripción |
|---|---:|---|---|
| `ami` | string | — | **Requerido.** ID de la AMI.
| `instance_type` | string | `t3.micro` | Tipo de instancia.
| `key_name` | string | `null` | Key pair para SSH.
| `subnet_id` | string | `null` | Subnet donde lanzar la instancia.
| `vpc_security_group_ids` | list(string) | `[]` | Security groups.
| `associate_public_ip` | bool | `true` | Asociar IP pública (si la subnet lo permite).
| `iam_instance_profile` | string | `null` | Instance profile (ARN o nombre).
| `user_data` | string | `null` | Script de arranque (cloud-init).
| `count` | number | `1` | Número de instancias.
| `root_volume_size` | number | `8` | Tamaño del volumen raíz (GB).
| `root_volume_type` | string | `gp3` | Tipo de volumen raíz.
| `root_delete_on_termination` | bool | `true` | Borrar volumen al terminar.
| `ebs_block_devices` | list(map(any)) | `[]` | Volúmenes EBS adicionales.
| `monitoring` | bool | `false` | CloudWatch detailed monitoring.
| `disable_api_termination` | bool | `false` | Evita terminación vía API.
| `prevent_destroy` | bool | `false` | Lifecycle prevent_destroy.
| `source_dest_check` | bool | `true` | Source/dest check.
| `tags` | map(string) | `{}` | Tags personalizados.
| `default_tags` | map(string) | `{ ManagedBy = "terraform-ec2-module" }` | Tags por defecto.


> Nota: las variables sin valor por defecto (ej. `ami`) son obligatorias y deben proporcionarse cuando llames al módulo.


## Outputs


- `instance_id` - Lista de IDs de instancias.
- `public_ip` - Lista de IPs públicas.
- `private_ip` - Lista de IPs privadas.
- `arn` - Lista de ARNs.


## Buenas prácticas y recomendaciones


- Siempre especifica una AMI válida para la región donde aplicas el módulo.
- Evita usar `associate_public_ip = true` en entornos privados. Si necesitas acceso, considera NAT Gateway o bastion host.
- Para entornos productivos, habilita `monitoring = true` y configura CloudWatch.
- Usa `prevent_destroy = true` con cautela (evita destrucción accidental, pero puede complicar cambios infraestructurales).
- Maneja secretos (como claves) fuera del repo — usa AWS Secrets Manager, SSM Parameter Store o variables de entorno con Terraform Cloud/Backend seguro.