#!/bin/bash

function info() {
	local -r message="${1}"
	echo -e "\033[1;36m${message}\033[0m" 2>&1
}

function getLastAptGetUpdate() {
	local aptDate
	local nowDate

	aptDate="$(stat -c %Y '/var/lib/apt/periodic/update-success-stamp')"
	nowDate="$(date +'%s')"

	echo $((nowDate - aptDate))
}

function runAptGetUpdate() {
	local lastAptGetUpdate
	local lastUpdate

	lastAptGetUpdate="$(getLastAptGetUpdate)"

	# Default To 24 hours
	updateInterval="$((24 * 60 * 60))"

	if [[ "${lastAptGetUpdate}" -gt "${updateInterval}" ]]
	then
			info "apt update"
			apt update -y && apt upgrade -y && apt dist-upgrade -y && apt full-upgrade -y

	else
			lastUpdate="$(date -u -d @"${lastAptGetUpdate}" +'%-Hh %-Mm %-Ss')"

			info "\nSkip apt-get update because its last run was '${lastUpdate}' ago"
	fi
}

if [[ $EUID -ne 0 ]]; then
		echo "This script must be run as root"
		exit 1

else
#        echo "connect to wifi"
#        nmcli d wifi connect Bluebottle password Blu3B0ttl3
     runAptGetUpdate
    echo "Install common packages"
    sudo apt install snap python3-pip -y
    sudo apt install dialog -y

	cmd=(dialog --separate-output --checklist "Please select things you want to install" 22 76 16)
	options=(
	    1 "Google Chrome" on    # any option can be set to default to "on"
        2 "Intellij Ultimate" on
        3 "LibreOffice" on
        4 "SublimeText" on
        5 "NodeJs & Yarn" on
        6 "JDK 8" on
        7 "Docker & docker-compose" on
        8 "MongoDB" on
        9 "Elasticsearch" on
        10 "Postman" on
        11 "Redis" on
        12 "Skype" on
        13 "Mattermost" on
        14 "SSH server" on
        15 "Clipboard manager" on
        15 "Vietnamese IME (ibus-bamboo)" on
        16 "Handy Tools" on
    )

	choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
	clear
	for choice in $choices
	do
        case $choice in
		1)
            echo "Google Chrome"
                if command -v google-chrome ; then
                    echo "Google Chrome is already installed."
                else
                    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
                    sudo dpkg -i google-chrome-stable_current_amd64.deb
                fi
            ;;
		2)
            echo "Intellij Ultimate"
            sudo snap install intellij-idea-ultimate --classic
            ;;
		3)
            echo "LibreOffice"
            sudo apt install libreoffice -y
            ;;
		4)
            echo "SublimeText"
            sudo snap install sublime-text --classic
            ;;
		5)
            echo "NodeJs & Yarn"
            sudo apt install git -y
            export NVM_DIR="$HOME/.nvm" && (
            git clone https://github.com/nvm-sh/nvm.git "$NVM_DIR"
            cd "$NVM_DIR"
            git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
            ) && \. "$NVM_DIR/nvm.sh"

            # latest version
            nvm install node
            nvm use node

            npm install -g yarn
            ;;
		6)
            echo "JDK 8"
            sudo apt install openjdk-8-jdk openjdk-8-jdk-headless -y
            ;;
		7)
            echo "Docker & docker-compose"
            sudo snap install docker
            sudo apt install docker-ce -y && sudo usermod -aG docker $USER && sudo chmod 666 /var/run/docker.sock

            sudo apt install docker-compose
            ;;
		8)
            echo "MongoDB"
            sudo docker run -d --name=mongo --restart=always -p=27017:27017 mongo:latest
            ;;
		9)
            echo "ElasticSearch"
            sudo docker run --name elasticsearch \
             -p 9200:9200 \
             -e discovery.type=single-node \
             -e ES_JAVA_OPTS="-Xms1g -Xmx1g" \
             -e xpack.security.enabled=false \
             --restart=always \
             -d docker.elastic.co/elasticsearch/elasticsearch:7.13.2
            ;;
        10)
            echo "Postman"
            sudo snap install postman --classic
            ;;
        11)
            echo "Redis"
            sudo docker run -d --name redis-stack -p 6379:6379 -p 8001:8001 --restart=always redis/redis-stack:latest
            ;;
        12)
            echo "Skype"
            sudo snap install skype --classic
            ;;
        13)
            echo "Mattermost"
            sudo snap install mattermost-desktop
            ;;
        14)
            echo "SSH server"
            sudo apt install -y openssh-server
            ;;
        15)
            echo "Clipboard manager"
            sudo apt install copyq
            ;;
        16)
            echo "Vietnamese Input Method Editor (ibus-bamboo)"
            sudo add-apt-repository ppa:bamboo-engine/ibus-bamboo
            sudo apt update
            sudo apt install ibus ibus-bamboo --install-recommends
            ibus restart
            # Đặt ibus-bamboo làm bộ gõ mặc định
            env DCONF_PROFILE=ibus dconf write /desktop/ibus/general/preload-engines "['BambooUs', 'Bamboo']" && gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'us'), ('ibus', 'Bamboo')]"
            ;;
		17)
            echo "Handy Tools (htop, peek, jq..)"
            # htop
            sudo apt install htop
            # peek
            sudo apt install peek
            # jq
            sudo apt install jq
            # ncdu
            sudo apt install ncdu
            ;;
        esac
	done

fi
