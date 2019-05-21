#!/bin/bash

declare -a entries=("10.0.0.10 api api.k8s.local"
       "10.0.0.21 master1 master1.k8s.local"
       "10.0.0.22 master2 master2.k8s.local"
       "10.0.0.23 master3 master3.k8s.local"
       "10.0.0.31 worker1 worker1.k8s.local"
       "10.0.0.32 worker2 worker2.k8s.local"
       "10.0.0.33 worker3 worker3.k8s.local"
       )

for entry in "${entries[@]}"; do 
  egrep "$entry" /etc/hosts > /dev/null || echo "$entry" >> /etc/hosts
done
