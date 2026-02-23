module elevator_fsm(
  input clk,
  input reset,
  input UP,
  input DOWN,
  input EQ,
  input T,
  output reg motor_up,
  output reg motor_down,
  output reg door_open,
  output reg [1:0] current_state
  );
  
// state parameter or State Encoding (FSM States)

  
  parameter IDLE      =2'b00;
  parameter MOVE_UP   =2'b01;
  parameter MOVE_DOWN = 2'b10;
  parameter DOOR_OPEN = 2'b11;
  
// State Registers
  
  //reg [1:0] current_state;
  reg [1:0] next_state;

  // clock enable
  
  wire fsm_en;
  assign fsm_en = UP | DOWN | EQ | T;
  
// State Register (Sequential Logic)
  
  always @(posedge clk or posedge reset)
  begin
    if(reset)
      current_state <= IDLE;
    else if (fsm_en)
      current_state <= next_state;
    end

  // Next-State Logic (Combinational)
  always @(*)
  begin
    next_state = current_state;
      case(current_state)
      IDLE:
      begin
        if(UP)
          next_state = MOVE_UP;
        else if (DOWN)
          next_state = MOVE_DOWN;
          
        // else if (EQ) next_state = DOOR_OPEN; // REMOVE THIS LINE to stop flickering
        
        else
          next_state = IDLE;
      end
      MOVE_UP:
      begin
        if (EQ)
          next_state = DOOR_OPEN;
      end
      MOVE_DOWN:
      begin
        if (EQ)
          next_state = DOOR_OPEN;
      end
      DOOR_OPEN:
      begin
        if (T)
          next_state = IDLE;
      end
      endcase
    end
    
// Output Logic (Moore)

 always @(*)
 begin
   motor_up = 0;
   motor_down = 0;
   door_open = 0;
   
   case (current_state)
     MOVE_UP:
      motor_up =1;
     MOVE_DOWN:
      motor_down =1;
     DOOR_OPEN:
      door_open =1;
   endcase
 end
endmodule
