i#!/bin/bash



Install_Docker(){

	sudo apt-get update
	sudo apt-get install apt-transport-https ca-certificates curl gnupg2 software-properties-common -y
	sudo curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
	sudo echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list

	sudo apt update
	sudo apt-get install docker-ce docker-ce-cli containerd.io -y
	sudo systemctl enable docker
	sudo groupadd -f docker
	sudo chown root:docker /var/run/docker.sock
	sudo usermod -a -G docker "$(whoami)"
	newgrp docker
	sudo systemctl restart docker
	#echo "export DOCKER_HOST=tcp://localhost:2375" >> /home/groupe1cloud/.bashrc
	#echo "export DOCKER_HOST=unix:///var/run/docker.sock" >> /home/groupe1cloud/.bashrc

}

Install_Docker-compose(){

	sudo curl -SL https://github.com/docker/compose/releases/download/v2.9.0/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose
	sudo chmod +x /usr/local/bin/docker-compose
}

Install_chat(){

	curl -L https://raw.githubusercontent.com/RocketChat/Docker.Official.Image/master/compose.yml -O
	docker-compose up
}

main(){

	Install_Docker
	Install_Docker-compose
	Install_chat
}

main
