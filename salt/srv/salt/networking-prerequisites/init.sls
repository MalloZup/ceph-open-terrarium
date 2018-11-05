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

hosts_minions_ips:
  file.append:
    - name: /etc/hosts
    - text: 
      {% for minion_name, minion_ip in pillar.get('salt-minions', {}).items() %}
        {{ minion_ip }} {{ minion_name }}
      {% endfor %}
    - require:
      - pkg: salt-minion

hosts_master_ip:
  file.append:
    - name: /etc/hosts
    - text: 
        {{ salt['pillar.get']('deepsea-master-ip') }} salt-master
    - require:
      - pkg: salt-minion
      - file: hosts_minions_ips
