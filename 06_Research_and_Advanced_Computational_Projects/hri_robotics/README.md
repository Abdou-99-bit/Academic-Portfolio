# 🤖 Human–Robot Interaction (HRI) Simulation Framework

## Overview
A software-based simulation prototype modeling perception-driven control loops in Human–Robot Interaction (HRI). Developed in Python within a Linux (WSL Ubuntu) environment to test how visual feedback signals govern simulated robotic states and behavioral responses.

## Project Structure
* **`robot_sim.py`**: Virtual robot state and kinematics/behavior simulator processing control commands and updating system state.
* **`vision_controller.py`**: Perception and control interface module translating visual/environmental cues into high-level robotic actions.

## Methodology & Concepts
* **Closed-Loop Control:** Connects simulated sensory/vision inputs (`vision_controller.py`) to actuator/state updates (`robot_sim.py`).
* **Modular Robotics Architecture:** Separates perception processing from motion and state simulation.

## How to Run
```bash
python3 robot_sim.py
```
*(Depending on execution flow, run `python3 vision_controller.py` in a secondary terminal if operating as a client–server control loop.)*
