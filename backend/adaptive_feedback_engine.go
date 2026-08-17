package main

import (
	"sync"
	"time"

	"github.com/prometheus/client_golang/prometheus"
	"github.com/prometheus/client_golang/prometheus/promauto"
)

var (
	processedPacketsCounter = promauto.NewCounterVec(
		prometheus.CounterOpts{
			Name: "zt_gateway_processed_packets_total",
			Help: "Total processed packets.",
		},
		[]string{"status", "client_type"},
	)
	linkLatencyGauge = promauto.NewGaugeVec(
		prometheus.GaugeOpts{
			Name: "zt_gateway_link_latency_seconds",
			Help: "Real-time latency tracking.",
		},
		[]string{"client_id"},
	)
)

type TenantConfig struct {
	TenantID     string    `json:"tenant_id"`
	LicenseKey   string    `json:"license_key"`
	MaxChannels  int       `json:"max_channels"`
	ActiveStatus bool      `json:"active_status"`
	CreatedAt    time.Time `json:"created_at"`
}

type AdaptiveFeedbackEngine struct {
	mu                 sync.RWMutex
	latencyHistory     map[string][]time.Duration
	currentCompression int
}

func NewFeedbackEngine() *AdaptiveFeedbackEngine {
	return &AdaptiveFeedbackEngine{latencyHistory: make(map[string][]time.Duration), currentCompression: 3}
}

func (afe *AdaptiveFeedbackEngine) ProcessMetricsAndCorrect(clientID string, latestLatency time.Duration, packetLossDetected bool) string {
	afe.mu.Lock()
	defer afe.mu.Unlock()

	afe.latencyHistory[clientID] = append(afe.latencyHistory[clientID], latestLatency)
	linkLatencyGauge.WithLabelValues(clientID).Set(latestLatency.Seconds())

	if latestLatency > 500*time.Millisecond || packetLossDetected {
		afe.currentCompression = 9
		processedPacketsCounter.WithLabelValues("corrected_high_compression", "embedded_agent").Inc()
		return "ACTION_REQUIRED: LINK_DEGRADED; SHIFT_TO_HIGH_COMPRESSION"
	}
	processedPacketsCounter.WithLabelValues("nominal", "standard_client").Inc()
	return "STATUS_NOMINAL: KEEP_CURRENT_STRATEGY"
}
