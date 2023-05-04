#!/usr/bin/env bash

has() {
	if ! command -v "$1" &> /dev/null; then
		return 1
	fi
}

# Ensure .env file is loaded before we do any checks.
if [[ -f .env ]]; then
	set -o allexport
	source .env
	set +o allexport
fi

fail=0

if ! has "npm"; then
	echo "check npm:"
	echo "  NodeJS is not installed! Please install NodeJS."
	echo "  If you're on Ubuntu, run these commands:"
	echo
	echo "    curl -fsSL https://deb.nodesource.com/setup_19.x | sudo -E bash -"
	echo "    sudo apt install -y nodejs"
	echo
	fail=1
fi

if [[ ! "$DATABASE_URL" ]]; then
	echo "check DATABASE_URL:"
	echo "  DATABASE_URL is not set!"
	echo "  Please set DATABASE_URL in your .env file and try again."
	echo "  For more information, see https://www.postgresql.org/docs/current/libpq-connect.html#LIBPQ-CONNSTRING."
	echo "  If you're using ElephantSQL, you can find your connection string in the 'Details' tab of your database."
	echo
	fail=1
fi

if [[ ! -d node_modules ]]; then
	echo "check node_modules:"
	echo "  Node modules are not installed!"
	echo "  Please run 'npm i' to install dependencies and try again."
	echo
	fail=1
fi

if [[ $fail == 0 ]]; then
	echo "All checks passed!"
fi

exit $fail
