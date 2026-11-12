import socket
import json
import numpy as np

MASTER_HOST = '127.0.0.1'
MASTER_PORT = 9999

def run_worker():
    client = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    try:
        client.connect((MASTER_HOST, MASTER_PORT))
        print(f"[WORKER] Successfully connected to Master at {MASTER_HOST}:{MASTER_PORT}")
    except Exception as e:
        print(f"[CRITICAL] Could not connect to Master: {e}")
        return

    try:
        while True:
            # Read size-prefixed payload frame header
            header = client.recv(1024)
            if not header: break
            
            payload_size = int(header[:10].decode('utf-8').strip())
            remaining_bytes = payload_size - len(header[10:])
            
            data_chunks = [header[10:]]
            while remaining_bytes > 0:
                chunk = client.recv(min(remaining_bytes, 4096))
                if not chunk: break
                data_chunks.append(chunk)
                remaining_bytes -= len(chunk)
                
            payload = json.loads(b"".join(data_chunks).decode('utf-8'))
            
            # Cast raw lists back into optimized numpy arrays for rapid math computing
            A_slice = np.array(payload["matrix_A_slice"])
            B = np.array(payload["matrix_B"])
            
            # Execute hardware-accelerated Matrix Multiplication (Dot Product)
            print(f"[COMPUTE] Calculating slice index: {payload['slice_index']}...")
            result_slice = np.dot(A_slice, B).tolist()
            
            # Prepare network response
            response = {"slice_index": payload["slice_index"], "result": result_slice}
            raw_resp = json.dumps(response).encode('utf-8')
            
            client.sendall(f"{len(raw_resp):<10}".encode('utf-8') + raw_resp)
            print(f"[SUCCESS] Slice {payload['slice_index']} completed and packet transmitted.")
            
    except Exception as e:
        print(f"[ERROR] Worker runtime exception: {e}")
    finally:
        print("[WORKER] Disconnecting from cluster server.")
        client.close()

if __name__ == '__main__':
    run_worker()
