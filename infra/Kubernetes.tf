resource "kubernetes_deployment_v1" "djangooooowapi" {
  metadata {
    name = "djangooooowapi"
    labels = {
      nome = "django"
    }
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        nome = "django"
      }
    }

    template {
      metadata {
        labels = {
          nome = "django"
        }
      }

      spec {
        container {
          image = "259473293646.dkr.ecr.us-east-1.amazonaws.com/producao:V1"
          name  = "django"

          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }

          liveness_probe {
            http_get {
              path = "/clientes/"
              port = 8000
            }

            initial_delay_seconds = 3
            period_seconds        = 3
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "loadBalancer" {
  metadata {
    name = "loadBalancer-djangoapi"
  }
  spec {
    selector = {
      nome = "django"
    }
    session_affinity = "ClientIP"
    port {
      port        = 8000
      target_port = 8000
    }

    type = "LoadBalancer"
  }
}