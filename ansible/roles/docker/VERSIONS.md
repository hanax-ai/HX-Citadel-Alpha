# Docker Role - Version Information

## Installed Components

This role installs the latest stable versions of Docker from the official Docker CE repository:

### Docker Engine
- **Package**: `docker-ce` (Docker Community Edition)
- **Source**: Official Docker CE stable repository
- **Version Strategy**: Latest stable (not pinned)
- **Architecture Support**: amd64, arm64, armhf, i386

### Docker CLI
- **Package**: `docker-ce-cli`
- **Purpose**: Command-line interface for Docker

### Container Runtime
- **Package**: `containerd.io`
- **Purpose**: Industry-standard container runtime

### Docker Compose V2
- **Package**: `docker-compose-plugin`
- **Command**: `docker compose` (note: **not** `docker-compose`)
- **Version**: V2 (plugin architecture)
- **Compatibility**: Fully compatible with V1 compose files

### BuildX Plugin
- **Package**: `docker-buildx-plugin`
- **Purpose**: Advanced build capabilities

## Version Verification

After installation, verify versions:

```bash
# Docker Engine
docker --version
# Expected: Docker version 24.x.x or later

# Docker Compose V2
docker compose version
# Expected: Docker Compose version v2.x.x or later

# Container runtime
containerd --version
# Expected: containerd.io version 1.6.x or later
```

## Docker Compose V2 vs V1

**Important**: This role installs Docker Compose V2 as a plugin.

**V2 Command** (installed):
```bash
docker compose up
docker compose down
```

**V1 Command** (deprecated, NOT installed):
```bash
docker-compose up     # Will not work
docker-compose down   # Will not work
```

All `docker-compose.yml` files are compatible with V2. Simply use `docker compose` instead of `docker-compose`.

## Repository Configuration

### Debian/Ubuntu
- **Repository**: `https://download.docker.com/linux/ubuntu` (or debian)
- **Distribution**: Matches host OS (`focal`, `jammy`, `noble`, etc.)
- **Channel**: `stable`
- **GPG Key**: Official Docker GPG key

### RHEL/CentOS
- **Repository**: `https://download.docker.com/linux/centos`
- **Channel**: `stable`
- **GPG Key**: Official Docker GPG key

## Update Strategy

**Current Configuration**: Latest stable versions are installed automatically.

To update Docker on deployed servers:

```bash
# Run the playbook again with the same configuration
ansible-playbook -i ansible/inventory/test-server.ini ansible/playbooks/install-docker.yml

# Or manually on the server
sudo apt update && sudo apt upgrade docker-ce docker-ce-cli containerd.io docker-compose-plugin
```

## Version Consistency

**Requirement**: Test server (hx-test-server) and dev server (hx-devops-server) should have identical Docker versions.

**Enforcement**: Both servers install from the same Docker CE repository at the same time, ensuring version consistency.

**Verification**:
```bash
# Check versions on both servers
ansible all -i ansible/inventory/test-server.ini -m shell -a "docker --version && docker compose version"
```

## Known Compatibility

**Tested with**:
- Ubuntu 24.04 LTS (Noble)
- Ubuntu 22.04 LTS (Jammy)
- Ubuntu 20.04 LTS (Focal)
- Debian 12 (Bookworm)
- RHEL/CentOS 8+

## Security Notes

**Firewall Management**: This role disables host firewalls per HX Platform policy (`docker_manage_firewall: true`).
- UFW disabled on Debian/Ubuntu
- firewalld disabled on RHEL/CentOS

**User Permissions**: Users in `docker_users` list are added to the `docker` group, granting Docker daemon access.

## References

- Official Docker Documentation: https://docs.docker.com/engine/install/
- Docker Compose V2: https://docs.docker.com/compose/cli-command/
- Docker CE Repository: https://download.docker.com/

---

**Last Updated**: 2025-10-15
**Role Version**: 1.0
**Maintained By**: HX Platform Team
