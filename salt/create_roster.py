#! /usr/bin/python

# this simple script take the hosts.txt files and convert the ip dinamically to salt-ssh roster.
# this is a workaround until https://github.com/MalloZup/ceph-open-terrarium/issues/7

ips = [12, 34, 45, 69, 12]
roster_file = "etc/salt/roster"
with open(roster_file, 'a') as roster:
    # take first as master
    writeSaltMasterEntry(roster, ips.pop)
    for ip in ips:
        writeSaltMinionEntry(roster, ip)
def writeSaltMasterEntry(rosterFile, ip):
    rosterFile.write(" salt-master:" + '\n')
    rosterFile.write("   user: root" + ip + '\n')
    rosterFile.write("   host:" + ip + '\n')
