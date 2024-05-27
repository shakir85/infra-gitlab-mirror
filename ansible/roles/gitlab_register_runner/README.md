Role Name
=========

Gitlab Register Runner

**Needs gitlab-runner installed first**

A role for registering a GitLab Runner.

Requirements
------------

- Gitlab runner previously installed (see `roles/gitlab-install-runner`.)

To register a runner, you need two things:

1. Create a runner in your project (Gitlab UI) [follow the new Gitlab token registration process.](https://docs.gitlab.com/ee/architecture/blueprints/runner_tokens/index.html#using-the-authentication-token-in-place-of-the-registration-token)
2. Export the token as a shell environment variable: `RUNNER_TOKEN=glrt-XXXXXX`: (or you can use the Ansible flag `-e 'runner_token=XXXXX'` when executing the playbook.)

If the runner wasn't created in the UI, GitLab will interpret your runner token as invalid, resulting in the following error:
```
  stderr: |-
    Verifying runner... is not valid 
    PANIC: Failed to verify the runner.
```

Role Variables
--------------

The role requires the following variables, which are included in the `defaults/main.yml`:

- `runner_token`: GitLab runner token, starting with `glrt-`, exported as an environment variable (see requirements).
- `runner_description`: Description for the registered GitLab Runner. Please note that unlike the old registration method, the new runner registration method ignores this description flag, which is unfortunate. The description is only shown in the `config.toml` file.

Dependencies
------------

No dependencies required.

Example Playbook
----------------

Including an example of how to use the role:

    - hosts: servers
      roles:
         - gitlab-runner
