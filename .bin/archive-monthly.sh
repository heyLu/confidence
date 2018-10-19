#!/bin/bash

TARGET="$HOME/d/history-$(date +%Y-%m)"

echo "Archiving files (and directories in) $PWD to $TARGET"
mkdir --parent "$TARGET"

DRY_RUN="yes"
if [ "$1" = "--no-dry-run" ]; then
	DRY_RUN="no"
	shift
fi

MV_STYLE="--interactive"
if [ "$1" = "--no-clobber" ]; then
	MV_STYLE="--no-clobber"
	shift
fi

ignored=".local\n.cache\n$(git ls-files)"

for file in $(find . -maxdepth 1 -name '.*' -printf '%P\n' | sort); do
	if echo "$ignored" | grep "$file" > /dev/null; then
		continue
	fi

	size=$(du -s -b "$file" | cut -f1)
	echo "$file = $size"
	if [ "$size" -lt "1000000" ]; then
		echo mv --verbose "$MV_STYLE" "$file" "$TARGET/$file"
		[ "$DRY_RUN" = "no" ] && mv --verbose "$MV_STYLE" "$file" "$TARGET/$file"
	else
		echo "$file is too big ($size)"
		echo -n "What to do? ((a)rchive/(rm)remove/(s)kip): "
		if [ "$DRY_RUN" = "yes" ]; then
			echo "dry run"
			continue
		fi
		read answer
		case "$answer" in
			a|archive)
				echo mv --verbose "$MV_STYLE" "$file" "$TARGET/$file"
				mv --verbose "$MV_STYLE" "$file" "$TARGET/$file"
				;;
			rm|remove)
				echo rm --recursive --interactive=once "$file"
				rm --verbose --recursive --interactive=once "$file"
				;;
			s|skip)
				echo "skipping $file"
				;;
			*)
				echo "unknown command '$answer', skipping"
				;;
		esac
	fi
done
