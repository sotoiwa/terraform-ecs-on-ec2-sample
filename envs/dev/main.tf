module "vpc" {
  source   = "../../modules/vpc"
  app_name = var.app_name
}

module "ecs_cluster" {
  source              = "../../modules/ecs_cluster"
  app_name            = var.app_name
  vpc_id              = module.vpc.vpc_id
  public_subnet_a_id  = module.vpc.public_subnet_a_id
  public_subnet_c_id  = module.vpc.public_subnet_c_id
  private_subnet_a_id = module.vpc.private_subnet_a_id
  private_subnet_c_id = module.vpc.private_subnet_c_id
}

module "ecs_service" {
  source                 = "../../modules/ecs_service"
  app_name               = var.app_name
  vpc_id                 = module.vpc.vpc_id
  public_subnet_a_id     = module.vpc.public_subnet_a_id
  public_subnet_c_id     = module.vpc.public_subnet_c_id
  private_subnet_a_id    = module.vpc.private_subnet_a_id
  private_subnet_c_id    = module.vpc.private_subnet_c_id
  cluster_id             = module.ecs_cluster.cluster_id
  capacity_provider_name = module.ecs_cluster.capacity_provider_name
  image                  = "nginx"
}
