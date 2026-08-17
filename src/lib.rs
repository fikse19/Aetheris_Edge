use flate2::write::GzEncoder;
use flate2::Compression;
use std::io::Write;
use wasm_bindgen::prelude::*;

#[wasm_bindgen]
pub fn browser_plugin_minimize_and_seal(raw_payload: &[u8], jwt_token: &str) -> Vec<u8> {
    let mut encoder = GzEncoder::new(Vec::new(), Compression::fast());
    if encoder.write_all(raw_payload).is_err() {
        return Vec::new();
    }

    let compressed_bytes = match encoder.finish() {
        Ok(bytes) => bytes,
        Err(_) => return Vec::new(),
    };

    let token_bytes = jwt_token.as_bytes();
    let token_len = token_bytes.len() as u32;

    let mut finalized_packet = Vec::new();
    finalized_packet.extend_from_slice(&token_len.to_be_bytes());
    finalized_packet.extend_from_slice(token_bytes);
    finalized_packet.extend_from_slice(&compressed_bytes);

    finalized_packet
}
