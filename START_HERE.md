# Start Here

## Recommended flow

Use the devcontainer-first workflow for this project.

1. Open the repo in VS Code.
2. Install the Dev Containers extension if needed.
3. Run `Dev Containers: Reopen in Container`.
4. Wait for the bootstrap to finish.
5. Run the project commands below.

## Commands to run inside the container

```bash
cd /workspaces/aetheris_edge
chmod +x *.sh
./run_local_pipeline.sh
./simulate_handovers.sh
wasm-pack build --target web --release --out-dir pkg/browser_wasm
./build_embedded.sh
./convert_all.sh
```

## Full release pipeline

```bash
./release_master_pipeline.sh
```

## Why this is the recommended setup

This project spans Rust, Go, Terraform, Helm, Docker, WASM, and document tooling. The devcontainer keeps the environment consistent and avoids the Linux toolchain issues seen in native Windows execution.
