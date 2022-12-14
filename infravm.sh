#!/bin/bash


nomgroup=Groupe1_Brief10
nomvnet=Groupe1vnet
ipvnet=192.168.1.0/24
nomsubnet=Groupe1subnet
ipsubnet=192.168.1.0/27
nomippublic=Groupe1ippub
nomnsg=Groupe1nsg
nomnic=Groupe1nic
nomvm=Groupe1vm
nomadmin=groupe1cloud
mdpadmin=Promo20cloud
ipvm=192.168.1.5
nomvault=groupunvault



Create_group (){

	az group create -l northeurope -n $nomgroup
}

Create_network (){

	az network vnet create -g $nomgroup -n $nomvnet --address-prefix $ipvnet --subnet-name $nomsubnet --subnet-prefix $ipsubnet
	az network public-ip create --resource-group $nomgroup --name $nomippublic --sku Standard --zone 1 2 3
	az network nsg create --resource-group $nomgroup --name $nomnsg
}

Create_vm (){

	az network nic create --resource-group $nomgroup --name $nomnic --vnet-name $nomvnet --subnet $nomsubnet --network-security-group $nomnsg
	az vm create -g $nomgroup -n $nomvm --admin-username $nomadmin --admin-password $mdpadmin --image Debian:debian-11:11-gen2:0.20210928.779 --size Standard_DS1_v2 --authentication-type password --private-ip-address $ipvm --no-wait --nics $nomnic
}

Create_backup (){

	az backup vault create --resource-group $nomgroup --name $nomvault
	az backup vault backup-properties --name $nomvault --resource-group $nomgroup --backup-storage-redundancy LocallyRedundant
	az backup protection enable-for-vm --resource-group $nomgroup --vault-name $nomvault --vm $nomvm --policy-name DefaultPolicy
}

main (){

	Create_group
	Create_network
	Create_vm
	Create_backup
}

main
