`timescale 1ns/1ps
module tb_elevator;
  reg clk;
  reg reset;
  reg [1:0] req_floor;
  wire motor_up;
  wire motor_down;
  wire door_open;
  wire [1:0] curr_floor;
  
  elevator_top dut(
     .clk(clk),
     .reset(reset),
     .req_floor(req_floor),
     .motor_up(motor_up),
     .motor_down(motor_down),
     .door_open(door_open),
     .curr_floor(curr_floor)
     );
     
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end
  initial begin
    // Initial Reset
    reset = 1;
    req_floor = 2'b00;
    #20 reset = 0;
    
    // Request Floor 1 (01)
    // Needs > 500ns to travel 1 floor
    #20 req_floor = 2'b01;
    
    // Request Floor 2 (10) 
    // Wait long enough for Floor 1 arrival + Door Timer + Travel to Floor 2
    #1500 req_floor = 2'b10;
    
    // Request Ground Floor (00)
    // Traveling 2 floors down needs > 1000ns
    #2000 req_floor = 2'b00;
    
    #2000 $stop;
  end
  
     
  
endmodule
