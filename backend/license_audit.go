package main

import (
	"fmt"
	"time"
)

type LicenseMetadata struct {
	OrgName   string
	UserEmail string
	ValidTill time.Time
}

func AuditLicenseLifecycles(registry []LicenseMetadata) {
	for _, client := range registry {
		daysLeft := int(time.Until(client.ValidTill).Hours() / 24)
		if daysLeft <= 14 && daysLeft > 0 {
			fmt.Println("==================================================================")
			fmt.Printf("📧 DISPATCHING ENCRYPTED LICENSE EXPIRATION WARNING: %s\n", client.UserEmail)
			fmt.Println("==================================================================")
			fmt.Printf("Dear Aetheris Systems Operations Team at %s,\n\n", client.OrgName)
			fmt.Printf("Your software-defined perimeter validation window will lapse in [%d DAYS].\n", daysLeft)
			fmt.Printf("To avoid automated post-quantum key revocation lockouts, update your token.\n")
			fmt.Println("==================================================================")
		}
	}
}

func main() {
	sampleRegistry := []LicenseMetadata{
		{
			OrgName:   "Palo Alto Networks - Sandbox",
			UserEmail: "secops@paloaltonetworks.com",
			ValidTill: time.Now().AddDate(0, 0, 7),
		},
		{
			OrgName:   "AST SpaceMobile - Ground Hub",
			UserEmail: "network-ops@ast-science.com",
			ValidTill: time.Now().AddDate(0, 0, 60),
		},
	}

	AuditLicenseLifecycles(sampleRegistry)
}
