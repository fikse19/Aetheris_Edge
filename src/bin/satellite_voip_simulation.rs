use aetheris_core::{PqcEngine, CompressionEngine};

fn main() {
    println!("📡 Aetheris Edge Satellite VoIP Simulation");

    // 1. Generate keys
    let (pk, sk) = PqcEngine::generate_master_keys();

    // 2. Mock raw PCM VoIP data
    let raw_pcm = vec![120u8; 1308];
    println!("🎤 Original VoIP Frame Size: {} bytes", raw_pcm.len());

    // 3. Compress frame
    let compressed = CompressionEngine::compress_voip_frame(&raw_pcm);
    println!("⚡ Compressed Payload Size: {} bytes", compressed.len());

    let reduction = 100.0 * (1.0 - (compressed.len() as f64 / raw_pcm.len() as f64));
    println!("📉 Bandwidth Reduction: {:.2}%", reduction);

    // 4. Sign compressed payload
    let signature = PqcEngine::sign_payload(&sk, &compressed);
    println!("✍️ PQC Signature Length: {} bytes", signature.len());

    // 5. Verify signature
    let valid = PqcEngine::verify_signature(&pk, &compressed, &signature);
    if valid {
        println!("🛡️ PQC Result: Post-quantum license signature verified successfully.");
    } else {
        eprintln!("❌ PQC Verification Failed!");
        std::process::exit(1);
    }
}
