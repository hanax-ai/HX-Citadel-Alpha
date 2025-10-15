# Crawl4AI Agent (Original)

**Reference implementation from ottomator-agents**

This container represents the **original, unmodified** Crawl4AI Agent from the ottomator-agents repository. It serves as our baseline for validation and comparison.

## Purpose

- Validate the original implementation works
- Provide regression testing baseline
- Document differences from Citadel Alpha
- Enable A/B comparison

## Source

**Origin**: `/home/agent0/workspace/hx-citadel-ansible/tech_kb/ottomator-agents-main/crawl4AI-agent-v2/`

Files should be copied from the original source WITHOUT modifications.

## Configuration

### Port
- **External**: 11235
- **Internal**: 11235

### Dependencies
- **ChromaDB**: Uses embedded ChromaDB (not Qdrant)
- **Streamlit**: Uses Streamlit UI (not Open WebUI)
- **OpenAI API**: Requires OpenAI API key (not Ollama)

### Environment Variables

See `.env.example` for required configuration.

## Deployment

### Local Development

```bash
cd containers/crawl4ai-agent

# Copy environment template
cp .env.example .env

# Edit .env with your OpenAI API key
nano .env

# Build and run
docker-compose up --build
```

### Test Server Deployment

```bash
# Via Ansible
ansible-playbook -i ansible/inventory/test-server.ini ansible/playbooks/deploy-crawl4ai.yml

# Verify
curl http://hx-test-server:11235/health
```

## Validation Tests

```bash
# Health check
curl http://localhost:11235/health

# Streamlit UI
open http://localhost:11235

# Test crawling
# ... (see original documentation)
```

## Differences from Citadel Alpha

| Feature | Crawl4AI Agent | Citadel Alpha |
|---------|----------------|---------------|
| **Vector DB** | ChromaDB (embedded) | Qdrant (hx-vectordb-server) |
| **LLM** | OpenAI API (external) | Ollama (hx-ollama1) |
| **Embeddings** | OpenAI API | Ollama (hx-orchestrator-server) |
| **UI** | Streamlit | Open WebUI |
| **Port** | 11235 | 11236 |
| **Purpose** | Reference/Validation | Production |

## Maintenance

**Do NOT modify this container!**

This is our reference implementation. All modifications should go into `citadel-alpha/`.

If upstream updates are needed:
1. Pull latest from ottomator-agents
2. Update this container
3. Test to ensure it still works
4. Document changes
5. Update Citadel Alpha if needed

## References

- [Original Documentation](https://github.com/coleam00/ottomator-agents/tree/main/crawl4AI-agent-v2)
- [Crawl4AI GitHub](https://github.com/unclecode/crawl4ai)
