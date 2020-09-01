#!/bin/bash

OSREL="/etc/os-release"

# Install Dependencies
if grep -q "centos" $OSREL; then
    sudo yum install -y zlib-devel bzip2 bzip2-devel readline-devel sqlite \
        sqlite-devel openssl-devel xz xz-devel libffi-devel git
elif grep -q "ubuntu" $OSREL; then
    sudo apt-get install -y make build-essential libssl-dev zlib1g-dev \
        libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev \
        libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python-openssl git
elif grep -q "alpine" $OSREL; then
    apk add libffi-dev ncurses-dev openssl-dev readline-dev \
        tk-dev xz-dev zlib-dev git
else
    echo "Your OS is not supported."
    exit 1
fi

# Install pyenv
curl https://pyenv.run | bash

# Add init to bashrc
cat <<'EOF' >> ~/.bashrc
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
EOF

# source bashrc
source ~/.bashrc

# Install Python 
PVERSION=3.6.12
echo "Installing Python Version $PVERSION to start you off..."
pyenv install $PVERSION

# Final Remarks
DOCS_URL="https://github.com/pyenv/pyenv/blob/master/COMMANDS.md"
echo "You're ready to python. For information on how to use pyenv you can go here, $DOCS_URL"
