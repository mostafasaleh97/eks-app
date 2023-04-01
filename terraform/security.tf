module "eks-security" {
  source = "./sec"
  vpc-id = module.newvpc.vpc-id
  
} 