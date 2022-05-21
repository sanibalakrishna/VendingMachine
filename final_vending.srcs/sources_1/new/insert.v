module insert(rst,bt_10,bt_5,qt1,qt2,total);
input bt_10,bt_5,rst;
input [1:0]qt1,qt2;
output reg [7:0]total = 8'b0000000;
always @(rst or bt_10 or qt1 or bt_5 or qt2)
begin
if(rst)
 begin
 total <= 8'b0000000;
 end
else
begin
if(bt_10)
 case(qt2)

  2'b00:total=total+(8'b00001010*2'b00);
  2'b01:total=total+(8'b00001010*2'b01);
  2'b10:total=total+(8'b00001010*2'b10);
  2'b11:total=total+(8'b00001010*2'b11);
  
 endcase
if(bt_5)
 case(qt1)

  2'b00:total=total+(8'b00000101*2'b00);
  2'b01:total=total+(8'b00000101*2'b01);
  2'b10:total=total+(8'b00000101*2'b10);
  2'b11:total=total+(8'b00000101*2'b11);
  
 endcase
end
end
endmodule

module insert_tb;
reg bt_10,bt_5,rst;
reg [1:0]qt1,qt2;
wire [7:0]total;
insert i(rst,bt_10,bt_5,qt1,qt2,total);
initial
begin
rst=0;bt_5=1;qt1=2'b10;bt_10=0;qt2=2'b00;
#100 rst=1;
#100 rst=0;bt_5=0;qt1=2'b10;bt_10=1;qt2=2'b11;
#100 rst=1;
#100 rst=0;bt_5=1;qt1=2'b11;bt_10=1;qt2=2'b11;
end
endmodule
