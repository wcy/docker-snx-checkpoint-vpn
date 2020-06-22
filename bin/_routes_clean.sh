DOCKER_IP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' snx-vpn)
ip route | grep $DOCKER_IP |
  while IFS= read -r IP
  do
    IP=$(echo $IP | cut -d' ' -f1)
    echo Removing from route table: $IP
    sudo ip route del $IP
  done
