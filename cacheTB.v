module cacheTB();
	
	reg clk = 0;
  	reg rst = 1;
  	wire Hit, Miss;
    reg memWrite;
  	reg [14:0] cacheReadAddress;
    wire memWriteCacheOutput;
    reg [31:0] memWriteData;
  	wire [14:0] memAddress, memWriteAddress, memWriteAddressCacheOutput;
  	wire [127:0] dataIn;
  	wire [31:0] out;
  	initial repeat (10) #70 clk = ~clk;

  	
    integer i;
    initial begin
    	// #100
    	// rst = 0;
    	// cacheReadAddress = 15'd185;
    	// #40
    	// cacheReadAddress = 15'd189;

      for ( i = 1024; i < 9216; i = i + 1) begin
            #1
            cacheReadAddress = i;
      end

  	end

	cache C (
		.clock(clk), 
		.memWrite(memWrite), 
		.cacheReadAddress(cacheReadAddress), 
		.dataIn(dataIn), 
		.out(out), 
		.Hit(Hit), 
		.Miss(Miss), 
		.memAddress(memAddress), // cache wants to update its data
    .memWriteAddress(memWriteAddress), // this is cach input
    .memWriteCacheOutput(memWriteCacheOutput) // this is equal to memWrite/memwrite but cache cache outputs it
	);
	dataMemory DM(clk, memWriteCacheOutput, memAddress, memWriteData,dataIn);

endmodule

