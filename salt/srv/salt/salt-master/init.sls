salt_master:
  pkg.installed:
    - name: salt-master

salt-master:
  service.running:
    - name: salt-master
    - enable: True
    - running: True
    - require:
      - pkg: salt-master


salt_master_configuration:
  file.managed:
    - name: /etc/salt/master
    - source: salt://salt-master/master.conf
    - require:
	- pkg: salt-master
