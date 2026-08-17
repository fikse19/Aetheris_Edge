package main

import (
	"github.com/prometheus/client_golang/prometheus"
	"github.com/prometheus/client_golang/prometheus/promauto"
)

var (
	rawBytesProcessed = promauto.NewCounter(prometheus.CounterOpts{
		Name: "aetheris_dc_raw_bytes_processed_total",
		Help: "Total volume of raw application data before Aetheris Edge compression.",
	})
	compressedBytesTransmitted = promauto.NewCounter(prometheus.CounterOpts{
		Name: "aetheris_dc_compressed_bytes_transmitted_total",
		Help: "Total volume of compressed data sent over the physical wire network.",
	})
	estimatedKWhSaved = promauto.NewGauge(prometheus.GaugeOpts{
		Name: "aetheris_dc_estimated_kwh_saved",
		Help: "Estimated cumulative server energy saved by reducing network interface card (NIC) load.",
	})
	estimatedEgressDollarsSaved = promauto.NewGauge(prometheus.GaugeOpts{
		Name: "aetheris_dc_egress_dollars_saved",
		Help: "Estimated financial savings calculated using standard enterprise cloud egress costs ($0.08 per GB baseline).",
	})
)

type DataCenterMetricsManager struct {
	costPerGB float64
}

func NewDataCenterMetricsManager() *DataCenterMetricsManager {
	return &DataCenterMetricsManager{costPerGB: 0.08}
}

func (dmm *DataCenterMetricsManager) TrackSavingsHeuristics(rawSize int64, optimizedSize int64) {
	rawBytesProcessed.Add(float64(rawSize))
	compressedBytesTransmitted.Add(float64(optimizedSize))

	bytesSaved := rawSize - optimizedSize
	if bytesSaved <= 0 {
		return
	}

	gbSaved := float64(bytesSaved) / (1024 * 1024 * 1024)
	estimatedEgressDollarsSaved.Add(gbSaved * dmm.costPerGB)

	mbSaved := float64(bytesSaved) / (1024 * 1024)
	estimatedKWhSaved.Add(mbSaved * 0.00000005)
}
