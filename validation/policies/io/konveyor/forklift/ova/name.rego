package io.konveyor.forklift.ova

default valid_input   = true
default valid_vm      = false
default valid_vm_name = false

valid_input = false {
    is_null(input)
}

valid_vm = true {
    is_string(input.name)
}

valid_vm_name = true {
    regex.match("^(([A-Za-z0-9][-A-Za-z0-9.]*)?[A-Za-z0-9])?$", input.name)
    count(input.name) < 64
}

concerns[flag] {
    valid_input
    valid_vm
    not valid_vm_name
    flag := {
        "category": "Warning",
        "label": "Invalid VM Name",
        "assessment": "The VM name must comply with the DNS subdomain name format defined in RFC 1123. The name can contain lowercase letters (a-z), numbers (0-9), periods (.), and hyphens (-), up to a maximum of 63 characters. The first and last characters must be alphanumeric. The name must not contain uppercase letters, spaces, or special characters. The VM will be renamed automatically during the migration to meet the RFC convention."
    }
}
