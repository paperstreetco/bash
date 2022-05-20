#The purpose of this is to automate dumping databases from common CMS's

#Wordpress ✓ Prestashop ✓ Joomla ✓ #Joomla coming soon™ #Moodle coming soon™ #Drupal coming soon™ #Laravel coming soon™





  (
##universal database dumper
#Wordpress DB creds
  wp_db_backup=$(awk -F"'" '/DB_NAME/{print $4}' wp-config.php).$(date -I).sql
  wp_db_pass=$(awk -F"'" '/DB_PASSWORD/{print $4}' wp-config.php)
  wp_db_name=$(awk -F"'" '/DB_NAME/{print $4}' wp-config.php)
  wp_db_user=$(awk -F"'" '/DB_USER/{print $4}' wp-config.php)
#Prestashop DB creds

ps_db_backup=$(awk -F"'" '/DB_NAME/{print $4}' config/settings.inc.php).$(whoami).$(date +%F).sql"
ps_db_pass=$(awk -F"'" '/DB_PASSWD_/{print $4}' config/settings.inc.php)"
ps_db_name=$(awk -F"'" '/DB_NAME/{print $4}' config/settings.inc.php)
ps_db_user=$(awk -F"'" '/DB_USER/{print $4}' config/settings.inc.php)

  #Joomla DB creds
jl_db_backup=$(grep  'public $db = ' configuration.php | awk {'print $4'} | tr -d "';").$(date -I).sql
jl_db_user=$(grep  'public $user = ' configuration.php | awk {'print $4'} | tr -d "';")
jl_db_pass=$(grep  'public $password = ' configuration.php | awk {'print $4'} | tr -d "';")
jl_db_name=$(grep  'public $db = ' configuration.php | awk {'print $4'} | tr -d "';")

#subshells

presta_dump()
{
  echo "This is Prestashop $(awk -F"'" '/PS_VERSION/{print $4}' config/settings.inc.php)"
  echo "backing up database to ~/$ps_db_backup"
  mysqldump -p"$ps_db_pass" -u "$ps_db_user" "$ps_db_name" > ~/"$ps_db_backup"
}

joomla_dump()
   {
  clear
  echo "This is a Joomla install"
  echo "backing up database to ~/$jl_db_backup"
  mysqldump -p"$jl_db_pass" -u "$jl_db_user" "$jl_db_name" > ~/"$jl_db_backup"
   }

wordpress_dump()
{
  clear
  echo "This is a Wordpress site"
  echo "backing up database to ~/$wp_db_backup"
  mysqldump -p"$wp_db_pass" -u "$wp_db_user" "$wp_db_name" > ~/"$wp_db_backup"
   tar -caf ~/$(wp option get home | tr -d https://).$(date -I).tar.gz . ~/$wp_db_backup
}

no_dbs()
{
  echo -e "databases currently in $(whoami) \n$(uapi  Mysql list_databases | grep database:| awk {'print $2'}) "
  echo "any conf files in $(pwd) that have DB configs?"
  grep --include='*.php' -lR "$(whoami)_"
}

clear
##test if WP install
  if test -f wp-config.php;
  then wordpress_dump
    
##test if Prestashop install
      elif test -f "config/settings.inc.php"; then  presta_dump
     
##Test if Joomla install
 elif test -f "configuration.php"; then 
       joomla_dump
       else 
       no_dbs
       fi
)


