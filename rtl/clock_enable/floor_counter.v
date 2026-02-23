module floor_counter(
  input clk,
  input reset,
  input [1:0] current_state,
  output reg [1:0] curr_floor
);

  localparam IDLE      = 2'b00;
  localparam MOVE_UP   = 2'b01;
  localparam MOVE_DOWN = 2'b10;
  localparam DOOR_OPEN = 2'b11;

  reg [5:0] delay_timer; 
  localparam TRAVEL_TIME = 50; 

  wire move_en;
  assign move_en = (current_state == MOVE_UP) ||
                   (current_state == MOVE_DOWN);

  always @(posedge clk or posedge reset)
  begin
    if (reset) begin
      curr_floor  <= 2'b00;
      delay_timer <= 0;
    end
    else if (move_en) begin
      if (delay_timer == TRAVEL_TIME) begin
        delay_timer <= 0;

        if (current_state == MOVE_UP)
          curr_floor <= curr_floor + 1;
        else
          curr_floor <= curr_floor - 1;
      end
      else begin
        delay_timer <= delay_timer + 1;
      end
    end
    else begin
      delay_timer <= 0;
    end
  end

endmodule
