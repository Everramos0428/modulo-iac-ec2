provider "aws" {
    region = "us-east-1"
}


module "mi_ec2_avanzada" {
    source = "../.."


    ami = "ami-0c94855ba95c71c99"
    instance_type = "m5.large"
    key_name = "mi-keypair"
    subnet_id = "subnet-0example"
    vpc_security_group_ids = ["sg-0example"]
    associate_public_ip = false
    iam_instance_profile = "mi-instance-profile"
    user_data = file("./cloud-init.sh")
    count = 2


    root_volume_size = 50
    root_volume_type = "gp3"


    ebs_block_devices = [
        { device_name = "/dev/sdf", volume_size = 100, volume_type = "gp3", encrypted = true }
    ]


    monitoring = true
    disable_api_termination = true
    prevent_destroy = false


    tags = {
        Name = "mi-ec2-avanzada"
        Env = "prod"
    }
}