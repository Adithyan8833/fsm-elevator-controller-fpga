## 1. Clock Signal (100MHz Onboard Oscillator)
set_property PACKAGE_PIN Y9 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -period 10.000 -name sys_clk [get_ports clk]

## 2. Reset (Center Push Button)
set_property PACKAGE_PIN P16 [get_ports reset]
set_property IOSTANDARD LVCMOS33 [get_ports reset]

## 3. Floor Request Inputs (Switches SW0 and SW1)
set_property PACKAGE_PIN F22 [get_ports {req_floor[0]}]
set_property PACKAGE_PIN G22 [get_ports {req_floor[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {req_floor[*]}]

## 4. Motor and Door Outputs (LEDs LD0, LD1, LD2)
set_property PACKAGE_PIN T22 [get_ports motor_up]
set_property PACKAGE_PIN T21 [get_ports motor_down]
set_property PACKAGE_PIN U22 [get_ports door_open]
set_property IOSTANDARD LVCMOS33 [get_ports motor_up]
set_property IOSTANDARD LVCMOS33 [get_ports motor_down]
set_property IOSTANDARD LVCMOS33 [get_ports door_open]

## 5. Current Floor Display (LEDs LD6 and LD7)
set_property PACKAGE_PIN U14 [get_ports {curr_floor[0]}]
set_property PACKAGE_PIN U19 [get_ports {curr_floor[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {curr_floor[*]}]

## 6. Routing Fix for Clock
## Required because 'clk' is mapped to a pin that may not be a dedicated clock pin
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets clk_IBUF]
