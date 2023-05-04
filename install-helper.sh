#!/usr/bin/env bash
has() {
	command -v "$1" &> /dev/null
}

cat<<EOF
Welcome to the menu!
Please choose an option:
0 Exit
1 Project Introduction
2 File Integrity Check Helper
3 Dependency Check Helper
4 Credits
EOF

read -p "Enter your choice: " choice

case $choice in
0) exit 0;;
1) has nano && nano -v README.md || less README.md;;
2) ./verify-checksum.sh;;
3) ./check-dependencies.sh;;
4)
	echo "This project was created by:"
	echo
	echo "  - Diamond Dinh   (@diamondburned)"
	echo "  - Karene Rosales (@karenerosales)"
	echo "  - Malik Hidouk   (@mhdk7)"
	echo
	echo "Refer to the repository (https://github.com/diamondburned/chatter) for more information."
	;;
*)
	echo "Invalid choice!" >&2
	exit 1
esac
