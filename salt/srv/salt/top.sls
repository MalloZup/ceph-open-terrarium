base:
  '*':
   - suse-repos
   - networking-prerequisites
  'salt-master*':
    - deepsea-master
    - salt-minion
  'salt-minion*':
    - salt-minion
