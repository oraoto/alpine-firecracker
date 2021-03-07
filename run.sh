#!/bin/sh

rm /tmp/firecracker.socket
exec firecracker --api-sock /tmp/firecracker.socket --config-file vm-config.json
