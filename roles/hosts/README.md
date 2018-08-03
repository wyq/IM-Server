hosts-deploy
=========
Deploy **```inventory hosts```** to **``/etc/hosts``**.

Requirements
------------

None.

Role Variables
--------------
	
	# defaults/main.yml
	# the group name, which you want to deploy the hosts 
	# included by the group.
	GROUP_NAME: all

Dependencies
------------

None

Example
----------------

+ Assuming your **``inventory``** like:

		proxy
		[all:children]
		webserver
		dbserver
			
		[webserver]
		web01 ansible_ssh_host=192.168.100.101
		web02 ansible_ssh_host=192.168.100.102
			
		[dbserver]
		db01 ansible_ssh_host=10.1.1.20
		db02 ansible_ssh_host=10.1.1.21

+ The **``Playbook``** like:

		- hosts: proxy
		  roles:
		     - { role: ihaolin.hosts-deploy, GROUP_NAME: 'webserver' }

+  The result to the **``proxy``**'s **``/etc/hosts``** appended: 

		192.168.100.101 web01 
		192.168.100.102 web02

License
-------

MIT

Author Information
------------------

[haolin.h0@gmail.com](mailto:haolin.h0@gmail.com)