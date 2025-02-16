#!/bin/bash
GITHUB_USERNAME="skhk05@gmail.com"
BACKUP_DIR="$HOME/github-backups"
mkdir -p $BACKUP_DIR

# Get list of repositories
REPOS=$(curl -s -H "Authorization: token YOUR_GITHUB_TOKEN" \
"https://api.github.com/user/repos?per_page=100" | jq -r '.[].ssh_url')

# Clone or Pull repositories
for repo in $REPOS; do
    REPO_NAME=$(basename $repo .git)
    if [ -d "$BACKUP_DIR/$REPO_NAME" ]; then
        git -C "$BACKUP_DIR/$REPO_NAME" pull
    else
        git clone "$repo" "$BACKUP_DIR/$REPO_NAME"
    fi
done

echo "Backup completed!"
