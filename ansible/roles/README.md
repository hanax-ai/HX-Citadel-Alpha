# Ansible Roles Directory

## Docker Role (Required)

The `docker` role is required for installing Docker on the test server.

**Source**: `/home/agent0/workspace/hx-citadel-ansible/roles/docker/` or `agent0@192.168.10.13:/home/agent0/hx-citadel-ansible/roles/docker/`

### Setup Instructions

Copy the Docker role from the HX-Citadel Ansible repository:

```bash
# From local workspace
cp -r /home/agent0/workspace/hx-citadel-ansible/roles/docker ./ansible/roles/

# OR from test server
scp -r agent0@192.168.10.13:/home/agent0/hx-citadel-ansible/roles/docker ./ansible/roles/
```

### Role Structure (Expected)

```
roles/docker/
├── tasks/
│   ├── main.yml
│   ├── install.yml
│   └── containers.yml
├── defaults/
│   └── main.yml
├── handlers/
│   └── main.yml
├── meta/
│   └── main.yml
└── README.md
```

### Alternative: Use Galaxy or Git Submodule

**Not recommended for this project** (we want versioned control), but options include:

```bash
# Ansible Galaxy (if role is published)
ansible-galaxy install -r requirements.yml

# Git submodule
git submodule add https://github.com/hanax-ai/hx-citadel-ansible.git external/hx-citadel-ansible
ln -s ../../external/hx-citadel-ansible/roles/docker roles/docker
```

## Custom Roles

Future custom roles for this project should be created here following Ansible best practices.
