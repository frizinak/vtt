README.md: doc/vtt.txt
	cat "$<" | sed -E \
		-e '1,/\*vtt\*/d' \
		-e '/SUGGESTED USAGE/,$$d' \
		-e '/^=+$$/d' \
		-e 's/\|([^\s]+)\|/`\1`/g' \
		-e 's/^\s+([A-Z][A-Z]+)/# \1/' \
		-e 's/^([A-Z][A-Z]+)/## \1/' \
		-e 's/\*[a-z\-]+\*//g' \
		-e 's/\s+$$//g' > \
		"$@"
