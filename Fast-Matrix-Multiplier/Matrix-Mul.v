module matrix(A,B,prod_det);
parameter size = 2;

input [31:0]A,B;
output [31:0]prod_det;

reg signed [31:0]mat1[size-1:0][size-1:0],mat2[size-1:0][size-1:0];
reg signed [63:0]mat3[size-1:0][size-1:0];
integer j,k;

genvar i;
generate
    for(i=0;i<size;i=i+1)
    begin
        always @ (*)
        begin
            {mat1[0][0],mat1[0][1],mat1[1][0],mat1[1][1]}=A;
            {mat2[0][0],mat2[0][1],mat2[1][0],mat2[1][1]}=B;
            j=0;k=0;
            for(j=0;j<size;j=j+1)
            begin
                mat3[i][j]=64'b0;
                for(k=0;k<size;k=k+1)
                begin
                    mat3[i][j]=mat3[i][j]+(mat1[i][k]*mat2[k][j]);
                end
            end
        end
    end
endgenerate
assign prod_det=mat3[0][0];
endmodule