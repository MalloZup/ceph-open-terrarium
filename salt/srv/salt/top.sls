base:
  '*':
   - networking-prerequisites
   - suse-repos
  'salt-master*':
    - deepsea-master
  'salt-minion*':
    - salt-minion
