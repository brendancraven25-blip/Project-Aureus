#!/bin/bash
# Auric - Setup & Recovery Protocol
# Run this script to re-establish connections and configurations if the environment is reset.

set -e

echo "⚡ Starting Auric Setup & Recovery Protocol..."

# 1. SSH & GitHub configuration
echo "-> Checking SSH config for GitHub..."
mkdir -p ~/.ssh
if ! grep -q "IdentityFile ~/.ssh/auric_project_aureus" ~/.ssh/config 2>/dev/null; then
    cat << 'SSH_CONF' >> ~/.ssh/config
Host github.com
  IdentityFile ~/.ssh/auric_project_aureus
  IdentitiesOnly yes
SSH_CONF
    echo "   Added GitHub SSH config."
fi
chmod 600 ~/.ssh/config

if [ ! -f ~/.ssh/auric_project_aureus ]; then
    echo "⚠️  WARNING: ~/.ssh/auric_project_aureus private key is missing!"
    echo "   Please restore the SSH private key before attempting git operations."
else
    echo "   SSH key is present."
    chmod 600 ~/.ssh/auric_project_aureus
fi

# 2. OpenClaw Identity Settings
echo "-> Syncing OpenClaw Identity..."
openclaw agents set-identity \
    --agent "auric" \
    --workspace "/home/auric/.openclaw/workspace" \
    --name "Auric" \
    --theme "Sharp, precise, and always reliable." \
    --emoji "⚡" \
    --avatar "avatars/avatar.png"
echo "   Identity synced."

# 3. API Keys Check
echo "-> Checking external API keys..."
for KEY in ~/.gemini_paid.key ~/.gemini_free.key; do
    if [ -f "$KEY" ]; then
        chmod 600 "$KEY"
        echo "   Found and secured $KEY"
    else
        echo "⚠️  WARNING: Missing API key file: $KEY"
    fi
done

# 4. Git Workspace Check
echo "-> Checking Git workspace..."
cd /home/auric/.openclaw/workspace
if [ -d ".git" ]; then
    echo "   Git repository is initialized."
else
    echo "⚠️  WARNING: Workspace is not a git repo. You may need to run:"
    echo "   git init && git remote add origin git@github.com:brendancraven25-blip/Project-Aureus.git"
fi

echo "⚡ Recovery Protocol Complete."
