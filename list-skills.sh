#!/usr/bin/env sh
# Print each skill's name and description from its SKILL.md frontmatter.
cd "$(dirname "$0")/skills" || exit 1
for f in */SKILL.md; do
	# ponytail: single-line `description:` only; a folded (>) or multi-line one prints its first line
	awk -v dir="${f%/SKILL.md}" '
		/^---$/ { if (++n == 2) exit; next }
		n == 1 && sub(/^name: */, "") { name = $0 }
		n == 1 && sub(/^description: */, "") { desc = $0 }
		END { printf "%s\n  %s\n\n", (name != "" ? name : dir), desc }
	' "$f"
done
