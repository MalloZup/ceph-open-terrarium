include:
  - repos.default

{% if grains['os'] == 'SUSE' %}

refresh_repos:
  cmd.run:
    - name: zypper --non-interactive --gpg-auto-import-keys refresh
    - require:
      - sls: repos.default

{% endif %}

# HACK: work around #10852
{{ sls }}_nop:
  test.nop: []
