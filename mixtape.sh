#!/bin/bash

dir_is_railsroot() {
  checkdir=$1

  match_counter=0
  for entry in $checkdir/*; do
    if [ -d "$entry" ]; then
      dir=`basename "$entry"`
      for rails_entry in "${RAILS_ENTRIES[@]}"; do
        if [ $dir = $rails_entry ]; then 
          match_counter=$(expr $match_counter + 1)
        fi
      done
    fi
  done

  if [ $match_counter -lt ${#RAILS_ENTRIES[@]} ]; then
    return 1
  else
    return 0
  fi

}

DIR=`pwd`

while [ "$DIR" != "/" ]; do

  dir_is_railsroot "$DIR"

  if [ "$?" -eq "0" ]; then
    cd "$DIR"
  fi

  DIR=`dirname $DIR`

done

case $1 in
  '')
    ;;
  'models')      cd 'app/models' 
    ;;
  'controllers') cd 'app/controllers' 
    ;;
  'helpers')     cd 'app/helpers' 
    ;;
  'views')       cd 'app/views' 
    ;;
  'layouts')     cd 'app/views/layouts'
    ;;
  'migrate')     cd 'db/migrate' 
    ;;
  'gems')        cd 'vendor/gems' 
    ;;
  'plugins')     cd 'vendor/plugins' 
    ;;
  *) cd "$1"
esac

return 0
