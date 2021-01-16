`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Prashanth H C
// 
// Create Date: 12/15/2020 11:08:09 PM
// Design Name: 
// Module Name: Sythesizer
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Sythesizer(
    input clk,rst,start,
    input [8:0]freq,
    input chirp,pure,
    output [15:0]note
    );
  //  reg [8:0]freq=440;
  //  wire [15:0]note;
    
 //   wire rst,start;
    wire [7:0] coeff0,coeff1;
    wire [15:0]a,b;
    wire [15:0]c;
    wire [7:0]phase0,phase1;
    wire [15:0]wave0,wave1;
    
    reg [13:0]phaseaddress0,phaseaddress1;  
    reg valid;
    reg [8:0]dfreq;
        
  wire [7:0]dout0,dout1;
  reg weasine;
  reg [13:0]addresssine;
  reg [13:0]addresssinecompute;
  
  reg [13:0]addresstone,addresscoeff0,addresscoeff1;
  reg [1:0]weatone;
  wire clk_div2;

  reg [2:0] state;
  reg [13:0]count;
  reg freqchanged;   
  reg synth;
  
    reg [2:0] computestate;
    reg [13:0]computecount;
    
    clk_wiz_0 clkgenerator
   (
    // Clock out ports
    .clk_out1(clk_div),     // output clk_out1
    .clk_out2(clk_div2),     // output clk_out2
   // Clock in ports
    .clk_in1(clk)
    ); 
    
//   vio_0 vio (
//  .clk(clk),                // input wire clk
//  .probe_out0(freq),  // output wire [15 : 0] probe_out0
//  .probe_out1(rst),  // output wire [0 : 0] probe_out1
//  .probe_out2(start)  // output wire [0 : 0] probe_out2
//   );


//     ila_0 ila (
//	.clk(clk_div), // input wire clk
//	.probe0(a), // input wire [15:0]  probe0  
//	.probe1(b), // input wire [15:0]  probe1 
//	.probe2(rst), // input wire [0:0]  probe2 
//	.probe3(start), // input wire [0:0]  probe3 
//	.probe4(clk_div), // input wire [0:0]  probe4 
//	.probe5(addresstone), // input wire [13:0]  probe5 
//	.probe6(note) // input wire [15:0]  probe6
//    );
     
  blk_mem_gen_2 phase (
  .clka(clk),    // input wire clka
  .addra(phaseaddress0),  // input wire [13 : 0] addra
  .douta(phase0),  // output wire [7 : 0] douta
  .clkb(clk),    // input wire clkb
  .addrb(phaseaddress1),  // input wire [13 : 0] addrb
  .doutb(phase1)  // output wire [7 : 0] doutb
  );
    

  cordic_0 cordic0 (
  .aclk(clk),                                // input wire aclk
  .s_axis_phase_tvalid(valid),  // input wire s_axis_phase_tvalid
  .s_axis_phase_tdata(phase0),    // input wire [7 : 0] s_axis_phase_tdata
  .m_axis_dout_tvalid(ovalid0),    // output wire m_axis_dout_tvalid
  .m_axis_dout_tdata(wave0)      // output wire [15 : 0] m_axis_dout_tdata
  );
  cordic_0 cordic1 (
  .aclk(clk),                                // input wire aclk
  .s_axis_phase_tvalid(valid),  // input wire s_axis_phase_tvalid
  .s_axis_phase_tdata(phase1),    // input wire [7 : 0] s_axis_phase_tdata
  .m_axis_dout_tvalid(ovalid1),    // output wire m_axis_dout_tvalid
  .m_axis_dout_tdata(wave1)      // output wire [15 : 0] m_axis_dout_tdata
  );
  
 
  
  blk_mem_gen_0 bram0 (
  .clka(clk),    // input wire clka
  .wea(weasine),      // input wire [0 : 0] wea
  .addra(addresssine),  // input wire [13 : 0] addra
  .dina(wave0[15:8]),    // input wire [7 : 0] dina
  .clkb(clk),    // input wire clkb
  .addrb(addresssinecompute),  // input wire [13 : 0] addrb
  .doutb(dout0)  // output wire [7 : 0] doutb
  );
  blk_mem_gen_0 bram1 (
  .clka(clk),    // input wire clka
  .wea(weasine),      // input wire [0 : 0] wea
  .addra(addresssine),  // input wire [13 : 0] addra
  .dina(wave1[15:8]),    // input wire [7 : 0] dina
  .clkb(clk),    // input wire clkb
  .addrb(addresssinecompute),  // input wire [13 : 0] addrb
  .doutb(dout1)  // output wire [7 : 0] doutb
  );  
wire [7:0]type0,type1;
assign type0=pure?1:coeff0;
assign type1=pure?0:coeff1;


  mult_gen_0 mult0 (
  .CLK(clk),  // input wire CLK
  .A(dout0),      // input wire [7 : 0] A
  .B(type0),      // input wire [7 : 0] B
  .P(a)      // output wire [15 : 0] P
   );
   mult_gen_0 mult1 (
  .CLK(clk),  // input wire CLK
  .A(dout1),      // input wire [7 : 0] A
  .B(type1),      // input wire [7 : 0] B
  .P(b)      // output wire [15 : 0] P
  );
  
  c_addsub_0 sum (
  .A(a),      // input wire [15 : 0] A
  .B(b),      // input wire [15 : 0] B
  .CLK(clk),  // input wire CLK
  .S(c)      // output wire [15 : 0] S
  );
  

  
  blk_mem_gen_1 tone (
  .clka(clk_div2),    // input wire clka
  .wea(weatone),      // input wire [1 : 0] wea
  .addra(addresstone),  // input wire [13 : 0] addra
  .dina(c),    // input wire [15 : 0] dina
  .douta(note)  // output wire [15 : 0] douta
  );
  
  blk_mem_gen_3 coefficient0 (
  .clka(clk),    // input wire clka
  .addra(addresscoeff0),  // input wire [13 : 0] addra
  .douta(coeff0)  // output wire [7 : 0] douta
  );
  blk_mem_gen_3 coefficient1 (
  .clka(clk),    // input wire clka
  .addra(addresscoeff1),  // input wire [13 : 0] addra
  .douta(coeff1)  // output wire [7 : 0] douta
  );
    
 
    
    always@(posedge start) begin
    synth=1;
    end
    
    always@(posedge clk_div) begin
    if(phaseaddress0>(8800-freq)) begin phaseaddress0=0; if(chirp==1'b1)begin  dfreq=dfreq+1; end end//sphaseaddress0-(8800-freq); 
    if(phaseaddress1>(8800-2*freq)) phaseaddress1=0;//phaseaddress1-(8800-2*freq);
    if(dfreq>880)dfreq=880;
    case(state)
    3'b000: begin                  //wait state
            addresssine=0;
            phaseaddress0=0;
            phaseaddress1=0;
            weasine=0; valid=0;
            dfreq=freq;
            if(freqchanged)begin   
                    count=0;
                    freqchanged=0;
                    state=3'b001;
                     end //freq change detected
            else state=3'b000;
            if (synth==1) begin state=3'b001; synth=0; end
            end
    3'b001: begin            //calculted sine      
            valid=1; 
            if(count==8800) begin weasine=0; state=3'b000; end 
            if(ovalid0==1 && ovalid1==1) begin weasine=1; state =3'b010; end    //write to bram
            else state=3'b001;
            if(addresssine>8800) state=3'b000;
            if(freqchanged==1) freqchanged=0;
            end
    3'b010: begin
            state=3'b001;
            count=count+1;      //increment count and phase
             phaseaddress0=phaseaddress0+dfreq;        
             phaseaddress1=phaseaddress1+(2*dfreq);
             
             if(addresssine>8800) state=3'b000;
             else addresssine=addresssine+1;
            if(freqchanged==1) freqchanged=0;
            end
    endcase
    end
    
   // always@(posedge clk_div) begin
   // if(phaseaddress0>(8800-freq))  phaseaddress0=0;//sphaseaddress0-(8800-freq); 
   // if(phaseaddress1>(8800-2*freq)) phaseaddress1=0;//phaseaddress1-(8800-2*freq);
   // end
    

       
    always@(freq) begin
    freqchanged=1;
    //clk_div2=0;
    end

    always@(posedge clk_div2) begin
          if(addresssine==10)begin 
                       computecount=0;
                       computestate=3'b000; 
                       end
    case(computestate)
    3'b000: begin
            addresssinecompute=0;
            addresscoeff0=0;
            addresscoeff1=0;
            addresstone=0;
            computestate=3'b001;    
            weatone=3;        
            end
    3'b001: begin
            if(computecount==8800) begin 
             computestate=3'b010; addresssinecompute=0; weatone=0;  end
            else begin
                 addresssinecompute=addresssinecompute+1;
                 addresscoeff0=addresscoeff0+1;
                 addresscoeff1=addresscoeff0+1;
                 addresstone=addresstone+1;
                 computestate=3'b001;
                 computecount=computecount+1;
                 end
            end
     3'b010: begin
             computestate=3'b010;
             end       
     endcase
     end
            
   // always@(posedge clk_div)
   // clk_div2=~clk_div2;
    
   always@(posedge clk_div) begin
   if(rst==1) begin
        state=3'b000;
        computestate=3'b010;
        computecount=3'b000;
        count=0;    end
    end
    

//    assign cordicwave0=wave0[15:8];
//    assign cordicwave1=wave1[15:8];
//    assign addressofbram=addresssine;
//    assign addressofbramcompute=addresssinecompute;
//    assign bram0content=dout0;
//    assign bram1content=dout1;
//    assign filtered0=a;
//    assign filtered1=b;
    
endmodule
