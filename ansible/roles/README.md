# Ansible Roles

This directory contains Ansible roles for deploying HX-Citadel-Alpha components.

## Available Roles

### docker

Installs Docker CE (latest stable) with Docker Compose V2 plugin.

**Purpose**: Install and configure Docker Engine on target servers

**Components Installed**:
- **Docker Engine** (docker-ce) - Latest stable from Docker CE repository
- **Docker CLI** (docker-ce-cli) - Command-line interface
- **Containerd** (containerd.io) - Container runtime
- **Docker Compose V2** (docker-compose-plugin) - ⚠️ **Uses `docker compose`, NOT `docker-compose`**
- **BuildX Plugin** (docker-buildx-plugin) - Advanced build capabilities

**Key Features**:
- Installs from official Docker CE stable repository
- Automatically configures Docker group for specified users
- Disables host firewall per HX Platform policy
- Supports both Debian/Ubuntu and RHEL/CentOS
- Idempotent (safe to run multiple times)

**Variables**:
- `docker_users` - List of users to add to docker group (default: `["agent0"]`)
- `docker_manage_firewall` - Disable host firewall per HX policy (default: `true`)
- `docker_package_state` - Package state (default: `present`)
- `docker_service_state` - Service state (default: `started`)
- `docker_service_enabled` - Enable on boot (default: `true`)

**Usage**:
```yaml
# Example playbook
- hosts: all
  become: yes
  roles:
    - role: docker
      vars:
        docker_users:
          - agent0
```

**Version Information**: See `docker/VERSIONS.md` for complete version details

**Source**: Copied from hx-citadel-ansible project (production-tested on 17-server fleet)

**Documentation**:
- `docker/README.md` - Role usage and examples
- `docker/VERSIONS.md` - Detailed version information
- `docker/defaults/main.yml` - All configurable variables

## Planned Roles

Additional roles will be created as needed:

- **crawl4ai-agent** - Deploy original Crawl4AI Agent container (Spec 001)
- **citadel-alpha** - Deploy Citadel Alpha container with HX Platform integration (Spec 002)

## Role Development Guidelines

All roles in this repository follow these standards:

### Ansible Best Practices
- ✅ **FQCN Required**: Use fully qualified collection names (e.g., `ansible.builtin.apt`)
- ✅ **Idempotency**: Safe to run multiple times without unintended changes
- ✅ **Error Handling**: Use `block/rescue/always` for critical operations
- ✅ **Documentation**: Comprehensive README.md with usage examples
- ✅ **Variables**: All defaults documented in `defaults/main.yml`

### Code Quality
- ✅ **Linting**: Pass `ansible-lint` with no errors
- ✅ **Testing**: Include molecule tests where applicable
- ✅ **No Secrets**: Use Ansible Vault for sensitive data

### Documentation Requirements
Each role must include:
- `README.md` - Usage, examples, variables
- `defaults/main.yml` - Default variable values with comments
- `meta/main.yml` - Role metadata and dependencies

## Using Roles in Playbooks

### Method 1: Direct Role Reference
```yaml
- hosts: target_servers
  become: yes
  roles:
    - docker
```

### Method 2: Role with Variables
```yaml
- hosts: target_servers
  become: yes
  roles:
    - role: docker
      vars:
        docker_users:
          - agent0
          - developer
```

### Method 3: Import Role
```yaml
- hosts: target_servers
  become: yes
  tasks:
    - name: Install Docker
      ansible.builtin.import_role:
        name: docker
```

## Testing Roles

```bash
# Syntax check
ansible-playbook --syntax-check playbooks/install-docker.yml

# Lint check
ansible-lint roles/docker/

# Dry run (check mode)
ansible-playbook -i inventory/test-server.ini playbooks/install-docker.yml --check

# Run with diff to see changes
ansible-playbook -i inventory/test-server.ini playbooks/install-docker.yml --check --diff
```

## References

- **HX Platform Standards**: Follow patterns from hx-citadel-ansible project
- **Ansible Best Practices**: See `/projects/HX-Citadel-Alpha/CONSTITUTION.md`
- **FQCN Reference**: https://docs.ansible.com/ansible/latest/collections/index.html

---

**Last Updated**: 2025-10-15
**Roles Available**: 1 (docker)
**Source Repository**: https://github.com/hanax-ai/HX-Citadel-Alpha
