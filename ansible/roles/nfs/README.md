Role Name
=========

NFS

A role to install NFS utilities, mount NFS shares, and ensure NFS client service is running on Debian and RedHat based servers.

Requirements
------------

- Add mount points to `global_vars/all.yml`, but ensure that the directories exist on the NAS first.

Role Variables
--------------

The role requires the following variables to be defined:
- `default_nfs_mount`: The default NFS mount point.
- `default_mount_points`: List of default mount points to be created.
- `default_user`: The default user for ownership of mounted directories.
- `inventory_hostname`: The hostname of the target server.

Dependencies
------------

No dependencies required.

Example Playbook
----------------

Including an example of how to use the role:

    - hosts: servers
      roles:
         - nfs

This will execute the NFS tasks on the servers.
