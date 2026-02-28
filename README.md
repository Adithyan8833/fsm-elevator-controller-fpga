# fsm-elevator-controller-fpga
RTL-based Moore FSM Elevator Controller in Verilog HDL with clock-enable optimization, timing analysis, power evaluation, and FPGA validation on ZedBoard (Zynq-7000).
---

## 📌 Project Overview

This project implements a 4-state Moore FSM-based Elevator Controller using modular RTL design methodology.

Two design versions were developed:

1. Baseline Version (standard synchronous FSM)
2. Clock-Enable Optimized Version (reduced switching activity)

Both versions were synthesized, implemented, timing-analyzed, power-evaluated, and validated on FPGA hardware.

---
## 🔁 FSM State Diagram

<img width="735" height="590" alt="state_diagram" src="https://github.com/user-attachments/assets/704e07c8-39f7-4eb2-a5d4-7451acdbeab8" />


The elevator controller is implemented as a 4-state Moore finite state machine.

### States
- IDLE
- MOVE_UP
- MOVE_DOWN
- DOOR_OPEN

### Inputs
- `UP`   → Requested floor > current floor
- `DOWN` → Requested floor < current floor
- `EQ`   → Requested floor == current floor
- `T`    → Door timer completion signal
- `clk`, `reset`

### Outputs
- `motor_up`
- `motor_down`
- `door_open`

### Input → State → Output Flow

1. Floor comparison logic generates `UP`, `DOWN`, or `EQ`.
2. Based on these signals, the FSM transitions between states.
3. Outputs depend only on the current state (Moore architecture).
4. When `EQ` is asserted, the FSM enters `DOOR_OPEN`.
5. After timeout (`T`), the system returns to `IDLE`.

The Moore architecture ensures stable and glitch-free motor and door control signals.
Reset initializes the system to the `IDLE` state.

## 🏗️ Architecture

The design is divided into modular components:

- Comparator (floor comparison logic)
- Elevator FSM (Moore control logic)
- Floor Counter (movement tracking)
- Door Timer (timeout generation)
- Top Module (system integration)

Control and datapath logic are clearly separated.

---

## 🔄 Design Versions

### 1️⃣ Baseline Version
- Standard Moore FSM implementation
- State updates occur every clock cycle
- No clock-enable gating
- Fully validated on FPGA

### 2️⃣ Clock-Enable Optimized Version
- Introduced `fsm_en` signal for gated state updates
- Added movement enable control in floor counter
- Reduced unnecessary switching activity
- Minor reduction observed in clock dynamic power

---

## 🧪 Verification

A common Verilog testbench (`tb/tb_elevator.v`) was developed and used to verify both versions.

Verification covered:

- FSM state transitions
- Floor increment/decrement logic
- Door timeout behavior
- Reset operation
- Direction control based on floor comparison

Both versions share identical top-level interfaces.

---

## ⏱️ Timing Analysis

Clock Constraint: 100 MHz (10 ns period)

### Baseline Version
- Worst Negative Slack (WNS): <insert value>
- Total Negative Slack (TNS): 0
- Worst Hold Slack (WHS): <insert value>

![Baseline Timing](reports/timing_baseline.png)

### Clock-Enable Version
- Worst Negative Slack (WNS): <insert value>
- Total Negative Slack (TNS): 0
- Worst Hold Slack (WHS): <insert value>

![Clock Enable Timing](reports/timing_clock_enable.png)

All timing constraints met.

---

## ⚡ Power Analysis

### Baseline Version
- Total Power: <insert value>
- Clock Dynamic: <insert value>

![Baseline Power](reports/power_baseline.png)

### Clock-Enable Version
- Total Power: <insert value>
- Clock Dynamic: <insert value>

![Clock Enable Power](reports/power_clock_enable.png)

Note: Total power reduction is minimal due to FPGA static power dominance.

---

## 🖥️ FPGA Implementation

Target Board: ZedBoard (Zynq-7000, XC7Z020)

- 100 MHz onboard clock
- Switch-based floor request input
- LED indicators for motor and door status
- Successful bitstream generation and hardware validation

---

## 📂 Repository Structure

