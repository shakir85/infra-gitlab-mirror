Role Name
=========

Docker

A role to install Docker CE, Docker Compose, and related tools on Debian-based systems.

Requirements
------------

No specific requirements beyond a Debian-based operating system.

Role Variables
--------------

Variables for specifying Docker package versions are located in `defaults/main.yml`. These variables include:
- `docker_ce_version`: Version of Docker CE to install.
- `docker_ce_cli_version`: Version of Docker CE CLI to install.
- `containerd_version`: Version of Containerd to install.
- `docker_compose_version`: Version of Docker Compose to install.
- `docker_buildx_version`: Version of Docker Buildx to install.

Dependencies
------------

None.

Example Playbook
----------------

Including an example of how to use your role:

    - hosts: servers
      roles:
         - docker

This will install Docker CE, Docker Compose, and related tools with default versions specified in the role.
