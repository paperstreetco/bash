#Wordpress site cloner. only arguement required is the destination document root and clone name. Can only be run within single user

wp_clone()
{
site_backup=$(basename "$PWD").$(date -I).tar.gz
db_backup=$(awk -F"'" '/DB_NAME/{print $4}' wp-config.php).$(date -I).sql
db_pass=$(awk -F"'" '/DB_PASSWORD/{print $4}' wp-config.php)
db_name=$(awk -F"'" '/DB_NAME/{print $4}' wp-config.php)
db_user=$(awk -F"'" '/DB_USER/{print $4}' wp-config.php)
##test if WP install
if test -f wp-config.php;
then
read -rp "What will be the name of the cloned site? and it's destination document root? " destination_name destination_root
##test if destination directory exists
if [ -d "$destination_root" ]
then
      echo  "$destination_root exists"
else
      echo  "$destination_root does NOT exist" ; return 1
fi

echo "backing up database to $db_backup and $site_backup"
     mysqldump -p"$db_pass" -u "$db_user" "$db_name" > "$db_backup"
 echo "zipping up $(pwd)"
 tar -caf "$site_backup" *
  echo "zipping up $destination_root"
      tar -caf ~/$destination_name.$(date -I).tar.gz $destination_root
echo "copying everything over to $destination_root"
rsync -azvP "$site_backup" "$destination_root"
cd "$destination_root" 
tar -xvf "$site_backup"
       mv -f "$site_backup" ~/
##Create databases

(
new_user="$(echo $(whoami)_$(tr -dc a-za </dev/urandom | head -c 5))"
new_pass="$(date | md5sum | awk {'print $1'})"
uapi Mysql create_database name="${new_user}"
uapi Mysql create_user name="${new_user}" password="${new_pass}" && uapi Mysql set_privileges_on_database user="${new_user}" database="${new_user}" privileges='ALL PRIVILEGES'

	 
##recreate wp-config
  mv -vf wp-config.php{,.bak_$(date +%F)}
wp config create --dbuser="${new_user}" --dbpass="${new_pass}" --dbname="${new_user}"
  
  #import db
mysql -p"$(awk -F"'" '/DB_PASSWORD/{print $4}' wp-config.php)" -u "$(awk -F"'" '/DB_USER/{print $4}' wp-config.php)" "$(awk -F"'" '/DB_NAME/{print $4}' wp-config.php)" < "$db_backup"

##create wordpress .htaccess file

cat << EOF > .htaccess
# BEGIN WordPress

RewriteEngine On
RewriteRule .* - [E=HTTP_AUTHORIZATION:%{HTTP:Authorization}]
RewriteBase /
RewriteRule ^index\.php$ - [L]
RewriteCond %{REQUEST_FILENAME} !-f
RewriteCond %{REQUEST_FILENAME} !-d
RewriteRule . /index.php [L]

# END WordPress
EOF


#update site home/urls

wp option update siteurl https://$destination_name --skip-{plugins,themes}
wp option update home https://$destination_name --skip-{plugins,themes}
  wp option get siteurl --skip-{plugins,themes}
  wp option get home  --skip-{plugins,themes}


)
else
   echo "This is NOT a Wordpress install"
fi
}

