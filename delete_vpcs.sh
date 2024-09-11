#!/bin/bash

# Function to delete all resources in a VPC
delete_vpc_resources() {
  local vpc_id=$1

  echo "Processing VPC: $vpc_id"

  # Delete Internet Gateways
  igws=$(aws ec2 describe-internet-gateways --filters Name=attachment.vpc-id,Values=$vpc_id --query "InternetGateways[].InternetGatewayId" --output text)
  for igw in $igws; do
    echo "Deleting Internet Gateway: $igw"
    aws ec2 detach-internet-gateway --internet-gateway-id $igw --vpc-id $vpc_id
    aws ec2 delete-internet-gateway --internet-gateway-id $igw
  done

  # Delete NAT Gateways
  nat_gws=$(aws ec2 describe-nat-gateways --filter Name=vpc-id,Values=$vpc_id --query "NatGateways[].NatGatewayId" --output text)
  for nat_gw in $nat_gws; do
    echo "Deleting NAT Gateway: $nat_gw"
    aws ec2 delete-nat-gateway --nat-gateway-id $nat_gw
  done

  # Delete Subnets
  subnets=$(aws ec2 describe-subnets --filters Name=vpc-id,Values=$vpc_id --query "Subnets[].SubnetId" --output text)
  for subnet in $subnets; do
    echo "Deleting Subnet: $subnet"
    aws ec2 delete-subnet --subnet-id $subnet
  done

  # Delete Route Tables (excluding the main route table)
  route_tables=$(aws ec2 describe-route-tables --filters Name=vpc-id,Values=$vpc_id --query "RouteTables[?Associations[?Main==`false`]].RouteTableId" --output text)
  for rt in $route_tables; do
    echo "Deleting Route Table: $rt"
    aws ec2 delete-route-table --route-table-id $rt
  done

  # Delete VPC Peering Connections
  peering_connections=$(aws ec2 describe-vpc-peering-connections --filters Name=requester-vpc-info.vpc-id,Values=$vpc_id --query "VpcPeeringConnections[].VpcPeeringConnectionId" --output text)
  for peering in $peering_connections; do
    echo "Deleting VPC Peering Connection: $peering"
    aws ec2 delete-vpc-peering-connection --vpc-peering-connection-id $peering
  done

  # Finally, delete the VPC
  echo "Deleting VPC: $vpc_id"
  aws ec2 delete-vpc --vpc-id $vpc_id
}

# Delete all VPCs
vpcs=$(aws ec2 describe-vpcs --query "Vpcs[].VpcId" --output text)
for vpc in $vpcs; do
  delete_vpc_resources $vpc
done
