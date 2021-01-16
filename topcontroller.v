
module topcontroller(   input clk,
                        input rst,
                        input start,
                        input rxd,
                        output txd );
    
    wire [15:0] prescale=100000000/(9600*8);
    
    reg [7:0] senddata=0;
    reg sendvalid=0;
   // reg count=0;
    wire [7:0] readdata;
    wire readvalid;
    
    reg  stateuart=0;
    
    
    
  
    uart uartuut(
    .clk(clk),
    .rst(rst),
    .s_axis_tdata(senddata),
    .s_axis_tvalid(sendvalid),
    .m_axis_tdata(readdata),
    .m_axis_tvalid(readvalid),
    .m_axis_tready(1),
    .rxd(rxd),
    .txd(txd),
    .prescale(prescale)

);

reg [7:0] data1;
reg [8:0] freq1;
wire [4:0] freq_div;
wire [15:0]note;
wire chirp,pure;
Sythesizer cordicSynth (.clk(clk),.rst(rst),.start(start), .freq(freq1),.chirp(chirp),.pure(pure),.note(note));
    ila_0 ila (
	.clk(clk), // input wire clk
	.probe0(note), // input wire [15:0]  probe0  
	.probe1(rst), // input wire [0:0]  probe1 
	.probe2(start), // input wire [0:0]  probe2
	.probe3(chirp), // input wire [0:0]  probe3 
	.probe4(pure)
);
                          
assign freq_div= data1[4:0];
assign chirp=data1[6];
assign pure=~data1[7];
always @(posedge clk) begin
    if(rst==1) begin
        stateuart=0;
        sendvalid=0;
        data1=0;
    end
    
    case(stateuart)
    
    1'b0: begin 
            sendvalid=0;
            if(readvalid) begin
                    stateuart=1'b1;
                    data1=readdata;
                end
            end
    1'b1: begin
               sendvalid=1;
               stateuart=1'b0;
           end
    endcase
    
    case(freq_div)
      5'b00000: freq1 = 110;
      5'b00001: freq1 = 124;
      5'b00010: freq1 = 69;
      5'b00011: freq1 = 74;
      5'b00100: freq1 = 82;
      5'b00101: freq1 = 88;
      5'b00110: freq1 = 98;
      5'b00111: freq1 = 220;
      5'b01000: freq1 = 246;
      5'b01001: freq1 = 130;
      5'b01010: freq1 = 146;
      5'b01011: freq1 = 164;
      5'b01100: freq1 = 174;
      5'b01101: freq1 = 196;
      5'b01110: freq1 = 440;
      5'b01111: freq1 = 493;
      5'b10000: freq1 = 262;
      5'b10001: freq1 = 294;
      5'b10010: freq1 = 330;
      5'b10011: freq1 = 350;
      5'b10100: freq1 = 392;
      default: freq1 = 220;
      endcase

//if(readvalid) begin
//start=1;
//end
//else 
//start=0;

end


endmodule
