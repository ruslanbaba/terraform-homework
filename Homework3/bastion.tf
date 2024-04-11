resource "aws_key_pair" "HW3"{
    key_name = "Bastion-Key"
    public_key = file("~/.ssh/id_rsa.pub")
}