#Scan for anonfox meddled contact emails + created emails, automaticaly removes the contact email entry and disables cpanel password resets

(
  modified=$(grep -EHl 'anonymousfox|smtpfox' /home*/*/.contactemail /home/*/.cpanel/contactinfo /home/*/etc/*/shadow /home/*/etc/*/passwd)
  clear
if  grep -EH 'anonymousfox|smtpfox' /home*/*/.contactemail /home/*/.cpanel/contactinfo /home/*/etc/*/shadow /home/*/etc/*/passwd; then
  echo -e "\n cPanel contact emails modified by AnonymousFox"
  echo 
  echo $modified
  sed -i.cleared '/anonymousfox/d' $modified
  sed -i.cleared '/smtpfox/d' $modified
  whmapi1  set_tweaksetting  key='resetpass' value=0
  for i in $( cat /etc/userdomains | awk {'print $2'} | grep -v nobody | uniq); do  uapi --user=$i Email list_pops |grep -E 'anonymousfox|smtpfox'; 
  done
  echo -e  "\nhttps://support.cpanel.net/hc/en-us/articles/360058051173-What-is-the-anonymousfox-address-on-my-system \nhttps://sucuri.net/guides/anonymousfox-hack-guide/"
else echo "No contact emails have been modified by AnonymousFox"
fi
)


