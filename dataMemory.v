module dataMemory(clock, memWrite, address, dataIn, out);
	input clock, memWrite;
	input [31:0] dataIn;
	input[14:0] address;
	output [127:0] out;
	wire [14:0]x;

	reg[31:0] word[32 * 1024 - 1:0];  //32767

	always @(clock)begin
		word[15'd200] <= 32'd300;
		word[15'd199] <= 32'd299;
		word[15'd198] <= 32'd298;
		word[15'd197] <= 32'd297;
		word[15'd196] <= 32'd296;
		word[15'd195] <= 32'd295;
		word[15'd194] <= 32'd294;
		word[15'd193] <= 32'd293;
		word[15'd192] <= 32'd292;
		word[15'd191] <= 32'd291;
		word[15'd190] <= 32'd290;
		word[15'd189] <= 32'd289;
		word[15'd188] <= 32'd288;
		word[15'd187] <= 32'd287;
		word[15'd186] <= 32'd286;
		word[15'd185] <= 32'd285;
		word[15'd184] <= 32'd284;
		
		

	end
	
	always @(posedge clock) begin
		if (memWrite)begin
			word[address] <= dataIn;
		end
	end
	assign out = {word[address + 15'd3], word[address + 15'd2], word[address + 15'd1], word[address]};
	assign x = address + 15'd3;
endmodule 