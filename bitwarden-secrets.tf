locals {
  bw_k3s_provider_config_id = {
    snb = "1721d632-8ef6-4398-9fd5-b12000dfed36"
    dev = "b7c5eb11-f31e-48b6-b977-b12000dfea02"
  }
}

module "k3s_provider_config" {
  source = "github.com/studio-telephus/terraform-bitwarden-get-item-secure-note.git?ref=1.0.0"
  id     = local.bw_k3s_provider_config_id[var.env]
}
