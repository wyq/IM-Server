#sunrunos useage
###### mount
iso_path=/opt/iso
repo_port=8000

mkdir -p $iso_path
iso_files=`/usr/bin/ls $iso_path`
if [ ! -n "$iso_files" ]; then
  chown -R apache:apache $iso_path
   /usr/bin/mount /dev/cdrom  $iso_path
fi

cd $iso_path/Extra/mirrors/sunrunpaas/
nohup python -m SimpleHTTPServer ${repo_port} >/dev/null 2>&1 & echo $! > /var/run/yumrepo.pid


#########ip replace
local_ip=`/sbin/ifconfig -a|grep inet|grep -v 127.0.0.1|grep -v inet6|awk '{print $2}'|tr -d "addr:"`

if [ ! -n "$local_ip" ]; then  
  echo "Local IP isnot Set"  
else  
  /usr/bin/sed -i 's/ansible_ssh_host=.* ansible_user/ansible_ssh_host='${local_ip}' ansible_user/g' ./hosts
  /usr/bin/sed -i 's/127.0.0.1:8000/'${local_ip}':'${repo_port}'/g' `grep '127.0.0.1' -rl vars/`
 
fi 

########## firewalld set 
systemctl start  firewalld
firewall-cmd --zone=public --add-port=${repo_port}/tcp --permanent
systemctl restart  firewalld
