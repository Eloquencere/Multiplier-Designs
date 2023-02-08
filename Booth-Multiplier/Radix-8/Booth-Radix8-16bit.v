module Booth(MC,MP,Prod,clk);
    input [15:0]MC,MP;
    input clk;
    output reg [31:0]Prod;

    integer count;
    reg [15:0]pp[15:0];
    reg [15:0]a,mp;
    reg T;
    wire [15:0]out;

    always @(MC or MP)
    begin
        pp[0]<=0; // 0
        pp[1]<=MC; // MC
        pp[2]<=MC; // MC
        pp[3]<=MC<<1; // 2MC
        pp[4]<=MC<<1; // 2MC
        pp[5]<=(MC<<1)+MC; // 3MC
        pp[6]<=(MC<<1)+MC; // 3MC
        pp[7]<=(MC<<2); // 4MC
        pp[8]<=((~MC+1)<<2); // -4MC
        pp[9]<=(((~MC+1)<<1)+MC); // -3MC
        pp[10]<=(((~MC+1)<<1)+MC); // -3MC
        pp[11]<=(~MC+1)<<1; // -2MC
        pp[12]<=(~MC+1)<<1; // -2MC
        pp[13]<=(~MC+1); // -MC
        pp[14]<=(~MC+1); // -MC
        pp[15]<=0; // 0
        mp<=MP;
        a<=0;
        T<=0;
        Prod<=32'bx;
        count=1;
    end

    Adder A1(out,a,pp[{mp[2:0],T}]);

    always @(posedge clk)
    begin
        if(count<=4)
        begin
            {a,mp,T}={{3{out[15]}},out,mp,T}>>3;
            count=count+1;
        end
        else
            Prod<={a,mp}>>4;
end

endmodule

module Adder(out,a,b);
    input [15:0]a,b;
    output [15:0]out;

    assign out=a+b;

endmodule