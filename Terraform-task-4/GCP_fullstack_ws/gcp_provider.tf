provider "google" {
  credentials = "${file("celtic-medium-313905-393d4faedcec.json")}"
  project     = "celtic-medium-313905"
  region      = var.region
}