#!/bin/bash

declare -a entries=("192.168.1.100 api api.k8s.local"
       "192.168.1.101 master1 master1.k8s.local"
       "192.168.1.102 master2 master2.k8s.local"
       "192.168.1.103 master3 master3.k8s.local"
       "192.168.1.121 worker1 worker1.k8s.local"
       "192.168.1.122 worker2 worker2.k8s.local"
       "192.168.1.123 worker3 worker3.k8s.local"
       )

for entry in "${entries[@]}"; do 
  egrep "$entry" /etc/hosts > /dev/null || echo "$entry" >> /etc/hosts
done
