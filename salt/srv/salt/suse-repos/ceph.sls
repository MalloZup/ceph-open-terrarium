
ses5_pool_repo:
  file.managed:
    - name: /etc/zypp/repos.d/SES-5-x86_64-Pool.repo
    - source: salt://repos/repos.d/SES-5-x86_64-Pool.repo

ses5_update_repo:
  file.managed:
    - name: /etc/zypp/repos.d/SES-5-x86_64-Update.repo
    - source: salt://repos/repos.d/SES-5-x86_64-Update.repo
