include:
  - repos

ses5_pool_repo:
  file.managed:
    - name: /etc/zypp/repos.d/SES-5-x86_64-Pool.repo
    - source: salt://repos/repos.d/SES-5-x86_64-Pool.repo
  

ses5_update_repo:
  file.managed:
    - name: /etc/zypp/repos.d/SES-5-x86_64-Update.repo
    - source: salt://repos/repos.d/SES-5-x86_64-Update.repo
 

deepsea_packages:
  pkg.latest:
    - pkgs:
      - deepsea
      - gptfdisk
    - require:
      - file: ses5_pool_repo
      - file: ses5_update_repo

create_proposal_folder:
  file.directory:
    - name: /srv/pillar/ceph/proposals/
    - user: salt
    - group: salt
    - makedirs: True

deepsea_policy:
  service.disabled:
    - name: apparmor
  file.managed:
    - name: /srv/pillar/ceph/proposals/policy.cfg
    - source: salt://deepsea-master/policy.cfg
    - require:
      - file: create_proposal_folder

# salt-master configuration

salt-master:
  pkg.installed:
    - name: salt-master
    - require:
      - file: ses5_pool_repo
      - file: ses5_update_repo

salt-master-service:
  service.running:
    - name: salt-master
    - enable: True
    - running: True
    - require:
      - pkg: salt-master


salt_master_configuration:
  file.managed:
    - name: /etc/salt/master
    - source: salt://deepsea-master/master.conf
    - require:
       - pkg: salt-master
