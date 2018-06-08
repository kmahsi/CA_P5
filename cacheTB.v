module cacheTB();
	
	reg clk = 0;
  	reg rst = 1;
  	wire cacheWrite, Hit, Miss;
  	reg [14:0] cacheReadAddress;
  	wire [14:0] memReadAddress;
  	wire [127:0] dataIn;
  	wire [31:0] out;
  	initial repeat (10) #70 clk = ~clk;

  	initial begin
    	#100
    	rst = 0;
    	cacheReadAddress = 15'd185;
    	#40
    	cacheReadAddress = 15'd189;
  	end

	cache C (
		.clock(clk), 
		.memWrite(cacheWrite), 
		.cacheReadAddress(cacheReadAddress), 
		.dataIn(dataIn), 
		.out(out), 
		.Hit(Hit), 
		.Miss(Miss), 
		.memReadAddress(memReadAddress)
		);
	dataMemory DM(clk, 1'b0, memReadAddress, 32'b0, dataIn);

endmodule

