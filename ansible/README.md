# Ansible Deployment

Automated deployment scripts for HX-Citadel-Alpha containers.

## Prerequisites

- Ansible 2.20+
- SSH access to hx-test-server (192.168.10.13)
- Docker role from hx-citadel-ansible (see below)

## Directory Structure

```
ansible/
├── inventory/
│   └── test-server.ini     # Test server inventory
├── playbooks/
│   ├── install-docker.yml          # Install Docker
│   ├── deploy-crawl4ai.yml         # Deploy original container
│   └── deploy-citadel-alpha.yml    # Deploy modified container
├── roles/
│   └── docker/                     # Docker role (external)
└── README.md                       # This file
```

## Setup

### 1. Install Docker Role

Copy the Docker role from hx-citadel-ansible:

```bash
# Option A: Copy from test server
scp -r agent0@192.168.10.13:/home/agent0/hx-citadel-ansible/roles/docker ansible/roles/

# Option B: Copy from local workspace
cp -r /home/agent0/workspace/hx-citadel-ansible/roles/docker ansible/roles/
```

### 2. Verify Inventory

```bash
# Test connectivity
ansible test_servers -i inventory/test-server.ini -m ping

# Check gathered facts
ansible test_servers -i inventory/test-server.ini -m setup
```

## Playbook Usage

### Install Docker

**First-time setup only:**

```bash
# Check what will be installed (dry run)
ansible-playbook -i inventory/test-server.ini playbooks/install-docker.yml --check

# Install Docker
ansible-playbook -i inventory/test-server.ini playbooks/install-docker.yml

# Verify installation
ansible test_servers -i inventory/test-server.ini -m shell -a "docker --version"
```

### Deploy Crawl4AI Agent (Original)

```bash
# Deploy original container
ansible-playbook -i inventory/test-server.ini playbooks/deploy-crawl4ai.yml

# Verify deployment
curl http://hx-test-server:11235/health

# View logs
ansible test_servers -i inventory/test-server.ini -m shell -a "docker logs crawl4ai-agent"
```

### Deploy Citadel Alpha (Modified)

```bash
# Deploy modified container
ansible-playbook -i inventory/test-server.ini playbooks/deploy-citadel-alpha.yml

# Verify deployment
curl http://hx-test-server:11236/health
curl http://hx-test-server:11236/ready

# View logs
ansible test_servers -i inventory/test-server.ini -m shell -a "docker logs citadel-alpha"
```

## Environment Configuration

### HX Platform Service Endpoints

Configured in `inventory/test-server.ini`:

| Service | Variable | Default |
|---------|----------|---------|
| Ollama Embeddings | `ollama_embeddings_url` | `http://hx-orchestrator-server:11434` |
| Ollama LLM | `ollama_llm_url` | `http://hx-ollama1:11434` |
| Qdrant | `qdrant_url` | `https://hx-vectordb-server:6333` |
| Redis | `redis_url` | `redis://hx-sqldb-server:6379` |
| Open WebUI | `openwebui_url` | `http://hx-webui-server:8080` |

### Secrets Management

**DO NOT commit secrets to Git!**

For sensitive values (API keys, passwords):

```bash
# Create vault file
ansible-vault create ansible/vault.yml

# Edit vault
ansible-vault edit ansible/vault.yml

# Example vault.yml content:
---
qdrant_api_key: "your-secret-key"
redis_password: "your-redis-password"

# Run playbook with vault
ansible-playbook -i inventory/test-server.ini playbooks/deploy-citadel-alpha.yml --ask-vault-pass
```

## Troubleshooting

### Connection Issues

```bash
# Verify SSH access
ssh agent0@192.168.10.13

# Check Ansible can connect
ansible test_servers -i inventory/test-server.ini -m ping
```

### Docker Not Installed

```bash
# Check Docker status
ansible test_servers -i inventory/test-server.ini -m shell -a "docker --version"

# If not installed, run install playbook
ansible-playbook -i inventory/test-server.ini playbooks/install-docker.yml
```

### Container Issues

```bash
# Check running containers
ansible test_servers -i inventory/test-server.ini -m shell -a "docker ps"

# Check container logs
ansible test_servers -i inventory/test-server.ini -m shell -a "docker logs <container-name>"

# Restart container
ansible test_servers -i inventory/test-server.ini -m shell -a "docker restart <container-name>"
```

### HX Platform Service Unreachable

```bash
# Test connectivity from test server
ssh agent0@192.168.10.13
curl http://hx-orchestrator-server:11434/api/version
curl https://hx-vectordb-server:6333/collections
```

## Best Practices

1. **Always run --check first**: Dry-run to see what will change
2. **Use --limit for single hosts**: `--limit hx-test-server`
3. **Keep secrets in vault**: Never commit `.env` files
4. **Follow FQCN**: Use `ansible.builtin.*` module names
5. **Document variables**: Update inventory comments

## Reference

- [Ansible Best Practices](https://docs.ansible.com/ansible/latest/user_guide/playbooks_best_practices.html)
- [HX-Citadel Ansible Standards](/home/agent0/workspace/hx-citadel-ansible/docs/ANSIBLE-BEST-PRACTICES.md)
- [Docker Role Documentation](roles/docker/README.md)
