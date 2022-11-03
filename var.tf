variable AWS_REGION{
    default ="us-east-2"

}

variable AMIS
{
    type = map
    default = {
        us-east-2 = ami-0e6329e222e662a52
us-east-2 = ami-01f703c132f2b1a20
ap-south-1 = ami-0e0a5837db23ddf55
    }
}

variable PRIV_KEY_PATH
{ 
default = "vprofilekey"
}

variable PUB-KEY-PATH
{
default = "vprofilekey.pub"
}

variable USERNAME
{
default ="linux"
}

variable MYIP{
default = "192.168.56.1/32"
}

variable rmquser {
default ="rabbit"
}

variable rmqpass {
default = "Kallu@1234567"
}

variable dbuser
{
default = "admin"
}
variable dbpass
{
default = "admin123"
}

variable dbname {
default = "accounts"
}

variable instance_count 
{
default = "1"
}

variable VPC_NAME {
default = "vprofile-VPC"
}

variable Zone1 {
default = "us-east-2a"
}

variable Zone2 {
default = "us-east-2b"
}

variable Zone3 {
default = "us-east-2c"
}

variable VpcCIDR {
default = "192.168.0.0/16"
}

variable PubSub1CIDR {
default = "192.168.1.0/24"
}


variable PubSub2CIDR {
default = "192.168.2.0/24"
}


variable PubSub3CIDR {
default = "192.168.3.0/24"
}


variable PrivSub1CIDR {
default = "192.168.4.0/24"
}


variable PrivSub2CIDR {
default = "192.168.5.0/24"
}

variable PrivSub3CIDR {
default = "192.168.6.0/24"
}