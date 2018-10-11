#! /usr/bin/python

# this simple script take the hosts.txt files and convert the ip dinamically to salt-ssh roster.
# this is a workaround until https://github.com/MalloZup/ceph-open-terrarium/issues/7
# there is no much need to make it better since it will removed.
import os
roster_file = "etc/salt/roster"
terraformHostsFile = "../hosts.txt"

def readIpfromTerraform(hostFile):
    with open(hostFile) as f:
        ips = f.read().splitlines()
    return ips

def writeSaltMasterEntry(rosterFile, iphost):
    rosterFile.write(" salt-master:" + '\n')
    rosterFile.write("   user: root" + '\n')
    rosterFile.write("   host: " + str(iphost) + '\n')


def writeSaltMinionEntry(rosterFile, iphost, minionNumber):
    rosterFile.write(" salt-minion"  + str(minionNumber)  + ': \n')
    rosterFile.write("   user: root" + '\n')
    rosterFile.write("   host: " + str(iphost) + '\n')

# host.txt was deleted just exit
if os.path.exists(terraformHostsFile):
  print("host.txt doesn't exist anymore.")
  sys.exit(1)

# read terraform ips
if os.path.exists(roster_file):
    os.remove(roster_file)

ips = readIpfromTerraform(terraformHostsFile)
if not ips:
  print("host.txt empty")
  sys.exit(1)

# create dinamic roster
with open(roster_file, 'a') as roster:
    # take first as master
    writeSaltMasterEntry(roster, ips.pop())
    minionNumber = 1
    for ip in ips:
        writeSaltMinionEntry(roster, ip, minionNumber)
        minionNumber += 1

# remove host file (don't needed anymore)
if os.path.exists(terraformHostsFile):
    os.remove(terraformHostsFile)
