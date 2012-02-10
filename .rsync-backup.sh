#!/bin/sh

# rsync's $HOME to my local backup server.

# Check whether I'm at home (yeah, I know...)
ping -c1 192.168.220.109 &> /dev/null
if [ $? != 0 ]; then
	echo "Sorry, looks like noone's home (i.e. you)"
	exit 1
fi

# Assume rsync is alive and well...
echo "All your backups are to belong to RSYNC!"
remote="home:/mnt/HD_a2/lu"
rsync --archive --verbose $@ --filter="merge /home/lu/.rsync-filter" --filter=":- .rsyncignore" /home/lu/ $remote

echo "Last rsync'ed `date --rfc-3339=seconds`, status $?" > /home/lu/.rsync-last
