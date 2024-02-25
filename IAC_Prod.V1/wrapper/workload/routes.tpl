{
    "${ aks_cluster_name }" : [
%{ for index, route in routes ~}
        {
            "frontend_route": "${ route.frontend_route }",
            "backend_route": "${ route.backend_route }",
            "accepted_protocols": "${ route.accepted_protocols }", 
            "forwarding_protocol": "${ route.forwarding_protocol }"
        } ${ route.last }
%{ endfor ~}
    ]
}
