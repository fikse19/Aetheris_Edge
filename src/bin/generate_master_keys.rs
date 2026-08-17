use pqcrypto_dilithium::dilithium2;
use pqcrypto_traits::sign::{PublicKey, SecretKey};
use std::fs::File;
use std::io::Write;

fn main() {
    println!("🔐 Initializing Aetheris Edge Post-Quantum Master Seed Generation...");
    let (public_key, secret_key) = dilithium2::keypair();

    let mut pub_file = File::create("mldsa_master.pub").unwrap();
    pub_file.write_all(public_key.as_bytes()).unwrap();

    let mut sec_file = File::create("mldsa_master.sec").unwrap();
    sec_file.write_all(secret_key.as_bytes()).unwrap();

    println!("✅ Post-Quantum Keys Generated Successfully.");
}
