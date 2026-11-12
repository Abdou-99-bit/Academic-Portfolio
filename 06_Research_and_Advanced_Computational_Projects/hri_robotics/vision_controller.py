import socket
import json
import time
import random

HOST = '127.0.0.1'
PORT = 8888

def run_vision_transmitter():
    client = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    try:
        client.connect((HOST, PORT))
        print("[VISION CORE] Handshake successful. Connected to virtual robotics node.")
    except Exception as e:
        print(f"[ERROR] Failed to bridge to robotics subsystem: {e}")
        return

    # Simulate 10 sequential real-time vision gesture events tracking finger metrics
    try:
        for i in range(1, 11):
            # Alternate states to replicate hands opening (driving) and closing (braking)
            if i <= 6:
                gesture = "DRIVE_FORWARD"
                distance_pixels = random.randint(120, 280) # Distance between fingers
            else:
                gesture = "BRAKE_STOP"
                distance_pixels = random.randint(10, 35)
                
            payload = {
                "frame_id": i,
                "gesture_state": gesture,
                "spatial_vector_distance": distance_pixels
            }
            
            # Format and serialize structural network packages
            raw_data = json.dumps(payload).encode('utf-8')
            header = f"{len(raw_data):<10}".encode('utf-8')
            
            # Transmit structured frame pipeline data
            client.sendall(header + raw_data)
            print(f"[TRANSMIT] Sent Frame {i}: State={gesture}, Spatial Metric={distance_pixels}px")
            time.sleep(1.2) # Replicate native camera processing delays
            
    except Exception as e:
        print(f"[ERROR] Vision processing link terminated: {e}")
    finally:
        print("[VISION CORE] Stream concluded. Disconnecting.")
        client.close()

if __name__ == '__main__':
    run_vision_transmitter()
