#!/bin/bash
#
# FROM https://community.hetzner.com/tutorials/letsencrypt-dns

# I manually put this here, does it make sense for it to live here, or should I put this in the script itself and clean it up in cleanup?
token="$(cat /etc/hetzner-dns-token)"

domain_name="$(echo $CERTBOT_DOMAIN | rev | cut -d'.' -f 1,2 | rev)"
subdomain=".${CERTBOT_DOMAIN%.$domain_name}"
if [ "$CERTBOT_DOMAIN" = "$domain_name" ]; then
	subdomain=""
fi

curl "https://api.hetzner.cloud/v1/zones/${domain_name}/rrsets/_acme-challenge${subdomain}/TXT" \
	-X "DELETE" \
	-H "Authorization: Bearer ${token}" >/dev/null 2>/dev/null
