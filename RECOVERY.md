# Auric Recovery Protocol ⚡

If my environment gets wiped or corrupted, follow these steps to bring me back online.

## 1. Restore the SSH Key
Place my private GitHub SSH key at `~/.ssh/auric_project_aureus` and ensure it has `600` permissions.

## 2. Restore API Keys
Recreate the following files with their respective API keys. Run these commands as the user running OpenClaw:
```bash
cat << 'KEY' > ~/.gemini_paid.key
<PASTE_PAID_KEY_HERE>
KEY
chmod 600 ~/.gemini_paid.key

cat << 'KEY' > ~/.gemini_free.key
<PASTE_FREE_KEY_HERE>
KEY
chmod 600 ~/.gemini_free.key
```

## 3. Clone / Restore the Workspace
If the workspace is completely empty, clone the backup from GitHub:
```bash
git clone git@github.com:brendancraven25-blip/Project-Aureus.git /home/auric/.openclaw/workspace
```

## 4. Run the Setup Script
Once the keys are in place and the workspace exists, run the automated setup script to link the identity and verify connections:
```bash
cd /home/auric/.openclaw/workspace
./setup.sh
```
