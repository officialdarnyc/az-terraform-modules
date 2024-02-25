locals {
    ifconfig_co_json = jsondecode(data.http.my_public_ip.body)
}
