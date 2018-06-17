module cache(clock, memWrite, cacheReadAddress, dataIn, out, Hit, Miss, memAddress, memWriteAddress, memWriteCacheOutput);
	input clock, memWrite;
	input [127:0] dataIn;
	input[14:0] cacheReadAddress; // This should be logarithm of number of blocks in memory
	output reg [14:0] memAddress, memWriteAddress;
	output memWriteCacheOutput;
	assign memWriteCacheOutput = memWrite;
	output reg [31:0] out;
	output reg Hit, Miss;
	reg [131:0]t;
		//tag + valid + data
	reg [3 + 1 + 128 - 1:0] word[1023:0];  	// it has 1024 * 4 * 32 bits, in each block it has 4 * 32 bits, so address should be between 0 and 1023
									// this reg has 1024, blocks;

	wire [1:0] offset;
	wire [9:0] index;
	wire [2:0] tag;
	
	assign offset = cacheReadAddress[1:0];
	assign index = cacheReadAddress[11:2];
	assign tag = cacheReadAddress[14:12];

	always @(dataIn) begin
		word[index][131:129] = tag;
		word[index][128] = 1'd1;
		word[index][127:0] = dataIn;
	end
	
	always @(*) begin
		Hit = 0; Miss = 0;
		if( memWrite)begin
			word[index][128] = 1'd0;
			memAddress = memWriteAddress;
		end
		if( tag == word[index][131:129] && 1'b1 == word[index][128] ) begin
			Hit = 1;
			case(offset)
				2'd0: out = word[index][31:0];
				2'd1: out = word[index][63:32];
				2'd2: out = word[index][95:64];
				2'd3: out = word[index][127:96];
				default: out = out;
			endcase
		end
		else begin
			Miss = 1;
			memAddress = {tag, index, 2'd0};
		end
	end
endmodule 