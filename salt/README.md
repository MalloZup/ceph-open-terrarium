# Saltstack provisioning ceph

This dir will contain mainly salt-ssh roster and salt-states for setting up the salt cluster needed by Deepsea.



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

After this you should be able to run deepsea.

# Deepsea:

For infos about Deepsea have a look at upstream doc:

 https://github.com/SUSE/DeepSea


### Usefull commands
Here some example basic what you can do with deepsea:

get the adress ip of salt-master with:
```bash
 salt-ssh -H
```

Then login on the `salt-master` and run

```bash
salt-run state.orch ceph.stage.0
```
