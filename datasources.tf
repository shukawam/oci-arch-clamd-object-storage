## Copyright (c) 2020, Oracle and/or its affiliates. 
## All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl

data "oci_objectstorage_namespace" "ns" {
    compartment_id = var.compartment_ocid
}

data "oci_core_vnic_attachments" "ScanInstance_primaryvnic_attach" {
  availability_domain = var.availablity_domain_name
  compartment_id      = oci_identity_compartment.ScanCompart.id
  instance_id         = oci_core_instance.ScanInstance.id
}

data "oci_core_vnic" "ScanInstance_primaryvnic" {
  vnic_id = data.oci_core_vnic_attachments.ScanInstance_primaryvnic_attach.vnic_attachments.0.vnic_id
}

data "oci_identity_region_subscriptions" "home_region_subscriptions" {
    tenancy_id = var.tenancy_ocid

    filter {
      name   = "is_home_region"
      values = [true]
    }
}