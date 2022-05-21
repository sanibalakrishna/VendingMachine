module bin2bcd(bin,tens,ones);
input [7:0]bin;
output reg [3:0]tens,ones;
reg [7:0]bcd_data=0;
always@(bin)
begin
bcd_data=bin;
tens=bcd_data/10;
ones=bcd_data%10;
end
endmodule

module bin2bcd_tb;
reg [7:0]bin;
wire [3:0] tens,ones;
bin2bcd bd(bin,tens,ones);
initial
begin
bin=8'b00001001;
#50 bin=8'b00001101;
#50 bin=8'b00011001;
#50 bin=8'b00011101;
end
endmodule