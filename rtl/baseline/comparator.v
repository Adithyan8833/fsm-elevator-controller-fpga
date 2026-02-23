module comparator(
  input [1:0] req_floor,
  input [1:0] curr_floor,
  output wire UP,
  output wire DOWN,
  output wire EQ
  );
  
  assign UP = (req_floor > curr_floor);
  assign DOWN = (req_floor < curr_floor);
  assign EQ = (req_floor == curr_floor);
endmodule

