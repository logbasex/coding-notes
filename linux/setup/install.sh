#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   	echo "This script must be run as root" 
   	exit 1

else
        echo "Update and upgrade"
        apt update -y && apt upgrade -y && apt dist-upgrade -y && apt full-upgrade -y

	echo "Install common packages"
	apt install snap python3-pip -y
        apt install dialog
	cmd=(dialog --separate-output --checklist "Please select things you want to install" 22 76 16)
	options=(1 "Google Chrome" on    # any option can be set to default to "on"
		 2 "Intellij Ultimate" on
		 3 "DataGrip" on
		 4 "Communications" on
		 5 "Office" on
		 6 "SublimeText" on
		 7 "Yarn" on
		 8 "NodeJs" on
		 9 "JDK 8" on
		 10 "Docker" on
		 11 "MySQL 5.6" on
		 12 "MongoDB" on
		 13 "RabbitMQ" on
		 14 "Elasticsearch" on
		 15 "Handy Tools" off)
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
		    echo "DataGrip"
		    sudo snap install datagrip --classic
		    ;;
		4)
		    echo "Communications"
		    sudo snap install slack --classic
		    sudo snap install skype --classic
		    ;;
		5)
		    echo "Office"
		    sudo apt install libreoffice -y
		    ;;
		6)
		    echo "SublimeText"
		    sudo snap install sublime-text --classic
		    ;;
		7)
		    echo "Yarn"
		    sudo apt install --no-install-recommends yarn -y
		    ;;
		8)
		    echo "NodeJs"
		    sudo apt install git -y
		    export NVM_DIR="$HOME/.nvm" && (
		    git clone https://github.com/nvm-sh/nvm.git "$NVM_DIR"
		    cd "$NVM_DIR"
		    git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
		    ) && \. "$NVM_DIR/nvm.sh"
		    
		    nvm install v14.17.0
		    nvm use v14.17.0
		    ;;
		9)
		    echo "JDK 8"
		    sudo apt install openjdk-8-jdk openjdk-8-jdk-headless -y
		    ;;
		10)
		    echo "Docker"
		    sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
		    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
		    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
		    sudo apt update -y
		    sudo apt install docker-ce -y && sudo usermod -aG docker $USER && sudo chmod 666 /var/run/docker.sock

		    pip3 install docker-compose
		    ;;
		11)
		    echo "MySQL 5.6"
		    mkdir -p $HOME/docker/mysql56
		    sudo docker pull mysql:5.6

		    sudo docker run -p 3306:3306 --name mysql56 \
			    --restart always \
			    -v $PWD/conf:/etc/mysql \
			    -v $PWD/logs:/var/log/mysql \
			    -v $PWD/data:/var/lib/mysql \
			    -e MYSQL_ROOT_PASSWORD=123456 \
			    -d mysql:5.6 \
			    --character-set-server=utf8mb4 \
			    --collation-server=utf8mb4_unicode_ci	
		    ;;
		12)
		    echo "MongoDB"
		    sudo docker run -d --name=mongo44 --restart=always -p=27017:27017 mongo:latest
		    ;;
		13)
		    echo "RabbitMQ"
		    docker run -d --hostname my-rabbit --name some-rabbit --restart=always -p 4369:4369 -p 5671:5671 -p 5672:5672 -p 15672:15672 rabbitmq
		    docker exec some-rabbit rabbitmq-plugins enable rabbitmq_management
		    ;;
		14)
		    echo "ElasticSearch"
		    curl -fsSL https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
		    echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list
		    sudo apt update -y
		    sudo apt install elasticsearch -y
		    
		    echo "-Xms1G" > /etc/elasticsearch/jvm.options.d/user.options
		    echo "-Xmx1G" >> /etc/elasticsearch/jvm.options.d/user.options

		    sudo systemctl start elasticsearch.service
		    sudo systemctl enable elasticsearch.service
		    ;;

		15)
		    echo "Handy Tools"
		    ;;
	    esac
	done

fi
