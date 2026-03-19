resource "google_compute_network" "vpc" {

  name                    = "jd-vpc"
  auto_create_subnetworks = false

}

resource "google_compute_subnetwork" "web_subnet" {

  name          = "web-subnet"
  ip_cidr_range = "10.1.0.0/24"
  network       = google_compute_network.vpc.id
  region        = "us-east1"

}

resource "google_compute_subnetwork" "app_subnet" {

  name          = "app-subnet"
  ip_cidr_range = "10.2.0.0/24"
  network       = google_compute_network.vpc.id
  region        = "us-east1"

}

resource "google_compute_subnetwork" "db_subnet" {

  name          = "db-subnet"
  ip_cidr_range = "10.3.0.0/24"
  network       = google_compute_network.vpc.id
  region        = "us-east1"

}