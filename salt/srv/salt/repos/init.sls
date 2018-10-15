include:
  - repos.default

{% if grains['os'] == 'SUSE' %}

refresh_openSUSE-repos:
  cmd.run:
    - name: zypper --non-interactive --gpg-auto-import-keys refresh
    - require:
      - sls: repos.default

{% endif %}
