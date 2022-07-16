job(){
    width=$((`tput cols`-`echo $1|wc -m`));
    offset=$(($width/2));
    col=1;while [ $col -lt $offset ];
    do echo -n " ";
        col=$(($col+1));
    done;
    echo -e "$1";
};
LargeFileLocator(){
    task(){
        echo "=> $1";
        echo;
    };
    check(){
        if [ -z $1 ];
        then dir=$(pwd);
        fi;
        if [ -d $1 ];
        then
            if [ `ls $1|wc -l` -gt 0 ];
            then cd $1;
                if [ -z `ls|grep -v "-"|du -h|grep '[0-9]G'|head -1|awk {'print $1'}` ];
                then echo -e "\tALL LOOKS GOOD IN HERE. ($1)";echo;
                else du -m --max-depth=3|sort -nr|cut -f2|tr \\n \\0|xargs -0 du -sh|sed 's/.\///'|grep -v '[0-9]M\|[0-9]K'|awk -v wd="$(pwd)" '{print wd"/"$2" "$1}'|sort|awk '{print "ATTENTION: "$2" found  ==>  "$1}'|sed 's/^/\t    /'|sed 's/\/\.//';
                    echo;
                fi;
            else echo -e "\tNOTHING FOUND IN HERE. ($1)";
                echo;
            fi;
        else echo -e "\tNOTHING FOUND HERE. ($1)";
        fi;
    };
    clear;
    echo;
    job "LARGE FILE/FOLDER LOCATOR";
    echo;
    job "`df -h|sed '1d'|grep -v "none\|udev\|tmp"|awk -v svr=$(hostname|cut -d\. -f1) '{print "Currently "$3"("$5") of "$2" used."}'`";
    job "`df -h|sed '1d'|grep -v "none\|udev\|tmp"|awk -v svr=$(hostname|cut -d\. -f1) '{print $4" of free space is left on "svr}'`";
    echo;
    echo;
    task "Checking for large orphaned files in home dir:";
    if [ -z `ls -lah /home |awk {'print $9'}|sed '1,3d'|grep -v "-"|grep -v "......[0-9]"|xargs -I {} du -smh "/home/"{}|grep -o '[0-9]G'|head -1` ];
    then echo -e "\tALL LOOKS NORMAL IN HERE. (/home)";
        echo;
    else check "/home"|grep -vw "`echo $(cat /etc/trueuserdomains|awk '{print "/home/"$2}')|sed -e '1,10s/ /.*$\\\|/g'`"|sed '/^.*home$/d';
    fi;
    task "Looking for large cPanel user folders:";
    for user in `cat /etc/trueuserdomains | awk '{print $2}'`;
    do
        if [ `du -ms "/home/"$user|cut -f1` -gt 1000 ];
        then echo -e "\tcPanel User $user seems pretty large...";
            check "/home/$user";
        fi;
    done;
    task "Checking for large standard log files:";
    check "/var/log";
    task "Looking for large mysql db's & logs:";
    check "/var/lib/mysql";
    task "Looking for large WHM (scheduled) backups:";
    check "/backup";
    echo;
};
st=`date +%s`;
LargeFileLocator;
et=`date +%s`;
job "DONE";
job "(Execution Time: `expr $et - $st`s)";
echo;