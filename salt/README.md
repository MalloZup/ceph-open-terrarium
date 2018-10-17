# Saltstack provisioning ceph

This dir will contain mainly salt-ssh roster and salt-states for setting up the salt cluster needed by Deepsea.

For more info look at : https://github.com/SUSE/DeepSea


# install and running:

`zypper -n in salt-ssh python2-salt`


# Install ceph prerequisites:

```shell
create_roster_and_pillar.py
salt-ssh '*' state.highstate -i
```

You need to accept the key with

```bash
salt-ssh 'salt-master' cmd.run 'salt-key -A -y' -i
```

# Deepsea:


#### Usefull commands

```bash
salt-ssh '<MINION_ID>' state.highstate test=True
salt-ssh '<MINION_ID>' state.highstate
```
