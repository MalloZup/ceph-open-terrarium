include:
  - suse-repos

master_minions_pillar:
  file.managed:
    - name: /srv/pillar/ceph/deepsea_minions.sls
    - source: salt://deepsea-master/deepsea_minion.sls
    - require:
      - pkg: deepsea_packages

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
