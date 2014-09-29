{% from 'libsodium.sls' import libsodium with context %}

include:
  - python.pip
  - libsodium

libnacl:
  pip.installed:
    {%- if salt['config.get']('virtualenv_path', None)  %}
    - bin_env: {{ salt['config.get']('virtualenv_path') }}
    {%- endif %}
    - index_url: https://pypi-jenkins.saltstack.com/jenkins/develop
    - extra_index_url: https://pypi.python.org/simple
    - require:
      - cmd: python-pip
      - pkg: {{ libsodium }}

