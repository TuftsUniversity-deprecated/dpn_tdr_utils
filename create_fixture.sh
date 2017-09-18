#!/bin/bash

#@file
# Creates a complete fixture for rspec from a pid.

# ---------- Vars ----------- #
fedora_user="fedoraAdmin"
fedora_url_prefix="http://repository01.lib.tufts.edu:8080/fedora/objects/"
fedora_url_suffix="/export?context=archive"
fedora_url=""

filename=""
clean_filename=""
final_filename=""


# ---------- Checks ----------- #
if [ -z "${1}" ]; then
  echo "You must supply a pid as an argument!"
  exit 1
else
  fedora_url="${fedora_url_prefix}${1}${fedora_url_suffix}"
  filename="${1}.xml"
  clean_filename="${1}.edit.xml"
  final_filename="${1}.foxml.xml"
fi


# ---------- Procedure ----------- #
curl -u fedoraAdmin ${fedora_url} > ${filename}
ruby clean_up_exported_objects.rb ${filename}

if [ -f ${clean_filename} ]; then
  mv ${clean_filename} ${final_filename}
else
  echo "Sorry, something appears to have gone wrong. Check your pid."
fi

rm ${filename}

