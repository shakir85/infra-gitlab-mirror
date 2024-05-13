Role Name
=========

Gitlab Register Runner

**Needs gitlab-runner installed first**

A role configuring GitLab Runner instances on Debian hosts. 

Requirements
------------

- Gitlab runner previously installed (see `roles/gitlab-install-runner`)
- Ensure that the necessary dependencies for Gitlab Runner are met on the target host.

Two register a runner, you need two things:

1. Create a runner in your project (Gitlab UI) [follow the new Gitlab token registration process.](https://docs.gitlab.com/ee/architecture/blueprints/runner_tokens/index.html#using-the-authentication-token-in-place-of-the-registration-token)
2. Export the following shell environment variables:
   - `RUNNER_TOKEN`: Gitlab runner token provided from step 1 above. Or you can use `-e 'runner_token=XXXXX` when executing the playbook.
   - `GITLAB_API_TOKEN`: Gitlab API access token with `api` read/write scope. 

If the runner wasn't created in the UI, GitLab will interpret your runner token as an absolute token, resulting in the following error:
```
  stderr: |-
    Verifying runner... is not valid 
    PANIC: Failed to verify the runner.
```

Role Variables
--------------

The role requires the following variables, which are included in the `defaults/main.yml`:

- `gitlab_api_token`: The GitLab API token used for recycling runners, exported as an environment variable (see requirements).
- `runner_description`: Description for the registered GitLab Runner. Please note that unlike the old registration method, the new runner registration method ignores this description flag, which is unfortunate. The description is only shown in the `config.toml` file.
- `runner_token`: GitLab runner token, starting with `glrt-`, exported as an environment variable (see requirements).

Dependencies
------------

No dependencies required.

Example Playbook
----------------

Including an example of how to use the role:

    - hosts: servers
      roles:
         - gitlab-runner
