include:
- networking-prerequisites.hostname

# In case of other distros feel free to expand the grains
{% if grains['os'] == 'SUSE' %}
disable_firewall:
  service.dead:
     - name: SuSEfirewall2
     - enable: False
{% endif %}
