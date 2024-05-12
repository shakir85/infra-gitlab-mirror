Role Name
=========

Gitlab Runner

A role for downloading and installing GitLab Runner instances on Debian hosts. 

Requirements
------------

None.

Role Variables
--------------

The role requires the following variables, which are included in the `defaults/main.yml`:

- `gitlab_deb_pkg_url`: The URL to download the GitLab Runner Debian package.
- `gitlab_deb_pkg_name`: The name of the GitLab Runner Debian package.
- `gitlab_deb_pkg_sha`: The SHA256 checksum of the GitLab Runner Debian package.

Dependencies
------------

No dependencies required.

Example Playbook
----------------

Including an example of how to use the role:

    - hosts: servers
      roles:
         - gitlab-install-runner
