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

module complete(rst,pt,qtn,bt_10,bt_5,qt1,qt2,total,insert,change,add,product);
input rst,pt,bt_10,bt_5;
input [1:0]qtn,qt1,qt2;
output [7:0]total;
output [7:0]insert;
output reg [7:0]change;
output reg add;
output product;
select s(rst,pt,qtn,total,product);
insert i(rst,bt_10,bt_5,qt1,qt2,insert);
always@(total or insert)
begin
if(total<=insert)
 begin
  add=0;
  change=insert-total;
 end
else
 begin
  add=1;
  change=total-insert;
 end
 
end
endmodule

module machine_tb;
reg rst,pt,bt_10,bt_5;
reg [1:0]qtn,qt1,qt2;
wire [7:0]total,insert,change;
wire product,add;
complete c(rst,pt,qtn,bt_10,bt_5,qt1,qt2,total,insert,change,add,product);
initial 
begin
rst=0;pt=0;qtn=2'b11;bt_5=1;qt1=2'b10;bt_10=1;qt2=2'b01;
#100 rst=1;
#10 rst=0;pt=1;qtn=2'b11;bt_5=1;qt1=2'b11;bt_10=1;qt2=2'b01;
#100 rst=1;
#10 rst=0;pt=1;qtn=2'b11;bt_5=1;qt1=2'b11;bt_10=1;qt2=2'b11;
#100 $stop;
end

endmodule