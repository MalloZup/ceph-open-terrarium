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


hosts_file:
  cmd.script:
    - name: salt://networking-prerequisites/set_ip_in_etc_hosts.py.jinja
    - args: "{{ grains['id'] }}"
    - template: jinja
    - context:
    {% if grains.get('osmajorrelease', None)|int() == 15 %}
      pythonexec: python3
    {% else %}
      pythonexec: python
{% endif %}


hosts_ips:
  file.append:
    - name: /etc/hosts
    - text: 
      # do for loop and get name
      #     {{  }} : {{ pillar['minions_ips']}}
      {% for minion_name, minion_ip in pillar.get('salt-minions', {}).items() %}
      {{ minion_name }} {{ minion_ip }}
      {% endfor %}
    - require:
      - pkg: salt-minion
