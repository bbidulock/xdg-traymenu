#!/bin/bash

. ~/.config/user-dirs.dirs

dirs="XDG_DESKTOP_DIR XDG_TEMPLATES_DIR"

echo "{"
for v in $dirs ; do
	eval "val=\"\$$v\""
	echo -e "\t$v => '$val',"
done
echo "}"

exit 0
