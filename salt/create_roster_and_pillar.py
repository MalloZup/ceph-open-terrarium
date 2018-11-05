#!/usr/bin/python
"""
This simple script takes the hosts.txt file and converts the ips dynamically to salt-ssh roster.
This is a workaround until https://github.com/MalloZup/ceph-open-terrarium/issues/7 is closed.
There is not much need to make it better since it will removed.
"""
import os
import sys

DEFAULT_ROSTER_FILE = "etc/salt/roster"
DEFAULT_MASTER_PILLAR_FILE = "srv/pillar/master_ip.sls"
DEFAULT_MINION_PILLAR_FILE = "srv/pillar/salt-minions.sls"
TERRAFORM_HOSTS_FILE = "../hosts.txt"


def read_ip_from_terraform(host_file):
    """
    Opens the specified file by name and returns a list. Each element of the
    list corresponds to one line in the file. Newline characters are removed
    from each line of the file.

    :param host_file: the name of te file to open
    :return: a list of strings - each element is a line from the file
    """
    with open(host_file) as open_file:
        return open_file.read().splitlines()


def write_salt_master_entry(roster_file, host):
    """
    Writes a salt master entry to the specified roster file.

    :param roster_file: a file object to add the entry to
    :param host: the ip address or hostname of the salt master host
    """
    roster_file.write(" salt-master:\n")
    roster_file.write("   user: root\n")
    roster_file.write("   host: {}\n".format(host))


def write_salt_minion_entry(roster_file, host, minion_num):
    """
    Writes a salt minion entry to the specified roster file.

    :param roster_file: a file object to add the entry to
    :param host: the ip address or hostname of the salt minion
    :param minion_num: the minion number to add
    """
    roster_file.write(" salt-minion{}:\n".format(minion_num))
    roster_file.write("   user: root\n")
    roster_file.write("   host: {}\n".format(host))

def write_salt_minion_pillar_entry(pillar_file, host, minion_num):
    """
    Writes a salt minion entry to the specified roster file.

    :param pillar_file: a file object to add the entry to
    :param host: the ip address or hostname of the salt minion
    :param minion_num: the minion number to add
    """
    pillar_file.write(" salt-minion{0}: {1}\n".format(minion_num, host))


def write_pillar(pillar_file, master_ip):
    """
    Writes salt-master ip to pillar so that minion can write their minion.conf
    file with the salt-master ip
    """

    pillar_file.write("deepsea-master-ip: {}\n".format(master_ip))


def main():
    """
    Attempts to transcribe the contents of a host.txt file to a
    roster file. Once the host file contents have been transcribed,
    the old host file will be removed.

    :return: 1 if the file does not exist or is empty, 0 otherwise
    """
    # host.txt was deleted just exit
    if not os.path.exists(TERRAFORM_HOSTS_FILE):
        print "hosts.txt doesn't exist anymore."
        sys.exit(1)

    # read terraform ips
    if os.path.exists(DEFAULT_ROSTER_FILE):
        os.remove(DEFAULT_ROSTER_FILE)

    ips = read_ip_from_terraform(TERRAFORM_HOSTS_FILE)
    if not ips:
        print "hosts.txt empty"
        sys.exit(1)

    master_ip = ips.pop()
    # create dynamic pillar for master ip
    with open(DEFAULT_MASTER_PILLAR_FILE, "w") as master_pillar:
        write_pillar(master_pillar, master_ip)
    # create dynamic roster
    with open(DEFAULT_ROSTER_FILE, "a") as roster:
        # take first as master
        write_salt_master_entry(roster, master_ip)
        for minion_number, host in enumerate(ips):
            write_salt_minion_entry(roster, host, minion_number + 1)
    # create dyn pillar for minions ips
    with open(DEFAULT_MINION_PILLAR_FILE, "w") as pillar:
        pillar.write("salt-minions:\n")
        for minion_number, host in enumerate(ips):
            write_salt_minion_pillar_entry(pillar, host, minion_number + 1)

    # remove host file (don't needed anymore)
    if os.path.exists(TERRAFORM_HOSTS_FILE):
        os.remove(TERRAFORM_HOSTS_FILE)


if __name__ == "__main__":
    main()
