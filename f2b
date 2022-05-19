#Can't find why the firewall blocked your IP?

f2b(){
    clear;
    #see https://api.docs.cpanel.net/openapi/whm/operation/flush_cphulk_login_history_for_ips/
    echo -e "\n Cphulk Firewall"
    whmapi1 flush_cphulk_login_history_for_ips ip="$1"
    /scripts/cphulkdwhitelist "$1"
    echo -e "\n APF/CSF"
    [ -f /etc/csf/csf.conf ] && csf -a "$1" || apf -a "$1"
    #fail2ban log
    echo -e "\n Fail2ban"
    tail -n2 /var/log/fail2ban.log | grep "$1"
    # ssh/FTP logs
    echo -e "\n SSH/FTP"
    grep $1 /var/log/messages | tail -n2
    grep $1 /var/log/secure | tail -n2
    #mail client login fails
    #LFD blocks
    echo -e "\n LFD Logs"
    grep $1 /var/log/lfd.log| tail -n2
    echo -e "\n Failed Email Logins"
    grep "$1" /var/log/maillog | grep 'auth failed' | tail -n2| awk {'print $1,$2,$3,$5,$10,$11,$12,$13,$14 $15'}
    
    #failing exim
    echo -e "\n Failed Exim Authentication"
    grep "$1" /var/log/exim_mainlog | grep 'authenticator failed' | tail -n2  | awk  {'print $1,$2,$4,$5,$6,$9,$15'}
 
    #Modsec blocks
    echo -e "\n ModSecurity blocks"
    grep "$1" /usr/local/apache/logs/error_log | grep -E 'id "(13052|13051|13504|90334)"' | tail -n2

    #cPanel blocks
    echo -e "\n Cpanel Login Failures"
     grep "$1" /usr/local/cpanel/logs/login_log | grep "FAILED LOGIN" | tail -n2 | awk {'print $1,$2,$3,$5,$6,$8,$14,$15,$16,$17'}

     #imunify blocks

     echo -e "\n Whitelisting in Imunify"
    imunify360-agent whitelist ip add $1

    #iptables
    echo -e "\n Whitelisting in iptables"
    iptables -A INPUT -s $1 -j ACCEPT

    #apf/csf logs, requires root
   echo -e "\n CSF/APF Deny/Allow Rules"
   grep "$1" /etc/*/*allow* /etc/*/*deny*| tail -n2
    }

