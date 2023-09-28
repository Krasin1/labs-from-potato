module dms
(input wire line,
input wire [1:0] adr,
output wire data0,
output wire data1,
output wire data2,
output wire data3,
output wire data4,
output wire data5,
output wire data6 );
assign data0 = (adr==2'h0)?line:1'b0;
assign data1 = (adr==2'h1)?line:1'b0;
assign data2 = (adr==2'h2)?line:1'b0;
assign data3 = (adr==2'h3)?line:1'b0;
assign data4 = (adr==2'h4)?line:1'b0;
assign data5 = (adr==2'h5)?line:1'b0;
assign data6 = (adr==2'h6)?line:1'b0;
endmodule