#!/bin/sh

status=0

check_url() {
	url="$1"

	if curl --fail --show-error --silent --max-time 2 --location "$url" > /dev/null; then
		echo -e "[\033[0;32m✓\033[0m] $url"
	else
		echo -e "[ ] \033[0;31m$url\033[0m"
		status=1
	fi
}

check_url papill0n.org
check_url papill0n.org/favicon?url=https://google.com
check_url papill0n.org/weird_dreams
check_url git.papill0n.org
check_url one.papill0n.org
check_url pixl.papill0n.org
check_url pad.papill0n.org

check_url heartheartheart.club

exit $status
