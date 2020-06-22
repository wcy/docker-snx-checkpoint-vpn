BIN_DIR=$(dirname $0)

$BIN_DIR/_routes_clean.sh

# stop container
docker kill snx-vpn
docker rm snx-vpn
