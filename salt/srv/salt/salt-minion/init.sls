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

salt-minion-pkg:
  pkg.installed:
    - name: salt-minion
    - require:
      - file: ses5_update_repo
      - file: ses5_pool_repo

salt-minion-service:
  service.running:
    - name: salt-minion
    - enable: True
    - running: True
    - require:
      - pkg: salt-minion-pkg

master_configuration:
  file.managed:
    - name: /etc/salt/minion.d/master.conf
    - contents: |
        master: {{ pillar['deepsea-master-ip']}}
    - require:
      - pkg: salt-minion
