package main

import (
	"crypto/aes"
	"crypto/cipher"
	"crypto/rand"
	"encoding/base64"
	"fmt"
	"io"
)

type EncryptedLogger struct {
	secretKey []byte
}

func NewEncryptedLogger(key []byte) *EncryptedLogger {
	return &EncryptedLogger{secretKey: key}
}

func (el *EncryptedLogger) WriteSecureLog(plainTextLog string) (string, error) {
	block, err := aes.NewCipher(el.secretKey)
	if err != nil {
		return "", err
	}
	gcm, err := cipher.NewGCM(block)
	if err != nil {
		return "", err
	}
	nonce := make([]byte, gcm.NonceSize())
	if _, err = io.ReadFull(rand.Reader, nonce); err != nil {
		return "", err
	}
	cipherText := gcm.Seal(nonce, nonce, []byte(plainTextLog), nil)
	return base64.StdEncoding.EncodeToString(cipherText), nil
}

func main() {
	key := []byte("0123456789abcdef")
	logger := NewEncryptedLogger(key)
	encoded, err := logger.WriteSecureLog("Aetheris Edge secure log")
	if err != nil {
		fmt.Println("error:", err)
		return
	}
	fmt.Println(encoded)
}
