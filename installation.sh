#!/bin/sh
# Installation

echo -n "Please insert fqdn (eg: example.com): "
read DOMAIN_NAME
echo -n "Please insert netbios domain name (eg: example): "
read SHORT_DOMAIN_NAME
echo -n "Please insert domain user authenticate with (eg: super.user): "
read DOMAIN_USER
echo -n "Please insert DNS server (eg: 172.16.24.1): "
read DOMAIN_CONTROLLER



sudo apt-get purge --auto-remove winbind
sudo wget http://download.beyondtrust.com/PBISO/8.0.0.2016/linux.deb.i386/pbis-open-8.0.0.2016.linux.x86.deb.sh \
	-v -O pbis-open-8.0.0.2016.linux.x86.deb.sh \
	&& sudo chmod a+x pbis-open-8.0.0.2016.linux.x86.deb.sh \
	&& sudo ./pbis-open-8.0.0.2016.linux.x86.deb.sh; \
	rm -rf pbis-open-8.0.0.2016.linux.x86.deb.sh \
	&& sudo sed -i "0,/.*nameserver.*/s//nameserver $DOMAIN_CONTROLLER/" /etc/resolv.conf \
	&& sudo domainjoin-cli join $DOMAIN_NAME "$DOMAIN_USER@$DOMAIN_NAME" \
	&& sudo /opt/pbis/bin/config Requiremembershipof "$SHORT_DOMAIN_NAME\\domain^users" "$SHORT_DOMAIN_NAME\\domain^admins" \
	&& sudo /opt/pbis/bin/config AssumeDefaultDomain true \
	&& sudo /opt/pbis/bin/config UserDomainPrefix $SHORT_DOMAIN_NAME \
	&& sudo /opt/pbis/bin/config LoginShellTemplate /bin/bash \
	&& sudo sed -i "/pam_lsass.so/ s/sufficient/[success=ok default=ignore]/" /etc/pam.d/common-session \
	&& sudo grep "%$SHORT_DOMAIN_NAME\\domain^admins ALL=(ALL:ALL) ALL" /etc/sudoers || sudo echo "%$SHORT_DOMAIN_NAME\\domain^admins ALL=(ALL:ALL) ALL" >> /etc/sudoers \
	&& sudo grep "%domain^admins ALL=(ALL:ALL) ALL" /etc/sudoers || sudo echo "%domain^admins ALL=(ALL:ALL) ALL" >> /etc/sudoers \
	&& sudo grep "allow-guest=false" /usr/share/lightdm/lightdm.conf.d/50-zorin-greeter.conf || sudo echo "allow-guest=false" >> /usr/share/lightdm/lightdm.conf.d/50-zorin-greeter.conf \
	&& sudo grep "greeter-show-remote-login=false" /usr/share/lightdm/lightdm.conf.d/50-zorin-greeter.conf || sudo echo "greeter-show-remote-login=false" >> /usr/share/lightdm/lightdm.conf.d/50-zorin-greeter.conf \
	&& sudo grep "greeter-show-manual-login=true" /usr/share/lightdm/lightdm.conf.d/50-zorin-greeter.conf || sudo echo "greeter-show-manual-login=true" >> /usr/share/lightdm/lightdm.conf.d/50-zorin-greeter.conf \
	&& sudo grep "greeter-hide-users=true" /usr/share/lightdm/lightdm.conf.d/50-zorin-greeter.conf || sudo echo "greeter-hide-users=true" >> /usr/share/lightdm/lightdm.conf.d/50-zorin-greeter.conf

# set startup of lwsmd (ad) service to reasonably last
# this is done so that it has some time to startup the network
sudo update-rc.d -f lwsmd remove
sudo update-rc.d lwsmd defaults 99
