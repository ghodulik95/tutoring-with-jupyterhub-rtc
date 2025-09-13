#!/bin/bash
set -e

USERLIST_FILE="/srv/jupyterhub/userlist.txt"

if [ -f "$USERLIST_FILE" ]; then
  while IFS=, read -r username password; do
    if [ -n "$username" ] && [ -n "$password" ]; then
      # Create user if missing
      if ! id -u "$username" >/dev/null 2>&1; then
        echo "Creating user $username"
        useradd -m -s /bin/bash "$username"
      fi

      # Reset password each startup
      echo "$username:$password" | chpasswd
    fi
  done < "$USERLIST_FILE"
else
  echo "⚠️ No userlist file found at $USERLIST_FILE"
fi

# Hand control back to JupyterHub
exec "$@"
