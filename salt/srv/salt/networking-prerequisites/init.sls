include:
- networking-prerequisites.hostname
- suse-repos

# In case of other distros feel free to expand the grains
{% if grains['os'] == 'SUSE' %}
disable_firewall:
  service.dead:
     - name: SuSEfirewall2
     - enable: False
{% endif %}

ntp_package:
  pkg.installed:
    - name: ntp

enable_ntpd:
  service.running:
    - name: ntpd
    - enable: True
    - running: True
    - require:
      - pkg: ntp_package
