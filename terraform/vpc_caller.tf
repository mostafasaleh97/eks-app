module "newvpc" {
  source = "./vpc"
  vpc-cidr = "10.0.0.0/16"
  vpc-name = "newvpc"
  public-subnet-names = ["public1","public2"]
  private-subnet-names = ["private-1","privte-2"]
  public-subnet-cidr= ["10.0.1.0/24","10.0.2.0/24"]
  private-subnet-cidr= ["10.0.3.0/24","10.0.4.0/24"]
  route-cidr = "0.0.0.0/0"
  route-names = ["public_route","private_route"]
  elastic-names = ["myel",]
  nat-names = ["mynat",]
  public-availability_zone = ["us-east-1a","us-east-1b"]
  private-availability_zone = ["us-east-1c","us-east-1d"]
}