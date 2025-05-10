#!/bin/bash

# system_report.sh
# Generates an HTML system information report.
# Author: Mahmoud Mohamed Moharam

PROGNAME=$(basename "$0")
TITLE="System Information Report for $HOSTNAME"
CURRENT_TIME=$(date +"%x %r %Z")
TIMESTAMP="Generated $CURRENT_TIME by $USER"

# Function to report system uptime
report_uptime() {
  echo "<H2>System Uptime</H2>"
  echo "<PRE>$(uptime)</PRE>"
}

# Function to report disk space usage
report_disk_space() {
  echo "<H2>Disk Space Utilization</H2>"
  echo "<PRE>$(df -h)</PRE>"
}

# Function to report home directory space usage
report_home_space() {
  if [[ $(id -u) -eq 0 ]]; then
    echo "<H2>Home Space Utilization (All Users)</H2>"
    echo "<PRE>$(du -sh /home/* 2>/dev/null)</PRE>"
  else
    echo "<H2>Home Space Utilization ($USER)</H2>"
    echo "<PRE>$(du -sh "$HOME" 2>/dev/null)</PRE>"
  fi
}

# Function to show usage
usage() {
  echo "$PROGNAME: usage: $PROGNAME [-f file | -i]"
}

# Function to write the HTML report
write_html_page() {
  cat <<- _EOF_
<HTML>
<HEAD>
  <TITLE>$TITLE</TITLE>
</HEAD>
<BODY>
  <H1>$TITLE</H1>
  <P>$TIMESTAMP</P>
  $(report_uptime)
  $(report_disk_space)
  $(report_home_space)
</BODY>
</HTML>
_EOF_
}

# Command line argument parsing
interactive=
filename=

while [[ -n $1 ]]; do
  case $1 in
    -f|--file)
      shift
      filename=$1
      ;;
    -i|--interactive)
      interactive=1
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      usage >&2
      exit 1
      ;;
  esac
  shift
done

# Interactive mode
if [[ -n $interactive ]]; then
  while true; do
    read -rp "Enter name of output file: " filename
    if [[ -e $filename ]]; then
      read -rp "'$filename' exists. Overwrite? [y/n/q] > " REPLY
      case $REPLY in
        [Yy]) break ;;
        [Qq]) echo "Program terminated."; exit ;;
        *) continue ;;
      esac
    else
      break
    fi
  done
fi

# Generate output
if [[ -n $filename ]]; then
  if touch "$filename" && [[ -f $filename ]]; then
    write_html_page > "$filename"
  else
    echo "$PROGNAME: Cannot write file '$filename'" >&2
    exit 1
  fi
else
  write_html_page
fi
