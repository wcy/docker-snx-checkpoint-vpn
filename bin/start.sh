BIN_DIR=$(dirname $0)

$BIN_DIR/routes_clean.sh

# container start
. ~/.snxrc
echo $SNX_SERVER
echo $SNX_USERNAME
docker run --name snx-vpn \
  --cap-add=ALL \
  -v /lib/modules:/lib/modules \
  -e SNX_SERVER=$SNX_SERVER \
  -e SNX_USERNAME=$SNX_USERNAME \
  -e SNX_PASSWORD=$SNX_PASSWORD \
  -t \
  -d snx-vpn

# routes add
DOCKER_IP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' snx-vpn)
for LINE in $(cat $BIN_DIR/../whitelist.txt); do
  echo === $LINE ===
  for IP in $(dig +noall +answer +short $LINE | grep -v '\.$'); do
    echo "Adding ip: $IP"
    sudo ip route add $IP via $DOCKER_IP
  done
done
