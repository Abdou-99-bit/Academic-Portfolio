
import numpy as np
import time
import json

class TrafficOptimizationEngine:
    def __init__(self, intersections=4):
        self.intersections = intersections
        # Initialize an identity flow matrix tracking capacity thresholds for urban nodes
        self.capacity_matrix = np.random.randint(150, 300, size=(intersections, intersections))
        # Ensure self-nodes have 0 intrinsic loop traffic
        np.fill_diagonal(self.capacity_matrix, 0)
        
    def generate_stochastic_traffic_stream(self):
        """Simulates non-linear vehicle arrival rates using a Poisson-like distribution"""
        # Replicates peak rush-hour variance across the spatial grid
        base_flow = np.random.poisson(lam=45, size=(self.intersections, self.intersections))
        np.fill_diagonal(base_flow, 0)
        
        # Inject multi-variable noise (simulating weather, accidents, or sudden density drops)
        noise = np.random.normal(loc=5.0, scale=2.5, size=(self.intersections, self.intersections)).astype(int)
        dynamic_flow = np.clip(base_flow + noise, 0, None)
        return dynamic_flow

    def calculate_congestion_index(self, active_flow):
        """Calculates a mathematical tensor ratio showing network saturation"""
        # Element-wise matrix division to evaluate current load against boundary thresholds
        with np.errstate(divide='ignore', invalid='ignore'):
            saturation_tensor = np.true_divide(active_flow, self.capacity_matrix)
            saturation_tensor[~np.isfinite(saturation_tensor)] = 0 # Clean infinity states
        return saturation_tensor

    def optimize_signal_matrix(self, saturation_tensor):
        """Dynamic Optimization Model: Allocates adaptive green-light time windows"""
        # Uses a mathematical optimization model where green-light extension 
        # is a direct function of node saturation levels
        base_green_time = 30.0 # Standard phase duration in seconds
        
        # Calculate dynamic extensions proportional to the worst congestion vectors
        critical_vectors = np.max(saturation_tensor, axis=1)
        optimized_phases = base_green_time + (critical_vectors * 45.0) # Map bounded to max +45s extension
        return np.round(optimized_phases, 1)

    def run_realtime_analytics_pipeline(self, cycles=5):
        print("="*80)
        print(" URBAN MOBILITY OPTIMIZATION CORE INITIALIZED")
        print(f" [INFRASTRUCTURE] Tracking {self.intersections} Autonomous Smart Traffic Intersection Matrix Nodes")
        print("="*80)
        
        for cycle in range(1, cycles + 1):
            print(f"\n[PIPELINE INTERVAL {cycle}] Ingesting live sensor telemetry matrix...")
            time.sleep(1.0) # Simulate telemetry collection delay
            
            # 1. Ingest Data Stream
            flow = self.generate_stochastic_traffic_stream()
            
            # 2. Evaluate Matrix Congestion Levels
            congestion = self.calculate_congestion_index(flow)
            avg_congestion = np.mean(congestion) * 100
            
            # 3. Compute Mathematical Phase Optimizations
            green_phases = self.optimize_signal_matrix(congestion)
            
            # Log Structural Output Report
            print(f" ├── Mean Network Congestion Level : {avg_congestion:.2f}%")
            print(f" ├── Max Node Traffic Load Count   : {np.max(flow)} vehicles/min")
            print(f" └── Calculated Green Light Windows: Node 1: {green_phases[0]}s | Node 2: {green_phases[1]}s | Node 3: {green_phases[2]}s")
            print("-" * 80)

if __name__ == '__main__':
    engine = TrafficOptimizationEngine(intersections=3)
    engine.run_realtime_analytics_pipeline(cycles=4)
