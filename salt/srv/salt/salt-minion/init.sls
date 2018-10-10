salt_minion:
  pkg.installed:
    - name: salt-minion

salt_minion:
  service.running:
    - name: salt-minion
    - enable: True
    - running: True
    - require:
      - pkg: salt-minion
