module door_timer(
  input clk,
  input reset,
  input door_open,
  output reg T
  );  
 localparam COUNT_MAX = 100;
 reg [6:0] count;
 
 always @(posedge clk or posedge reset)
 begin
    if (reset) begin
        count <= 0;
        T <= 0;
    end
    else begin
        if (door_open) begin
            if (count == COUNT_MAX) begin
                count <= 0;
                T <= 1;
            end
            else begin
                count <= count + 1;
                T <= 0;
            end
        end
        else begin
            count <= 0;
            T <= 0;
        end
    end
 end
endmodule
