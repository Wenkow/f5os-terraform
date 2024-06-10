variable username {
    description = "F5 user name"
    type = string
}
variable password {
    description = "F5OS user password"
    type = string
}

variable target1 {
    description = "F5OS host URL including scheme and port"
    type = string
    default = ""
}

variable vlans_external {
    description = "List of external VLANs"
    type  = map(object({
    vlanid  = number
    }))
    default = {}
}

variable vlans_internal {
    description = "List of internal VLANs"
    type  = map(object({
    vlanid  = number
    }))
    default = {}
}