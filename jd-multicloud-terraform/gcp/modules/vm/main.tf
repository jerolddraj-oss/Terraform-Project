resource "google_compute_instance" "vm" {

  count = 2

  name         = "jd-vm-${count.index}"
  machine_type = "e2-medium"
  zone         = "us-east1-b"

  boot_disk {

    initialize_params {

      image = "windows-cloud/windows-server-2019"

    }

  }

  network_interface {

    network = var.network
    subnetwork = var.subnet

  }

}