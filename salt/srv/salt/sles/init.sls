include:
  - sles.repos

setup-machine-id:
  cmd.run:
    - name: rm /etc/machine-id && systemd-machine-id-setup && touch /etc/machine-id-already-setup
    - creates: /etc/machine-id-already-setup
    - onlyif: systemd-machine-id-setup
