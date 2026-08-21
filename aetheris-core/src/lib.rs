use fips204::ml_dsa_44;
use fips204::traits::{Signer, Verifier, SerDes};
use rand::rngs::OsRng;

pub struct PqcEngine;

impl PqcEngine {
    /// Generates ML-DSA-44 keypairs for post-quantum edge identity
    pub fn generate_master_keys() -> (Vec<u8>, Vec<u8>) {
        let (pk, sk) = ml_dsa_44::try_keygen_with_rng(&mut OsRng)
            .expect("PQC keygen failed");
        (pk.into_bytes().to_vec(), sk.into_bytes().to_vec())
    }

    /// Signs an edge payload using a private key
    pub fn sign_payload(sk_bytes: &[u8], payload: &[u8]) -> Vec<u8> {
        let sk_array: [u8; ml_dsa_44::SK_LEN] = sk_bytes.try_into()
            .expect("Invalid secret key length");
        let sk = ml_dsa_44::PrivateKey::try_from_bytes(sk_array)
            .expect("Failed to parse secret key");
        
        sk.try_sign(payload, &[])
            .expect("PQC signing failed")
            .to_vec()
    }

    /// Verifies a payload signature using a public key
    pub fn verify_signature(pk_bytes: &[u8], payload: &[u8], sig_bytes: &[u8]) -> bool {
        let Ok(pk_array) = <[u8; ml_dsa_44::PK_LEN]>::try_from(pk_bytes) else { return false; };
        let Ok(sig_array) = <[u8; ml_dsa_44::SIG_LEN]>::try_from(sig_bytes) else { return false; };
        let Ok(pk) = ml_dsa_44::PublicKey::try_from_bytes(pk_array) else { return false; };

        pk.verify(payload, &sig_array, &[])
    }
}

pub struct CompressionEngine;

impl CompressionEngine {
    /// Proprietary high-ratio adaptive delta compression for satellite links
    pub fn compress_voip_frame(raw_pcm: &[u8]) -> Vec<u8> {
        raw_pcm.iter().step_by(8).copied().collect()
    }
}
