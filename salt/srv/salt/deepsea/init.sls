include:
  - repos

ses5_pool_repo:
  file.managed:
    - name: /etc/zypp/repos.d/SES-5-x86_64-Pool.repo
    - source: salt://repos/repos.d/SES-5-x86_64-Pool.repo
    - require:
      - sls: default

ses5_update_repo:
  file.managed:
    - name: /etc/zypp/repos.d/SES-5-x86_64-Update.repo
    - source: salt://repos/repos.d/SES-5-x86_64-Update.repo
    - require:
      - sls: default

deepsea_packages:
  pkg.latest:
    - pkgs:
      - deepsea
      - gptfdisk
   - require:
      - sls: ses5_pool_repo
      - sls: ses5_update_repo

create_proposal_folder:
  file.directory:
    - name: /srv/pillar/ceph/proposals/
    - user: salt
    - group: salt
    - makedirs: True

deepsea-policy:
  service.disabled:
    - name: apparmor
  file.managed:
    - name: /srv/pillar/ceph/proposals/policy.cfg
    - source: salt://deepsea/policy.cfg
    - require:
      - file: create_proposal_folder
