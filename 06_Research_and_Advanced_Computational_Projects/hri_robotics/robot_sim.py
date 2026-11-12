import socket
import json
import time

HOST = '127.0.0.1'
PORT = 8888

def run_simulation_core():
    # Initialize the robotic telemetry reception gateway
    server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    server.bind((HOST, PORT))
    server.listen(1)
    
    print("="*70)
    print(" VIRTUAL KINEMATICS ENGINE & SIMULATION TERMINAL INITIALIZED")
    print(f" [STATUS] Listening for Human-Robot Interface (HRI) telemetry on port {PORT}...")
    print("="*70)
    
    conn, addr = server.accept()
    print(f"[CONNECTED] Vision Tracking Node established from hardware interface: {addr}\n")

    try:
        while True:
            # Read size-prefixed spatial coordinates packet
            header = conn.recv(10)
            if not header: break
            
            data_size = int(header.decode('utf-8').strip())
            raw_payload = conn.recv(data_size)
            
            payload = json.loads(raw_payload.decode('utf-8'))
            gesture = payload["gesture_state"]
            distance = payload["spatial_vector_distance"]
            
            # Map raw coordinate vectors to simulated physical telemetry
            simulated_velocity = round(distance * 0.05, 2)
            
            print(f"[TELEMETRY INGESTED] Gesture Status: {gesture:<10} | Euclidean Gap: {distance:<5} px | Computed Velocity: {simulated_velocity} m/s")
            
            # Simulate active kinematic loop updates
            if gesture == "DRIVE_FORWARD":
                print(f"  └─► [ROBOT ACTION] Publishing geometry_msgs/Twist -> Linear X: +{simulated_velocity}")
            elif gesture == "BRAKE_STOP":
                print(f"  └─► [ROBOT ACTION] Publishing geometry_msgs/Twist -> Active Deceleration Enforced.")
            
            print("-" * 70)
            
    except Exception as e:
        print(f"[SYSTEM FAILURE] Simulation interface lost pipeline data: {e}")
    finally:
        print("\n[SHUTDOWN] Closing virtualization threads.")
        conn.close()
        server.close()

if __name__ == '__main__':
    run_simulation_core()
