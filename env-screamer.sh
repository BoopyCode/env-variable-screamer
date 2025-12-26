#!/usr/bin/env bash
# ENV Variable Screamer - Because silent failures are the worst kind of party guests

# Colors for dramatic effect (like a horror movie, but for config)
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color (the boring kind)

# The scream function - makes missing vars impossible to ignore
scream() {
    echo -e "${RED}"
    echo "╔══════════════════════════════════════════════════════════╗"
    echo "║                    AAAAAAAAAAAHHHHHHHHH!                 ║"
    echo "║          ENVIRONMENT VARIABLE SCREAM DETECTED!           ║"
    echo "╚══════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
    echo -e "${YELLOW}Missing variable: $1${NC}"
    echo -e "${YELLOW}Description: $2${NC}"
    echo ""
    exit 1
}

# The whisper function - for when things are actually okay (rare)
whisper() {
    echo -e "${GREEN}✓ $1 is set${NC}"
}

# Check if we have any variables to check (spoiler: we always do)
if [ $# -eq 0 ]; then
    echo "Usage: $0 VAR1:description VAR2:description ..."
    echo "Example: $0 \"API_KEY:Your shiny API key\" \"DB_URL:Where data sleeps\""
    exit 1
fi

# Main event: The screaming begins
for var_desc in "$@"; do
    # Split variable name from description (like separating twins at birth)
    var_name="${var_desc%%:*}"
    description="${var_desc#*:}"
    
    # Check if the variable exists and isn't empty
    if [ -z "${!var_name}" ]; then
        scream "$var_name" "$description"
    else
        whisper "$var_name"
    fi
done

# If we made it here, all variables exist! (Celebrate responsibly)
echo -e "${GREEN}"
echo "╔══════════════════════════════════════════════════════════╗"
echo "║         All environment variables are present!           ║"
echo "║     (This is probably a mistake, check again)            ║"
echo "╚══════════════════════════════════════════════════════════╝"
echo -e "${NC}"
