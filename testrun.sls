{% from '_python.sls' import python with context %}
{% import 'git/salt.sls' as gitsalt with context %}

include:
  - git.salt

test_cmd:
{%- if 'runtests.run' in salt %}
  runtests.run:
{%- else %}
  cmd.run:
{%- endif %}
    - name: '{{ python }} /testing/tests/runtests.py -v --run-destructive --sysinfo --no-colors --xml=/tmp/xml-unitests-output --coverage-xml=/tmp/coverage.xml; code=$?; echo "Test Suite Exit Code: ${code}";'
    - order: last
    - require:
      - git: {{ gitsalt.git_url }}
    {%- if gitsalt.git_url != "https://github.com/saltstack/salt.git" %}
      - cmd: fetch-upstream-tags
    {%- endif %}
    - env:
      - XML_TESTS_OUTPUT_DIR: /tmp/xml-unitests-output
