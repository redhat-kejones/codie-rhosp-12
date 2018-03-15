#!/usr/bin/env bash

cd /home/stack/
source /home/stack/stackrc

# NOT IN USE
#  -e /usr/share/openstack-tripleo-heat-templates/environments/ceph-ansible/ceph-ansible.yaml \
#  -e /home/stack/templates/ceph-custom-config.yaml \
#  -e /home/stack/templates/storage-environment.yaml \
#  -e /home/stack/templates/controller-post-env.yaml \

time openstack overcloud deploy --templates \
  -e /home/stack/templates/node-info.yaml\
  -e /home/stack/templates/overcloud_images.yaml \
  -e /usr/share/openstack-tripleo-heat-templates/environments/network-isolation.yaml \
  -e /home/stack/templates/network-environment.yaml \
  -e /home/stack/templates/firstboot-environment.yaml \
  --ntp-server time.google.com \
  --timeout 60

if [ -e /home/stack/overcloudrc ]
then
  echo "overcloudrc file exists, now configuring a few post configurations"
  unset OS_TENANT_NAME
  . /home/stack/overcloudPostConfig.sh
else
  echo "overcloudrc does not exist, post configs skipped"
  source ~/stackrc
fi

