module select(rst,pt,qtn,total1,product);
input rst,pt;
input [1:0]qtn;
output reg [7:0]total1=8'b00000000;
output reg product;
always@(rst or pt or qtn)
begin
if(rst)
 total1=8'b00000000;
else
 if(pt)
 begin
  product=1;
  case(qtn)
  2'b00:total1=(8'b00001010*2'b00);
  2'b01:total1=(8'b00001010*2'b01);
  2'b10:total1=(8'b00001010*2'b10);
  2'b11:total1=(8'b00001010*2'b11);
  endcase
 end
 else
 begin
  product=0;
  case(qtn)
  2'b00:total1=(8'b00000101*2'b00);
  2'b01:total1=(8'b00000101*2'b01);
  2'b10:total1=(8'b00000101*2'b10);
  2'b11:total1=(8'b00000101*2'b11);
  endcase
 end
  
end
endmodule

module select_tb;
reg rst,pt;
reg [1:0]qtn;
wire [7:0]total1;
wire product;
select s(rst,pt,qtn,total1,product);
initial
begin
rst=0;pt=0;qtn=2'b10;
#100 rst=1;
#100 rst=0;pt=1;qtn=2'b11; 
end
endmodule