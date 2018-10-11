{% if grains['os'] == 'SUSE' %}

{% if grains['osrelease'] == '42.3' %}
os_pool_repo:
  file.managed:
    - name: /etc/zypp/repos.d/openSUSE-Leap-42.3-Pool.repo
    - source: salt://repos/repos.d/openSUSE-Leap-42.3-Pool.repo
    - template: jinja

os_update_repo:
  file.managed:
    - name: /etc/zypp/repos.d/openSUSE-Leap-42.3-Update.repo
    - source: salt://repos/repos.d/openSUSE-Leap-42.3-Update.repo
    - template: jinja
{% endif %} {# grains['osrelease'] == '42.3' #}


{% if grains['osrelease'] == '11.4' %}

os_pool_repo:
  file.managed:
    - name: /etc/zypp/repos.d/SLE-11-SP4-x86_64-Pool.repo
    - source: salt://repos/repos.d/SLE-11-SP4-x86_64-Pool.repo
    - template: jinja

os_update_repo:
  file.managed:
    - name: /etc/zypp/repos.d/SLE-11-SP4-x86_64-Update.repo
    - source: salt://repos/repos.d/SLE-11-SP4-x86_64-Update.repo
    - template: jinja

{% endif %} {# grains['osrelease'] == '11.4' #}


{% if '12' in grains['osrelease'] %}
{% if grains['osrelease'] == '12' %}
os_pool_repo:
  file.managed:
    - name: /etc/zypp/repos.d/SLE-12-x86_64-Pool.repo
    - source: salt://repos/repos.d/SLE-12-x86_64-Pool.repo
    - template: jinja

os_update_repo:
  file.managed:
    - name: /etc/zypp/repos.d/SLE-12-x86_64-Update.repo
    - source: salt://repos/repos.d/SLE-12-x86_64-Update.repo
    - template: jinja

{% elif grains['osrelease'] == '12.1' %}

os_pool_repo:
  file.managed:
    - name: /etc/zypp/repos.d/SLE-12-SP1-x86_64-Pool.repo
    - source: salt://repos/repos.d/SLE-12-SP1-x86_64-Pool.repo
    - template: jinja

os_update_repo:
  file.managed:
    - name: /etc/zypp/repos.d/SLE-12-SP1-x86_64-Update.repo
    - source: salt://repos/repos.d/SLE-12-SP1-x86_64-Update.repo
    - template: jinja

{% elif grains['osrelease'] == '12.2' %}

os_pool_repo:
  file.managed:
    - name: /etc/zypp/repos.d/SLE-12-SP2-x86_64-Pool.repo
    - source: salt://repos/repos.d/SLE-12-SP2-x86_64-Pool.repo
    - template: jinja

os_update_repo:
  file.managed:
    - name: /etc/zypp/repos.d/SLE-12-SP2-x86_64-Update.repo
    - source: salt://repos/repos.d/SLE-12-SP2-x86_64-Update.repo
    - template: jinja

{% elif grains['osrelease'] == '12.3' %}

os_pool_repo:
  file.managed:
    - name: /etc/zypp/repos.d/SLE-12-SP3-x86_64-Pool.repo
    - source: salt://repos/repos.d/SLE-12-SP3-x86_64-Pool.repo
    - template: jinja

os_update_repo:
  file.managed:
    - name: /etc/zypp/repos.d/SLE-12-SP3-x86_64-Update.repo
    - source: salt://repos/repos.d/SLE-12-SP3-x86_64-Update.repo
    - template: jinja

{% endif %}

{% endif %} {# '12' in grains['osrelease'] #}


{% if '15' in grains['osrelease'] %}
os_pool_repo:
  file.managed:
    - name: /etc/zypp/repos.d/SLE-15-x86_64-Pool.repo
    - source: salt://repos/repos.d/SLE-15-x86_64-Pool.repo
    - template: jinja

os_update_repo:
  file.managed:
    - name: /etc/zypp/repos.d/SLE-15-x86_64-Update.repo
    - source: salt://repos/repos.d/SLE-15-x86_64-Update.repo
    - template: jinja

{% endif %} {# '15' in grains['osrelease'] #}


allow_vendor_changes:
  {% if grains['osfullname'] == 'Leap' %}
  file.managed:
    - name: /etc/zypp/vendors.d/opensuse
    - makedirs: True
    - contents: |
        [main]
        vendors = openSUSE,openSUSE Build Service,obs://build.suse.de/Devel:Galaxy,obs://build.opensuse.org
  {% else %}
  file.managed:
    - name: /etc/zypp/vendors.d/suse
    - makedirs: True
    - contents: |
        [main]
        vendors = SUSE,openSUSE Build Service,obs://build.suse.de/Devel:Galaxy,obs://build.opensuse.org
  {% endif %}


{% endif %}

# HACK: work around #10852
{{ sls }}_nop:
  test.nop: []
