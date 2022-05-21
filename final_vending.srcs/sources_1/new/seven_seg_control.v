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

module anode_control(rcounter,anode);
input [2:0]rcounter;
output reg [7:0]anode;
always@(rcounter)
begin
case(rcounter)
3'b000: anode=8'b11111110;
3'b001: anode=8'b11111101;
3'b010: anode=8'b11111011;
3'b011: anode=8'b11110111;
3'b100: anode=8'b11101111;
3'b101: anode=8'b11011111;
3'b110: anode=8'b10111111;
3'b111: anode=8'b01111111;
endcase
end
endmodule

module bcd_control(digit1,digit2,digit3,digit4,digit5,digit6,digit7,digit8,rcounter,bcd);
input [3:0]digit1,digit2,digit3,digit4,digit5,digit6,digit7,digit8;
input [2:0]rcounter;
output reg [3:0]bcd=4'b0000;
always@(rcounter,digit1,digit2,digit3,digit4,digit5,digit6,digit7,digit8)
begin
case(rcounter)
3'b000: bcd=digit1;
3'b001: bcd=digit2;
3'b010: bcd=digit3;
3'b011: bcd=digit4;
3'b100: bcd=digit5;
3'b101: bcd=digit6;
3'b110: bcd=digit7;
3'b111: bcd=digit8;
endcase
end
endmodule

module segment7(
     bcd,
     seg
    );
     
     //Declare inputs,outputs and internal variables.
     input [3:0] bcd;
     output [6:0] seg;
     reg [6:0] seg;

//always block for converting bcd digit into 7 segment format
    always @(bcd)
    begin
        case (bcd) //case statement
            0 : seg = 7'b1000000;
            1 : seg = 7'b1111001;
            2 : seg = 7'b0100100;
            3 : seg = 7'b0110000;
            4 : seg = 7'b0011001;
            5 : seg = 7'b0010010;
            6 : seg = 7'b0000010;
            7 : seg = 7'b1111000;
            8 : seg = 7'b0000000;
            9 : seg = 7'b0010000;
            //switch off 7 segment character when the bcd digit is not a decimal number.
            default : seg = 7'b1111111; 
        endcase
    end
    
endmodule

module sevensegall(sw1,sw2,sw3,sw4,sw5,sw6,sw7,sw8,clk,seg,anode);
input [3:0]sw1,sw2,sw3,sw4,sw5,sw6,sw7,sw8;
input clk;
output [6:0]seg;
output [7:0]anode;
wire nclk;
wire [2:0]rcounter;
wire [3:0]bcd;
clockdivide x1(clk, nclk);
refresh_counter x2(nclk,rcounter);
anode_control x3(rcounter,anode);
bcd_control x4(sw1,sw2,sw3,sw4,sw5,sw6,sw7,sw8,rcounter,bcd);
segment7 x5(bcd,seg);
endmodule

module sevensegal_tb;
reg [3:0]sw1,sw2,sw3,sw4,sw5,sw6,sw7,sw8;
reg clk;
wire [6:0]seg;
wire [7:0]anode;
sevensegall ss(sw1,sw2,sw3,sw4,sw5,sw6,sw7,sw8,clk,seg,anode);
always #5 clk=~clk;
initial
begin 
clk=0;
sw1=4'b0001;sw2=4'b0010;sw3=4'b0011;sw4=4'b0100;sw5=4'b0101;sw6=4'b0110;sw7=4'b0111;sw8=4'b1000;
end
endmodule