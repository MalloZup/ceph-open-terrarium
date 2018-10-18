include:
  - suse-repos.default
  - suse-repos.ceph
# openSUSE/SUSE distro like

refresh_openSUSE-repos:
  cmd.run:
    - name: zypper --non-interactive --gpg-auto-import-keys refresh
    - require:
      - sls: suse-repos.default
