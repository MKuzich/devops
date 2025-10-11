#!/bin/bash
set -e

echo "Starting development tools installation..."

check_command() {
    command -v "$1" >/dev/null 2>&1
}

if check_command docker; then
    echo "Docker already has been installed: $(docker --version)"
else
    echo "Installing Docker..."
    sudo apt-get update -y
    sudo apt-get install -y ca-certificates curl gnupg lsb-release
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
      https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) stable" | \
      sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update -y
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io
    echo "Docker successfully installed: $(docker --version)"
fi

if check_command docker-compose; then
    echo "Docker Compose already has been installed: $(docker-compose --version)"
else
    echo "Installing Docker Compose..."
    COMPOSE_VERSION=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep -Po '"tag_name": "\K.*?(?=")')
    sudo curl -L "https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    echo "Docker Compose successfully installed: $(docker-compose --version)"
fi

if check_command python3; then
    PY_VER=$(python3 -V | awk '{print $2}')
    if [[ "$(printf '%s\n' "3.9" "$PY_VER" | sort -V | head -n1)" = "3.9" ]]; then
        echo "Python already has been installed: version $PY_VER"
    else
        echo "Updating Python to version 3.9+..."
        sudo apt-get update -y
        sudo apt-get install -y python3 python3-pip
    fi
else
    echo "Installing Python 3.9+..."
    sudo apt-get update -y
    sudo apt-get install -y python3 python3-pip
fi

if ! check_command pip3; then
    echo "pip3 not found, installing..."
    sudo apt-get install -y python3-pip
fi

if python3 -m django --version >/dev/null 2>&1; then
    echo "Django already has been installed: version $(python3 -m django --version)"
else
    echo "Installing Django in a virtual environment..."

    sudo apt-get install -y python3-venv

    python3 -m venv ~/dev_env
    source ~/dev_env/bin/activate

    pip install --upgrade pip
    pip install django

    echo "Django installed successfully in virtual environment ~/dev_env"
    echo "Version: $(django-admin --version)"

    if ! grep -q "alias activate_dev" ~/.bashrc; then
        echo "alias activate_dev='source ~/dev_env/bin/activate'" >> ~/.bashrc
        echo "💡 Added alias 'activate_dev' to ~/.bashrc — use it to activate the environment anytime."
    fi

    deactivate
fi

echo "Development tools installation completed."