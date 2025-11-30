terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = ">= 4.0"
        }
    }
}


resource "aws_instance" "this" {
    ami = var.ami
    instance_type = var.instance_type
    key_name = var.key_name
    subnet_id = var.subnet_id
    vpc_security_group_ids = var.vpc_security_group_ids
    associate_public_ip_address = var.associate_public_ip
    iam_instance_profile = var.iam_instance_profile
    user_data = var.user_data
    count = var.count


    root_block_device {
        volume_size = var.root_volume_size
        volume_type = var.root_volume_type
        delete_on_termination = var.root_delete_on_termination
    }


    dynamic "ebs_block_device" {
        for_each = var.ebs_block_devices
        content {
            device_name = ebs_block_device.value.device_name
            volume_size = ebs_block_device.value.volume_size
            volume_type = lookup(ebs_block_device.value, "volume_type", var.root_volume_type)
            delete_on_termination = lookup(ebs_block_device.value, "delete_on_termination", true)
            encrypted = lookup(ebs_block_device.value, "encrypted", false)
        }
    }


    monitoring = var.monitoring
    disable_api_termination = var.disable_api_termination
    source_dest_check = var.source_dest_check


    tags = merge(var.default_tags, var.tags)


    lifecycle {
        prevent_destroy = var.prevent_destroy
    }
}