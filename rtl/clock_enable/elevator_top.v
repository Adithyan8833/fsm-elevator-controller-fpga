module elevator_top(
  input clk,
  input reset,
  input [1:0] req_floor,
  output motor_up,
  output motor_down,
  output door_open,
  output [1:0] curr_floor
  );
  
  wire UP;
  wire DOWN;
  wire EQ;
  wire [1:0] current_state;
  
  comparator u_cmp(
     .req_floor(req_floor),
     .curr_floor(curr_floor),
     .UP(UP),
     .DOWN(DOWN),
     .EQ(EQ)
    );
    
    wire T;
    
  door_timer u_timer (
    .clk(clk),
    .reset(reset),
    .door_open(door_open),
    .T(T)
    );
    
  elevator_fsm u_fsm(
      .clk(clk),
      .reset(reset),
      .UP(UP),
      .DOWN(DOWN),
      .EQ(EQ),
      .T(T),
      .motor_up(motor_up),
      .motor_down(motor_down),
      .door_open(door_open),
      .current_state(current_state)
    );
    
  floor_counter u_cntr(
       .clk(clk),
       .reset(reset),
       .current_state(current_state),
       .curr_floor(curr_floor)
    );
endmodule  
    
