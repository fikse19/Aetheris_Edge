# Aetheris Edge

Aetheris Edge is a secure, zero-trust, post-quantum-ready gateway project with a Rust core, Go backend services, Terraform infrastructure, Helm deployment manifests, and CI automation.

## Dev Container workflow

This repository includes a devcontainer configuration in [.devcontainer/devcontainer.json](.devcontainer/devcontainer.json) so the project can be developed in a Linux-based environment with the required toolchain installed automatically.

### Use the container

1. Open the repository in VS Code.
2. Install the Dev Containers extension if needed.
3. Run the command: `Dev Containers: Reopen in Container`.
4. Wait for the container to finish bootstrapping.

### Commands to run after startup

```bash
cd /workspaces/aetheris_edge
chmod +x *.sh
./run_local_pipeline.sh
./simulate_handovers.sh
wasm-pack build --target web --release --out-dir pkg/browser_wasm
./build_embedded.sh
./convert_all.sh
```

### Release workflow

```bash
./release_master_pipeline.sh
```

### Included tooling

- Rust + Clippy + rustfmt
- Go 1.23
- Terraform
- Docker-in-Docker
- wasm-pack
- pandoc
- bc

## Project structure

- `src/` — Rust library and binaries
- `backend/` — Go services and monitoring
- `charts/aetheris-edge/` — Helm chart
- `.github/workflows/` — GitHub Actions automation
- `.devcontainer/` — container setup and bootstrap scripts
- `main.tf` — Terraform base configuration
- `Dockerfile` — container image definition

## Security notes

The repository includes a `.gitignore` file that excludes sensitive outputs such as keys, secrets, Terraform state, and environment files.

## CI and SBOM generation

The repository includes validation and SBOM workflows for code quality, chart validation, and dependency inventory generation.
