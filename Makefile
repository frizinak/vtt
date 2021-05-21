README.md: doc/vtt.txt
	cat "$<" | \
		sed '1,/\*vtt\*/d' | \
		sed '/SUGGESTED USAGE/,$$d' | \
		sed 's/\*[a-z\-]\+\*//g' | \
		sed 's/\s\+$$//g' > \
		"$@"
