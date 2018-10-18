base:
  '*':
   - networking-prerequisites
   - repos
  'salt-master*':
    - deepsea-master
  'salt-minion*':
    - salt-minion
