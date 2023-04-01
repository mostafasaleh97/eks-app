module "eks-demo" {
    source = "./eks"
    all-subnet_ids = [module.newvpc.subnet-id0,module.newvpc.subnet-id1,module.newvpc.subnet-id2,module.newvpc.subnet-id3]
    subnet_ids = [module.newvpc.subnet-id2,module.newvpc.subnet-id3]
    security_group = module.eks-security.security-id
}   