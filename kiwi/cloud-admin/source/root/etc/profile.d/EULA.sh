#!/bin/bash

if [ ! -e $HOME/.eula-accepted ]; then
  LICENSE_FILE=/etc/YaST2/licenses/SUSE-Beta-EULA-020314.txt

  # Code stolen from
  # https://github.com/SUSE/studio/blob/master/kiwi-job/templates/SLES11_SP3/root/etc/init.d/suse_studio_firstboot.in
  stty -nl ixon ignbrk -brkint

  if [ `uname -m` == "s390x" ]; then
    cat $LICENSE_FILE
  else
    less $LICENSE_FILE 2>/dev/null || more $LICENSE_FILE 2>/dev/null || cat $LICENSE_FILE
  fi

  until [ "$answer" == "y" ] || [ "$answer" == "Y" ];
  do
    echo -n "Do you accept the EULA? [y/N] "
    read -e answer
    if [ "$answer" == "n" ] || [ "$answer" == "N" ]; then
      sudo halt
    fi
  done

  touch $HOME/.eula-accepted
fi 