provider "aws" {
  region = "ap-northeast-2"
}

# EKS Cluster
# resource "aws_eks_cluster" "example" {
#   name     = "my-cluster"
#   role_arn = aws_iam_role.example.arn

#   vpc_config {
#     subnet_ids = [aws_subnet.private.*.id]
#   }

# }

resource "aws_eks_cluster" "cluster" {
  name     = "my_cluster"
  role_arn = aws_iam_role.eks_cluster.arn

  vpc_config {
    subnet_ids = ["subnet-07f9186700dea3285", "subnet-0a06abb2260874414"]
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster,
    aws_iam_role.eks_cluster,
  ]
}

resource "aws_eks_fargate_profile" "example" {
  cluster_name = aws_eks_cluster.cluster.name
  fargate_profile_name  = "my_profile"
  pod_execution_role_arn = aws_iam_role.eks_cluster.arn
  subnet_ids             = ["subnet-07f9186700dea3285", "subnet-0a06abb2260874414"]

  selector {
    namespace = "app"
  }
}

#######

resource "aws_iam_role" "eks_cluster" {
  name = "eks_cluster_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks_cluster" {
  role       = aws_iam_role.eks_cluster.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

#######

#######

data "aws_iam_role" "ccoe" {
  name = "CCOE"
}

resource "kubernetes_config_map" "aws_auth" {
  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }

  data = {
    mapRoles = <<YAML
- rolearn: ${data.aws_iam_role.ccoe.arn}
  username: ccoe
  groups:
    - system:masters
YAML
  }

  depends_on = [
    aws_eks_cluster.cluster,
  ]
}

# Namespace
resource "kubernetes_namespace" "app" {
  metadata {
    name = "app"
  }
}



#######


# # Ingress
# resource "kubernetes_ingress" "example_ingress" {
#   wait_for_load_balancer = true
  
#   metadata {
#     name = "example-ingress"
#     namespace = kubernetes_namespace.app.metadata[0].name
#     annotations = {
#       "alb.ingress.kubernetes.io/scheme" = "internet-facing"  
#       "kubernetes.io/ingress.class" = "alb"
#     }
#   }

#   spec {
#     rule {
#       http {
#         path {
#           path = "/frontend"
#           backend {
#             service_name = kubernetes_service.frontend.metadata[0].name
#             service_port = 80
#           }
#         }
        
#         path {
#           path = "/backend"
#           backend {
#             service_name = kubernetes_service.backend.metadata[0].name
#             service_port = 3000  
#           }
#         }        
#       }
#     }
#   }
# }








# #####
# resource "kubernetes_ingress" "example" {
#   metadata {
#     name = "example"
#     namespace = "app"
#     annotations = {
#       "kubernetes.io/ingress.class" = "alb"
#       "alb.ingress.kubernetes.io/scheme" = "internet-facing"
#     }
#   }

#   spec {
#     rule {
#       host = "example.com"

#       http {
#         path {
#           path = "/"
#           backend {
#             service_name = kubernetes_service.frontend.metadata[0].name
#             service_port = "80"
#           }
#         }
#       }
#     }
#   }

#   depends_on = [
#     kubernetes_deployment.frontend,
#     kubernetes_deployment.backend,
#   ]
# }




# # ALB Ingress Controller 
# resource "helm_release" "ingress_controller" {
#   name       = "aws-alb-ingress-controller"

#   repository = "https://aws.github.io/eks-charts"
#   chart      = "aws-load-balancer-controller"
#   namespace  = "kube-system"

#   set {
#     name  = "clusterName"
#     value = aws_eks_cluster.example.name
#   }
# }


# # Frontend Deployment
# resource "kubernetes_deployment" "frontend" {
#   metadata {
#     name = "frontend"
#     namespace = kubernetes_namespace.app1.metadata[0].name
#     labels = {
#       app = "frontend"
#     }
#   }

#   spec {
#     selector {
#       match_labels = {
#         app = "frontend"
#       }
#     }

#     template {
#       metadata {
#         labels = {
#           app = "frontend"
#         }
#       }

#       spec {
#         container {
#           image = "nginx:latest"
#           name  = "nginx"

#           port {
#             container_port = 80
#           }
#         }
#       }
#     }
#   }
# }

# # Backend Deployment  
# resource "kubernetes_deployment" "backend" {
#   metadata {
#     name = "backend"
#     namespace = kubernetes_namespace.app1.metadata[0].name
#     labels = {
#       app = "backend"
#     }
#   }

#   spec {
#     selector {
#       match_labels = {
#         app = "backend"    
#       }
#     }

#     template {
#       metadata {
#         labels = {
#           app = "backend"
#         }
#       }

#       spec {
#         container {
#           image = "node:16"
#           name  = "node"

#           port {
#             container_port = 3000
#           }
#         }
#       }  
#     }
#   }
# }

# # Ingress
# resource "kubernetes_ingress" "example_ingress" {
#   wait_for_load_balancer = true
  
#   metadata {
#     name = "example-ingress"
#     namespace = kubernetes_namespace.app1.metadata[0].name
#     annotations = {
#       "alb.ingress.kubernetes.io/scheme" = "internet-facing"  
#       "kubernetes.io/ingress.class" = "alb"
#     }
#   }

#   spec {
#     rule {
#       http {
#         path {
#           path = "/frontend"
#           backend {
#             service_name = kubernetes_service.frontend.metadata[0].name
#             service_port = 80
#           }
#         }
        
#         path {
#           path = "/backend"
#           backend {
#             service_name = kubernetes_service.backend.metadata[0].name
#             service_port = 3000  
#           }
#         }        
#       }
#     }
#   }
# }


# #####
# resource "kubernetes_ingress" "example" {
#   metadata {
#     name = "example"
#     namespace = "app"
#     annotations = {
#       "kubernetes.io/ingress.class" = "alb"
#       "alb.ingress.kubernetes.io/scheme" = "internet-facing"
#     }
#   }

#   spec {
#     rule {
#       host = "example.com"

#       http {
#         path {
#           path = "/"
#           backend {
#             service_name = kubernetes_service.frontend.metadata[0].name
#             service_port = "80"
#           }
#         }
#       }
#     }
#   }

#   depends_on = [
#     kubernetes_deployment.frontend,
#     kubernetes_deployment.backend,
#   ]
# }