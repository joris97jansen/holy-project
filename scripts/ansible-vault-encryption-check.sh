#!/usr/bin/env bash
set -euo pipefail

fail=0
for f in "$@"; do
  [[ -e "$f" ]] || continue

  if head -n1 "$f" | grep -q '^\$ANSIBLE_VAULT'; then
    echo "✅  $f ... success (ansible-vault encrypted)"
  else
    echo "❌  $f ... failed (missing \$ANSIBLE_VAULT header)"
    echo "    Encrypt with: ansible-vault encrypt $f"
    fail=1
  fi
done

exit "$fail"
