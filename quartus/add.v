module add(dataa,	clk, k,result,left,right,kkk,sw1,sw2);
output reg [1:0] kkk;
output reg [7:0] dataa;
input clk;
input   k,left,right,sw1,sw2;
wire t,m;
output reg [7:0] result;
reg[3:0] count;
reg [2:0] state;
reg[7:0] data[7:0];

reg[6:0] numbers[0:9];

reg[4:0] transition[0:7];
reg clock_switch;

reg  reset=1;
initial begin
numbers[0]='b1000000;
numbers[1]='b1111001;
numbers[2]='b0100100;
numbers[3]='b0110000;
numbers[4]='b0011001;
numbers[5]='b0010010;
numbers[6]='b0000010;
numbers[7]='b1111000;
numbers[8]='b0000000;
numbers[9]='b0010000;

end

always	 begin


if (!left || !right) begin 

if (reset==1) begin
clock_switch=~clock_switch;

end
end


end



always	@ (negedge m) begin
if (!k) begin
reg[3:0] i;
for (i=0;i<8;i=i+1) transition[i]=0;

end
count=count+1;
data[0][7]='b1;
data[1][7]='b1;
data[3][7]='b1;
data[0][6:0]=numbers[transition[0]];
data[1][6:0]=numbers[transition[1]];
data[2][6:0]=numbers[transition[2]];
data[3][6:0]=numbers[transition[3]];

data[4][7]='b1;
data[5][7]='b1;
data[7][7]='b1;
data[4][6:0]=numbers[transition[4]];
data[5][6:0]=numbers[transition[5]];
data[6][6:0]=numbers[transition[6]];
data[7][6:0]=numbers[transition[7]];

if (clock_switch) begin 
transition[0]=transition[0]+1;
if (transition[0]==10) begin transition[0]=0; transition[1] = transition[1]+1;  end
if (transition[1]==6) begin transition[1]=0; transition[2]=transition[2]+1; end
if (transition[2]==10) begin transition[2]=0; transition[3] = transition[3]+1;  end
if (transition[3]==6) begin transition[2]=0; transition[3]=0; end
end
else

begin
transition[4]=transition[4]+1;
if (transition[4]==10) begin transition[4]=0; transition[5] = transition[5]+1;  end
if (transition[5]==6) begin transition[5]=0; transition[6]=transition[6]+1; end
if (transition[6]==10) begin transition[6]=0; transition[7] = transition[7]+1;  end
if (transition[7]==6) begin transition[6]=0; transition[7]=0; end
end

end
	
	always  @ (posedge t) begin
	state = state +'b1; 
case (state)

   0: begin result='b11111110; dataa = data[3]; end 
   1: begin result='b11111101; dataa = data[2]; end
   2: begin result='b11111011; dataa = data[1]; end
   3: begin result='b11110111; dataa = data[0]; end 
	4: begin result='b11101111; dataa = data[5]; end 
   5: begin result='b11011111; dataa = data[7]; end
   6: begin result='b10111111; dataa = data[6]; end
   7: begin result='b01111111; dataa = data[4]; end 
	default: state=0;
endcase
	end
	


counter c1 (clk,t,m);

endmodule

module counter (in_clk,out_clk,out2);

input in_clk;
output reg out_clk;
output reg out2;
reg[15:0] count;
reg[24:0] count2;
always	@ (posedge in_clk) begin
count<=count+1;

if (count==25000) 
begin 
out_clk<=~out_clk; count<=0; 
end

end


always @ (posedge in_clk) 
begin
count2<=count2+1;
if (count2==25000000) begin out2<=~out2; count2<=0; end 
end



endmodule


