use aetheris_core::PqcEngine;

fn main() {
    println!("🔐 Generating ML-DSA-44 Master Keys via aetheris-core...");
    let (pk, sk) = PqcEngine::generate_master_keys();
    println!("✅ Master Public Key Generated: {} bytes", pk.len());
    println!("✅ Master Secret Key Generated: {} bytes", sk.len());
}
