#!/usr/bin/env bash
###########################################################################
##                     Copyright (C) 2019 wystan
##
##       filename: ecs.sh
##    description:
##        created: 2019-07-01 23:36:25
##         author: wystan
##
###########################################################################


function ali.ecs() {
    curl -s -m2 http://100.100.100.200/2016-01-01/meta-data/$1
    echo ""
}
function ali.ecs.ipv4.private() {
    ali.ecs private-ipv4
}
function ali.ecs.ipv4.public() {
    ali.ecs eipv4
}
function ali.ecs.region() {
    ali.ecs region-id
}
function ali.ecs.instance.id() {
    ali.ecs instance-id
}
function ali.ecs.instance.type() {
    ali.ecs instance/instance-type
}
function ali.ecs.info() {
    ali.ecs.ipv4.public
    ali.ecs.ipv4.private
    ali.ecs.region
    ali.ecs.instance.id
    ali.ecs.instance.type
}
function ali.ecs.search.by.addr() {
    declare -a local regions=(
        "cn-shenzhen"
        "cn-shanghai"
        "cn-beijing"
        "ap-southeast-1"
        "eu-central-1"
        "us-west-1"
    )
    local cnt=0
    local result=""
    local ins_id=""
    local ins_type=""
    local eip=""
    local ip=""
    local pub_ip=""
    for one in ${regions[@]}
    do
        result=$(aliyun ecs DescribeInstances --$1 "['$2']" --RegionId $one)
        cnt=$(echo $result|jq ".TotalCount")
        if [[ $cnt -eq 0 ]]; then
            continue
        fi

        ins_id=$(echo $result|jq ".Instances.Instance[0].InstanceId"|tr -d '"')
        ins_type=$(echo $result|jq ".Instances.Instance[0].InstanceType"|tr -d '"')
        eip=$(echo $result|jq ".Instances.Instance[0].EipAddress.IpAddress"|tr -d '"')
        ip=$(echo $result|jq ".Instances.Instance[0].VpcAttributes.PrivateIpAddress.IpAddress[0]"|tr -d '"')
        pub_ip=$(echo $result|jq ".Instances.Instance[0].PublicIpAddress.IpAddress[0]"|tr -d '"')
        if [[ -z $eip ]]; then
            eip='null'
        fi
        echo $one $eip $ip $pub_ip $ins_id $ins_type
        break
    done
}
function ali.ecs.search.by.ip() {
    ali.ecs.search.by.addr PrivateIpAddresses $1
}
function ali.ecs.search.by.eip() {
    ali.ecs.search.by.addr EipAddresses $1
}
function ali.ecs.search.by.publicip() {
    ali.ecs.search.by.addr PublicIpAddresses $1
}

###########################################################################
