module "eks" {
  source = "../eks"
}



provider "helm" {
  kubernetes {
    host                   = module.eks.endpoint
    cluster_ca_certificate = base64decode(module.eks.ca[0].data)


  
  }
}

resource "helm_release" "nginx-ingress" {
  
  name       = "nginx-ingress"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  version    = "4.0.0"
  namespace = "default"
  
 depends_on = [module.eks]

}
