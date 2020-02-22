# rpi_pub
Raspberry Pi Base Setup and Security Hardening

## Pre-requirements and Assumptions
* Your have burned latest raspbian (buster) image to SD card
* You have done 'touch /boot/ssh" to enable headless ssh login
* You have done 'ssh-copy-id -i ~/.ssh/id_rsa.pub pi@<your pi's IP address>'
* You can successfully login to pi@<your pi's IP address> using passwordless (key-based) authentication with no errors.
* OPTIONAL: install NMAP on the host system you run ansible from. This will enable the discoverPi.sh script to help you find your pi on the network.

## Get this
git clone git@github.com:raajivrekha/rpi_pub.git

## Setup
#### Discover your Pi's IP Address on your network
* cd rpi_pub   
* Run ./discoverPi 192.168.1.0/24 (or whatever your network CIDR is)
* View the output file called "inventory.txt" in rpi_pub folder

#### Use the IP that was discovered for your pi as inventory
* edit the rpi_pub/ansible/inventory file to include the IP that was discovered in the [rpitest] group

#### Edit the rpi_pub/ansible/prepPi.yml file to play with roles and tags, but this is optional and advanced

## Usage
cd rpi_pub/ansible
ansible-playbook -i inventory prepPi.yml 
* Include -vv at the end to see more output
* Include --tags "ssh" as an example to see it just do the SSH configurations


## References and Sources
* Jeff Geerling - https://www.jeffgeerling.com/
* Lynis Security Auditing Tool - https://cisofy.com/lynis/
* Kyber MultiQueue I/O
** https://lwn.net/Articles/720071/
** https://lwn.net/Articles/720675/
