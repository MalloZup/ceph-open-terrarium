#!/usr/bin/python
"""
This simple script takes the hosts.txt file and converts the ips dynamically to salt-ssh roster.
This is a workaround until https://github.com/MalloZup/ceph-open-terrarium/issues/7 is closed.
There is not much need to make it better since it will removed.
"""
import os
import sys

DEFAULT_ROSTER_FILE = "etc/salt/roster"
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

    # create dynamic roster
    with open(DEFAULT_ROSTER_FILE, "a") as roster:
        # take first as master
        write_salt_master_entry(roster, ips.pop())
        for minion_number, host in enumerate(ips):
            write_salt_minion_entry(roster, host, minion_number + 1)

    # remove host file (don't needed anymore)
    if os.path.exists(TERRAFORM_HOSTS_FILE):
        os.remove(TERRAFORM_HOSTS_FILE)


if __name__ == "__main__":
    main()
