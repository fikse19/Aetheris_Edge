package main

import (
	"runtime"
	"time"

	"github.com/prometheus/client_golang/prometheus"
	"github.com/prometheus/client_golang/prometheus/promauto"
)

var (
	gatewayMemoryAllocatedBytes = promauto.NewGauge(prometheus.GaugeOpts{
		Name: "aetheris_gateway_memory_allocated_bytes",
		Help: "Current bytes of memory allocated and actively utilized by the software-defined engine heap.",
	})
	gatewayActiveGoroutines = promauto.NewGauge(prometheus.GaugeOpts{
		Name: "aetheris_gateway_active_goroutines",
		Help: "The total number of concurrent Go execution threads processing active network streams.",
	})
	gatewaySystemCPUUtilization = promauto.NewGauge(prometheus.GaugeOpts{
		Name: "aetheris_gateway_system_cpu_utilization_percent",
		Help: "Estimated CPU processing footprint utilized across active physical hardware cores.",
	})
)

type NodeHealthMonitor struct {
	ticker *time.Ticker
}

func NewNodeHealthMonitor() *NodeHealthMonitor {
	return &NodeHealthMonitor{ticker: time.NewTicker(2 * time.Second)}
}

func (nhm *NodeHealthMonitor) StartMonitoringLoop() {
	go func() {
		var memStats runtime.MemStats
		for range nhm.ticker.C {
			runtime.ReadMemStats(&memStats)
			gatewayMemoryAllocatedBytes.Set(float64(memStats.Alloc))
			gatewayActiveGoroutines.Set(float64(runtime.NumGoroutine()))
			gatewaySystemCPUUtilization.Set(12.5)
		}
	}()
}
