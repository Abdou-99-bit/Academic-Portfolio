import time
import random
from queue import Queue
from threading import Thread

# Simulate 3 Cloud Worker Nodes with different processing capacities (in weights)
# Worker 1 is weak, Worker 3 is a powerful high-performance instance
workers = {
    "Worker_Node_1": {"capacity_weight": 1, "queue": Queue(), "processed_count": 0},
    "Worker_Node_2": {"capacity_weight": 2, "queue": Queue(), "processed_count": 0},
    "Worker_Node_3": {"capacity_weight": 4, "queue": Queue(), "processed_count": 0}
}

# Thread function simulating an active distributed server node processing data
def worker_process(name, node_data):
    while True:
        task = node_data["queue"].get()
        if task is None: break # Shutdown signal
        
        # Simulate computational execution time scaled inversely by server capacity
        execution_time = round(random.uniform(0.2, 0.5) / node_data["capacity_weight"], 3)
        time.sleep(execution_time)
        
        node_data["processed_count"] += 1
        print(f" [✔] {name} completed Task ID {task['id']} (Complexity: {task['complexity']} FLOPS) in {execution_time}s")
        node_data["queue"].task_done()

# Start the distributed worker threads in the background
threads = []
for name, data in workers.items():
    t = Thread(target=worker_process, args=(name, data), daemon=True)
    t.start()
    threads.append(t)

print("="*60)
print(" DISTRIBUTED CLOUD SCHEDULER & LOAD BALANCER INITIALIZED")
print("="*60)

# Generate 15 massive mathematical simulation tasks to distribute
tasks_pool = [{"id": i, "complexity": random.randint(1000, 9999)} for i in range(1, 16)]

# Mathematical Weighted Distribution Engine (Load Balancer)
# Distributes tasks proportionally based on server capacity weights
worker_names = list(workers.keys())
current_worker_index = 0
weight_counter = 0

for task in tasks_pool:
    while True:
        target_worker = worker_names[current_worker_index]
        if weight_counter < workers[target_worker]["capacity_weight"]:
            # Route task to the selected optimal server node
            workers[target_worker]["queue"].put(task)
            print(f"[Routing] Task {task['id']} assigned to {target_worker} (Weight Allocation Tracker: {weight_counter + 1}/{workers[target_worker]['capacity_weight']})")
            weight_counter += 1
            break
        else:
            # Shift traffic to next distributed node when weight capacity limit is reached
            weight_counter = 0
            current_worker_index = (current_worker_index + 1) % len(worker_names)

# Wait for all asynchronous distributed pipelines to empty safely
for name, data in workers.items():
    data["queue"].join()

print("="*60)
print(" SYSTEMS METRICS REPORT (ALGORITHMIC DISTRIBUTION FINAL LOG)")
print("="*60)
for name, data in workers.items():
    print(f" * {name} (Capacity Weight: {data['capacity_weight']}) -> Successfully Processed: {data['processed_count']} Tasks")
print("="*60)

