#!/usr/bin/env bash

pvdisplay | grep "/dev/sdb" >/dev/null 2>&1
if [ ${?} -eq 0 ];
  then
    echo "Not adding /dev/sdb to cinder-volumes again (it's already there!)"
  else
    pvcreate /dev/sdb

    vgextend cinder-volumes /dev/sdb
    vgreduce cinder-volumes /dev/loop2
fi
