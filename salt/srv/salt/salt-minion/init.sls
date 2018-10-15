include:
  - repos

salt-minion-pkg:
  pkg.installed:
    - name: salt-minion

salt-minion-service:
  service.running:
    - name: salt-minion
    - enable: True
    - running: True
    - require:
      - pkg: salt-minion-pkg

# TODO: add grains for getting master ip and send the boostrap against this ip
