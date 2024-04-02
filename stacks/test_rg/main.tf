module "test_rg" {
  source = "../../modules/resource-groups"
  rg_name = ["test_01","test_02"]
}