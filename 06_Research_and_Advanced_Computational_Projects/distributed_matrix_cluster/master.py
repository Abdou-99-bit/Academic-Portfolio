import socket
import json
import threading
import time
import numpy as np

# Configuration
MASTER_HOST = '127.0.0.1'
MASTER_PORT = 9999
MATRIX_SIZE = 1000 # 1000x1000 Matrix computation

class MasterNode:
    def __init__(self):
        self.server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        self.server.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
        self.server.bind((MASTER_HOST, MASTER_PORT))
        self.server.listen()
        self.workers = {}
        self.lock = threading.Lock()
        print(f"[MASTER] Listening on {MASTER_HOST}:{MASTER_PORT}...")

    def handle_worker(self, conn, addr):
        worker_id = f"{addr[0]}:{addr[1]}"
        print(f"[CLUSTER] New Worker Connected: {worker_id}")
        
        with self.lock:
            self.workers[worker_id] = {"conn": conn, "performance_score": 1.0}

        try:
            while True:
                # Keep-alive loop or wait for telemetry data
                data = conn.recv(1024)
                if not data: break
        except ConnectionResetError:
            pass
        finally:
            with self.lock:
                del self.workers[worker_id]
            print(f"[CLUSTER] Worker Disconnected: {worker_id}")
            conn.close()

    def start_accepting(self):
        def loop():
            while True:
                conn, addr = self.server.accept()
                threading.Thread(target=self.handle_worker, args=(conn, addr), daemon=True).start()
        threading.Thread(target=loop, daemon=True).start()

    def run_distributed_job(self):
        if not self.workers:
            print("[WARN] No worker nodes registered. Cannot process job.")
            return

        print(f"\n[JOB] Generating massive {MATRIX_SIZE}x{MATRIX_SIZE} matrix task matrix...")
        A = np.random.rand(MATRIX_SIZE, MATRIX_SIZE).tolist()
        B = np.random.rand(MATRIX_SIZE, MATRIX_SIZE).tolist()

        with self.lock:
            active_workers = list(self.workers.items())

        num_workers = len(active_workers)
        # Compute dynamic split bounds based on number of active workers
        rows_per_worker = MATRIX_SIZE // num_workers
        threads = []

        print(f"[SCHEDULER] Distributing calculation slices across {num_workers} live network nodes...")
        
        for i, (w_id, w_data) in enumerate(active_workers):
            start_row = i * rows_per_worker
            end_row = MATRIX_SIZE if i == num_workers - 1 else (i + 1) * rows_per_worker
            
            payload = {
                "matrix_A_slice": A[start_row:end_row],
                "matrix_B": B,
                "slice_index": i
            }
            
            t = threading.Thread(target=self.dispatch_slice, args=(w_id, w_data["conn"], payload))
            threads.append(t)
            t.start()

        for t in threads:
            t.join()
        print("[JOB] All distributed slices successfully calculated and aggregated.")

    def dispatch_slice(self, worker_id, conn, payload):
        try:
            start_time = time.time()
            # Send payload using size-prefixed framing protocol
            raw_data = json.dumps(payload).encode('utf-8')
            conn.sendall(f"{len(raw_data):<10}".encode('utf-8') + raw_data)
            
            # Read size-prefixed response
            resp_size = int(conn.recv(1024).decode('utf-8').strip())
            chunks = []
            bytes_recvd = 0
            while bytes_recvd < resp_size:
                chunk = conn.recv(min(resp_size - bytes_recvd, 4096))
                if not chunk: break
                chunks.append(chunk)
                bytes_recvd += len(chunk)
                
            response = json.loads(b"".join(chunks).decode('utf-8'))
            latency = time.time() - start_time
            print(f" [✔] Worker {worker_id} processed Slice {response['slice_index']} in {latency:.4f}s")
        except Exception as e:
            print(f"[ERROR] Communication failed with worker {worker_id}: {e}")

if __name__ == '__main__':
    master = MasterNode()
    master.start_accepting()
    
    while True:
        cmd = input("\nPress [ENTER] to trigger a distributed matrix multiplication job (or 'exit' to quit): ")
        if cmd.lower() == 'exit': break
        master.run_distributed_job()
