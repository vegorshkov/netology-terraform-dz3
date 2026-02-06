# NAT Gateway для подключения ansibl
resource "yandex_vpc_gateway" "nat_gateway" {
  name = "nat-gateway"
  shared_egress_gateway {}
}

# NAT LAN routing to gw
resource "yandex_vpc_route_table" "nat_route_table" {
  name       = "nat-route-table"
  network_id = yandex_vpc_network.develop.id

  static_route {
    destination_prefix = "0.0.0.0/0"
    gateway_id         = yandex_vpc_gateway.nat_gateway.id
  }
}

