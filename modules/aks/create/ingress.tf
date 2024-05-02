resource "helm_release" "nginx_ingress" {
  name             = "nginx-ingress"
  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
  version          = "4.0.6" # You can specify the version you want
  namespace        = "nginx-ingress"
  create_namespace = "true"
}