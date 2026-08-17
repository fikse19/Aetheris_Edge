# PILOT CLIENT KICKOFF & ONBOARDING AGENDA
**Meeting Objective:** Align engineering teams, confirm zero-hardware infrastructure integration paths, and initialize the 30-day evaluation framework for **Aetheris Edge** by **Top Cover Group**.

### I. Introductions & Administrative Alignment (10 Mins)
- Introductions from Top Cover Group Solutions Engineering & Client Tech Leads.
- Review and countersignature confirmation of the Mutual NDA (`NDA_TEMPLATE.md`).
- Overview of the 30-day evaluation boundaries and deployment scopes (`PILOT_QUOTE.md`).

### II. Architectural Overview: The Cryptographic Black-Box Pipeline (15 Mins)
- Demonstration of inline link-aware data reduction (targeting 60%+ wire savings).
- Explanation of NIST FIPS 204 [ML-DSA-44 Lattice Signatures](https://nist.gov) securing packets.
- Confirmation of the **100% Software-Defined Model**: No physical appliances or dedicated crypto cards needed; using client's existing container/browser assets.

### III. Deployment & Integration Walkthrough (20 Mins)
- Provisioning tenant keys via `./provision_tenant.sh`.
- Deploying the distroless container runtime or testing the browser-native WebAssembly plugin.
- Configuring UDP/QUIC stream mapping over client's existing network interface cards (NICs).

### IV. Telemetry & ROI Verification Setup (10 Mins)
- Scraping metrics into client's existing [Prometheus](https://prometheus.io) framework.
- Importing the Grafana operational panel to track egress reduction and power savings live.

### V. Q&A & Action Items (5 Mins)
- Confirm schedule for daily/weekly asynchronous engineering sync channels.
- Set target date for initial data-reduction and latency-mitigation performance review.
