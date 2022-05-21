module clockdivide(clk, nclk);
input clk;
output reg nclk;
reg [31:0]count=32'd0;
always@(posedge clk)
begin
count=count+1;
nclk=count[16];
end
endmodule

module refresh_counter(rclock,rcounter);
input rclock;
output reg[2:0]rcounter=3'b000;
always@(posedge rclock)
rcounter<=rcounter+1;
endmodule

module refresh_complete(clk,rcounter);
input clk;
output [2:0]rcounter;
wire nclk;
clockdivide c(clk, nclk);
refresh_counter r(nclk,rcounter);

endmodule

module refresh_complete_tb;
reg clk;
wire [2:0]rcounter;
refresh_complete rc(clk,rcounter);
always #5 clk=~clk;
initial
begin
clk=0;

end
endmodule