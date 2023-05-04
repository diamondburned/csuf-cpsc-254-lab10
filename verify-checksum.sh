#!/usr/bin/env bash
SOURCES=(
	src
	static
	package-lock.json
	svelte.config.js
	tsconfig.json
	vite.config.ts
)

CORRECT_HASH="cff21728b20ae6c4d80ed57af45c5c58a446f239959b5f2d6f94d0aefced549c"

recursiveHash=$(
	find "${SOURCES[@]}" -type f -exec sha256sum {} \; \
		| sha256sum \
		| cut -d' ' -f1
	)
if [[ "$recursiveHash" == "$CORRECT_HASH" ]]; then
	exit 0
fi

echo "Hashes do not match!" >&2
echo "  Expected: $CORRECT_HASH" >&2
echo "  Actual:   $recursiveHash" >&2
echo "Either you're missing some files, or you've modified some files." >&2
echo "Please git clone the project again, and do not modify any files." >&2

exit 1
