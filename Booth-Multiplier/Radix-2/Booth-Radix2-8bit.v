`define size 8 //size of the multiplier

module booth(MC,MP,Prod,clk);
    input [`size-1:0] MP,MC; //multiplicant
    input clk;
    output [(`size<<1)-1:0] Prod;
    reg [`size-1:0]mp,a; 
    reg T;
    integer count=0;
    wire [`size-1:0]sum,diff;

au a1(.out(sum), .a(a), .b(MC),.cin(0));
au a2(.out(diff),.a(a),.b(~MC),.cin(1));
always @(posedge clk or negedge clk)
begin
    if(count==0)
    begin   
        mp<=MP; // multiplier
        a<=4'b0; //accumulator
        T<=0; //test bit
        count=count+1;
    end
    else if(count<=`size)
    begin:cal
        case({mp[0],T})
        2'b0_1:{a,mp,T}<={sum[`size-1],sum,mp}; //add & shift
        2'b1_0:{a,mp,T}<={diff[`size-1],diff,mp}; //sub & shift
        default:{a,mp,T}<={a[`size-1],a,mp}; //default shift
        endcase
        count=count+1;
    end:cal
assign Prod = {a,mp};
end
endmodule

module au(out,a,b,cin);
	output [`size-1:0]out;
	input [`size-1:0]a,b;
	input cin;
assign out=a+b+cin;
endmodule