
resource "google_container_cluster" "gke_cluster" {
  name     = "gke-nikhil-1"
  location = var.region

  remove_default_node_pool = true
  initial_node_count       = 1

  network    = "default"
  subnetwork = "default"
}

resource "google_container_node_pool" "primary_nodes" {
  name       = "gke-node-pool"
  cluster    = google_container_cluster.gke_cluster.name
  location   = var.region

  node_count = 2   # Start with 2 nodes

  autoscaling {
    min_node_count = 2
    max_node_count = 5
  }

  node_config {
    machine_type = "e2-medium"
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }
}
