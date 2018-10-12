include:
  - repos

salt-minion-pkg:
  pkg.installed:
    - name: salt-minion
    - cmd: repos.refresh_repos

salt-minion-service:
  service.running:
    - name: salt-minion
    - enable: True
    - running: True
    - require:
      - pkg: salt-minion-pkg
