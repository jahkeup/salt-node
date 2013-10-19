{% from 'nodejs/map.jinja' import nodejs with context %}

nodejs-deps:
  pkg.installed:
    - pkgs:
      - build-essential
      - curl

nodejs-tarball:
  file.managed:
    - name: /usr/src/{{nodejs.src_file}}.tar.gz
    - source: {{nodejs.url}}
    - source_hash: {{nodejs.url_hash}}
    - require:
      - pkg: nodejs-deps
  cmd.wait:
    - cwd: /usr/src
    - name: tar zxf {{nodejs.src_file}}.tar.gz
    - watch:
      - file: nodejs-tarball

nodejs-build:
  cmd.wait:
    - cwd: {{nodejs.src_path}}
    - name: ./configure && make install
    - watch:
      - cmd: nodejs-tarball