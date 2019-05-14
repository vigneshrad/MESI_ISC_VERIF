//EE382M-Verification of Digital Systems
//Project - Formal Property Verification
//
//
//Modules - 
//SystemVerilog Properties for the module - 
`include "mesi_isc_define.v"
`include  "mesi_isc_tb_define.v"

module mesi_isc_props(
     clk,
     rst,
     mbus_cmd3_i,
     mbus_cmd2_i,
     mbus_cmd1_i,
     mbus_cmd0_i,
     mbus_addr3_i,
     mbus_addr2_i,
     mbus_addr1_i,
     mbus_addr0_i,
     cbus_ack3_i,
     cbus_ack2_i,
     cbus_ack1_i,
     cbus_ack0_i,
     cbus_addr_o,
     cbus_cmd3_o,
     cbus_cmd2_o,
     cbus_cmd1_o,
     cbus_cmd0_o,
     mbus_ack3_o,
     mbus_ack2_o,
     mbus_ack1_o,
     mbus_ack0_o
);

parameter
  CBUS_CMD_WIDTH           = 3,
  ADDR_WIDTH               = 32,
  BROAD_TYPE_WIDTH         = 2,
  BROAD_ID_WIDTH           = 5,
  BROAD_REQ_FIFO_SIZE      = 4,
  BROAD_REQ_FIFO_SIZE_LOG2 = 2,
  MBUS_CMD_WIDTH           = 3,
  BREQ_FIFO_SIZE           = 2,
  BREQ_FIFO_SIZE_LOG2      = 1;

  input                       clk;
  input                       rst;
  input [MBUS_CMD_WIDTH-1:0]  mbus_cmd3_i;
  input [MBUS_CMD_WIDTH-1:0]  mbus_cmd2_i;
  input [MBUS_CMD_WIDTH-1:0]  mbus_cmd1_i;
  input [MBUS_CMD_WIDTH-1:0]  mbus_cmd0_i;
  input [ADDR_WIDTH-1:0]      mbus_addr3_i;
  input [ADDR_WIDTH-1:0]      mbus_addr2_i;
  input [ADDR_WIDTH-1:0]      mbus_addr1_i;
  input [ADDR_WIDTH-1:0]      mbus_addr0_i;
  input                       cbus_ack3_i;
  input                       cbus_ack2_i;
  input                       cbus_ack1_i;
  input                       cbus_ack0_i;
  input [ADDR_WIDTH-1:0]      cbus_addr_o;
  input [CBUS_CMD_WIDTH-1:0]  cbus_cmd3_o;
  input [CBUS_CMD_WIDTH-1:0]  cbus_cmd2_o;
  input [CBUS_CMD_WIDTH-1:0]  cbus_cmd1_o;
  input [CBUS_CMD_WIDTH-1:0]  cbus_cmd0_o;
  input                       mbus_ack3_o;
  input                       mbus_ack2_o;
  input                       mbus_ack1_o;
  input                       mbus_ack0_o;

//formal properties to be asserted, covered and assumed

//Reset values for output signals from the MESI Intersection Controller

mbus_ack_reset0: assert property(@(posedge clk) $past(rst,1) |-> !$past(mbus_ack0_o,1));
mbus_ack_reset1: assert property(@(posedge clk) $past(rst,1) |-> !$past(mbus_ack1_o,1));
mbus_ack_reset2: assert property(@(posedge clk) $past(rst,1) |-> !$past(mbus_ack2_o,1));
mbus_ack_reset3: assert property(@(posedge clk) $past(rst,1) |-> !$past(mbus_ack3_o,1));

cbus_cmd_reset0: assert property(@(posedge clk) $past(rst,1) |-> $past(cbus_cmd0_o,1)==`MESI_ISC_CBUS_CMD_NOP);
cbus_cmd_reset1: assert property(@(posedge clk) $past(rst,1) |-> $past(cbus_cmd1_o,1)==`MESI_ISC_CBUS_CMD_NOP);
cbus_cmd_reset2: assert property(@(posedge clk) $past(rst,1) |-> $past(cbus_cmd2_o,1)==`MESI_ISC_CBUS_CMD_NOP);
cbus_cmd_reset3: assert property(@(posedge clk) $past(rst,1) |-> $past(cbus_cmd3_o,1)==`MESI_ISC_CBUS_CMD_NOP);

cbus_addr_reset: assert property(@(posedge clk) $past(rst,1) |-> $past(cbus_addr_o,1)==32'd0);

//assume properties for mbus_cmd_i - input from CPU

assume_mbus_cmd0_i: assume property(@(posedge clk) mbus_cmd0_i inside {3'd0,3'd1,3'd2,3'd3,3'd4});
assume_mbus_cmd1_i: assume property(@(posedge clk) mbus_cmd1_i inside {3'd0,3'd1,3'd2,3'd3,3'd4});
assume_mbus_cmd2_i: assume property(@(posedge clk) mbus_cmd2_i inside {3'd0,3'd1,3'd2,3'd3,3'd4});
assume_mbus_cmd3_i: assume property(@(posedge clk) mbus_cmd3_i inside {3'd0,3'd1,3'd2,3'd3,3'd4});

assume_mbus_cmd0_reset: assume property(@(posedge clk) $fell(rst) |-> mbus_cmd0_i==`MESI_ISC_MBUS_CMD_NOP ##1 $changed(mbus_cmd0_i));
assume_mbus_cmd1_reset: assume property(@(posedge clk) $fell(rst) |-> mbus_cmd1_i==`MESI_ISC_MBUS_CMD_NOP ##1 $changed(mbus_cmd1_i));
assume_mbus_cmd2_reset: assume property(@(posedge clk) $fell(rst) |-> mbus_cmd2_i==`MESI_ISC_MBUS_CMD_NOP ##1 $changed(mbus_cmd2_i));
assume_mbus_cmd3_reset: assume property(@(posedge clk) $fell(rst) |-> mbus_cmd3_i==`MESI_ISC_MBUS_CMD_NOP ##1 $changed(mbus_cmd3_i));

//assume properties for mbus_addr_i - input from CPU

assume_mbus_addr0_i: assume property(@(posedge clk) mbus_addr0_i inside {32'd0, 32'd1, 32'd2, 32'd3, 32'd4, 32'd5, 32'd6, 32'd7, 32'd8, 32'd9});
assume_mbus_addr1_i: assume property(@(posedge clk) mbus_addr1_i inside {32'd0, 32'd1, 32'd2, 32'd3, 32'd4, 32'd5, 32'd6, 32'd7, 32'd8, 32'd9});
assume_mbus_addr2_i: assume property(@(posedge clk) mbus_addr2_i inside {32'd0, 32'd1, 32'd2, 32'd3, 32'd4, 32'd5, 32'd6, 32'd7, 32'd8, 32'd9});
assume_mbus_addr3_i: assume property(@(posedge clk) mbus_addr3_i inside {32'd0, 32'd1, 32'd2, 32'd3, 32'd4, 32'd5, 32'd6, 32'd7, 32'd8, 32'd9});

assume_mbus_addr_stable0:assume property(@(posedge clk) (mbus_cmd0_i inside {3,4}) && mesi_isc_breq_fifos.fifo_0.status_full_o |-> $stable(mbus_addr0_i)[*0:$] ##1 !mesi_isc_breq_fifos.fifo_0.status_full_o);
assume_mbus_addr_stable1:assume property(@(posedge clk) (mbus_cmd1_i inside {3,4}) && mesi_isc_breq_fifos.fifo_1.status_full_o |-> $stable(mbus_addr1_i)[*0:$] ##1 !mesi_isc_breq_fifos.fifo_1.status_full_o);
assume_mbus_addr_stable2:assume property(@(posedge clk) (mbus_cmd2_i inside {3,4}) && mesi_isc_breq_fifos.fifo_2.status_full_o |-> $stable(mbus_addr2_i)[*0:$] ##1 !mesi_isc_breq_fifos.fifo_2.status_full_o);
assume_mbus_addr_stable3:assume property(@(posedge clk) (mbus_cmd3_i inside {3,4}) && mesi_isc_breq_fifos.fifo_3.status_full_o |-> $stable(mbus_addr3_i)[*0:$] ##1 !mesi_isc_breq_fifos.fifo_3.status_full_o);


//assume properties for the cbus_ack - input from CPU

assume_cbus_ack01_i:assume property(@(posedge clk) cbus_cmd0_o inside {1,2} |=> cbus_ack0_i ##1 !cbus_ack0_i);
assume_cbus_ack11_i:assume property(@(posedge clk) cbus_cmd1_o inside {1,2} |=> cbus_ack1_i ##1 !cbus_ack1_i);
assume_cbus_ack21_i:assume property(@(posedge clk) cbus_cmd2_o inside {1,2} |=> cbus_ack2_i ##1 !cbus_ack2_i);
assume_cbus_ack31_i:assume property(@(posedge clk) cbus_cmd3_o inside {1,2} |=> cbus_ack3_i ##1 !cbus_ack3_i);

assume_cbus_ack02_i:assume property(@(posedge clk) cbus_cmd0_o inside {0,3,4} |-> !cbus_ack0_i);
assume_cbus_ack12_i:assume property(@(posedge clk) cbus_cmd1_o inside {0,3,4} |-> !cbus_ack1_i);
assume_cbus_ack22_i:assume property(@(posedge clk) cbus_cmd2_o inside {0,3,4} |-> !cbus_ack2_i);
assume_cbus_ack32_i:assume property(@(posedge clk) cbus_cmd3_o inside {0,3,4} |-> !cbus_ack3_i);

//assume properties for mbus_cmd_i

assume_mbus_stable_full0:assume property(@(posedge clk) (mbus_cmd0_i inside {3,4}) && mesi_isc_breq_fifos.fifo_0.status_full_o |-> $stable(mbus_cmd0_i)[*0:$] ##1 !mesi_isc_breq_fifos.fifo_0.status_full_o);
assume_mbus_stable_full1:assume property(@(posedge clk) (mbus_cmd1_i inside {3,4}) && mesi_isc_breq_fifos.fifo_1.status_full_o |-> $stable(mbus_cmd1_i)[*0:$] ##1 !mesi_isc_breq_fifos.fifo_1.status_full_o);
assume_mbus_stable_full2:assume property(@(posedge clk) (mbus_cmd2_i inside {3,4}) && mesi_isc_breq_fifos.fifo_2.status_full_o |-> $stable(mbus_cmd2_i)[*0:$] ##1 !mesi_isc_breq_fifos.fifo_2.status_full_o);
assume_mbus_stable_full3:assume property(@(posedge clk) (mbus_cmd3_i inside {3,4}) && mesi_isc_breq_fifos.fifo_3.status_full_o |-> $stable(mbus_cmd3_i)[*0:$] ##1 !mesi_isc_breq_fifos.fifo_3.status_full_o);

assume_mbus_stable0:assume property(@(posedge clk) mbus_cmd0_i inside {3,4}  |=> (mbus_cmd0_i == `MESI_ISC_MBUS_CMD_NOP));
assume_mbus_stable1:assume property(@(posedge clk) mbus_cmd1_i inside {3,4}  |=> (mbus_cmd1_i == `MESI_ISC_MBUS_CMD_NOP));
assume_mbus_stable2:assume property(@(posedge clk) mbus_cmd2_i inside {3,4}  |=> (mbus_cmd2_i == `MESI_ISC_MBUS_CMD_NOP));
assume_mbus_stable3:assume property(@(posedge clk) mbus_cmd3_i inside {3,4}  |=> (mbus_cmd3_i == `MESI_ISC_MBUS_CMD_NOP));

//Assertions

  //assert properties for the mbus_ack_o

  mbus_cmd0_assert:assert property(@(posedge clk) mbus_cmd0_i inside {3,4} |=>  $rose(mbus_ack0_o) ##1 $fell(mbus_ack0_o)); //POSSIBLE BUG

mbus_cmd1_assert:assert property(@(posedge clk) mbus_cmd1_i inside {3,4} |=>  $rose(mbus_ack1_o) ##1 $fell(mbus_ack1_o));
mbus_cmd2_assert:assert property(@(posedge clk) mbus_cmd2_i inside {3,4} |=>  $rose(mbus_ack2_o) ##1 $fell(mbus_ack2_o));
mbus_cmd3_assert:assert property(@(posedge clk) mbus_cmd3_i inside {3,4} |=>  $rose(mbus_ack3_o) ##1 $fell(mbus_ack3_o));

//assert property for Write Broadcast

wr_broadcast_assert0:assert property(@(posedge clk) mbus_cmd0_i==`MESI_ISC_MBUS_CMD_WR_BROAD |-> ##[1:$] (cbus_cmd1_o==`MESI_ISC_CBUS_CMD_WR_SNOOP && cbus_cmd2_o==`MESI_ISC_CBUS_CMD_WR_SNOOP && cbus_cmd3_o==`MESI_ISC_CBUS_CMD_WR_SNOOP));
wr_broadcast_assert1:assert property(@(posedge clk) mbus_cmd1_i==`MESI_ISC_MBUS_CMD_WR_BROAD |-> ##[1:$] (cbus_cmd0_o==`MESI_ISC_CBUS_CMD_WR_SNOOP && cbus_cmd2_o==`MESI_ISC_CBUS_CMD_WR_SNOOP && cbus_cmd3_o==`MESI_ISC_CBUS_CMD_WR_SNOOP));
wr_broadcast_assert2:assert property(@(posedge clk) mbus_cmd2_i==`MESI_ISC_MBUS_CMD_WR_BROAD |-> ##[1:$] (cbus_cmd0_o==`MESI_ISC_CBUS_CMD_WR_SNOOP && cbus_cmd1_o==`MESI_ISC_CBUS_CMD_WR_SNOOP && cbus_cmd3_o==`MESI_ISC_CBUS_CMD_WR_SNOOP));
wr_broadcast_assert3:assert property(@(posedge clk) mbus_cmd3_i==`MESI_ISC_MBUS_CMD_WR_BROAD |-> ##[1:$] (cbus_cmd0_o==`MESI_ISC_CBUS_CMD_WR_SNOOP && cbus_cmd1_o==`MESI_ISC_CBUS_CMD_WR_SNOOP && cbus_cmd2_o==`MESI_ISC_CBUS_CMD_WR_SNOOP));

//assert property for Read Broadcast

rd_broadcast_assert0:assert property(@(posedge clk) mbus_cmd0_i==`MESI_ISC_MBUS_CMD_RD_BROAD |-> ##[1:$] (cbus_cmd1_o==`MESI_ISC_CBUS_CMD_RD_SNOOP && cbus_cmd2_o==`MESI_ISC_CBUS_CMD_RD_SNOOP && cbus_cmd3_o==`MESI_ISC_CBUS_CMD_RD_SNOOP));
rd_broadcast_assert1:assert property(@(posedge clk) mbus_cmd1_i==`MESI_ISC_MBUS_CMD_RD_BROAD |-> ##[1:$] (cbus_cmd0_o==`MESI_ISC_CBUS_CMD_RD_SNOOP && cbus_cmd2_o==`MESI_ISC_CBUS_CMD_RD_SNOOP && cbus_cmd3_o==`MESI_ISC_CBUS_CMD_RD_SNOOP));
rd_broadcast_assert2:assert property(@(posedge clk) mbus_cmd2_i==`MESI_ISC_MBUS_CMD_RD_BROAD |-> ##[1:$] (cbus_cmd0_o==`MESI_ISC_CBUS_CMD_RD_SNOOP && cbus_cmd1_o==`MESI_ISC_CBUS_CMD_RD_SNOOP && cbus_cmd3_o==`MESI_ISC_CBUS_CMD_RD_SNOOP));
rd_broadcast_assert3:assert property(@(posedge clk) mbus_cmd3_i==`MESI_ISC_MBUS_CMD_RD_BROAD |-> ##[1:$] (cbus_cmd0_o==`MESI_ISC_CBUS_CMD_RD_SNOOP && cbus_cmd1_o==`MESI_ISC_CBUS_CMD_RD_SNOOP && cbus_cmd2_o==`MESI_ISC_CBUS_CMD_RD_SNOOP));

//assertions to check validity of cbus_cmd

assert_cbus_cmd_unknown0:assert property(@(posedge clk) !$isunknown(cbus_cmd0_o));
assert_cbus_cmd_unknown1:assert property(@(posedge clk) !$isunknown(cbus_cmd1_o));
assert_cbus_cmd_unknown2:assert property(@(posedge clk) !$isunknown(cbus_cmd2_o));
assert_cbus_cmd_unknown3:assert property(@(posedge clk) !$isunknown(cbus_cmd3_o));

assert_cbus_cmd_valid0:assert property(@(posedge clk) $changed(cbus_cmd0_o) |=> cbus_cmd0_o inside {0,1,2,3,4});
assert_cbus_cmd_valid1:assert property(@(posedge clk) $changed(cbus_cmd1_o) |=> cbus_cmd1_o inside {0,1,2,3,4});
assert_cbus_cmd_valid2:assert property(@(posedge clk) $changed(cbus_cmd2_o) |=> cbus_cmd2_o inside {0,1,2,3,4});
assert_cbus_cmd_valid3:assert property(@(posedge clk) $changed(cbus_cmd3_o) |=> cbus_cmd3_o inside {0,1,2,3,4});

//assertions to check write broadcast -> write enable sequence

assert_wr_en0:assert property(@(posedge clk) mbus_cmd0_i==`MESI_ISC_MBUS_CMD_WR_BROAD |-> ##[1:$] (cbus_ack1_i && cbus_ack2_i && cbus_ack3_i) ##1 cbus_cmd0_o==`MESI_ISC_CBUS_CMD_EN_WR);
assert_wr_en1:assert property(@(posedge clk) mbus_cmd1_i==`MESI_ISC_MBUS_CMD_WR_BROAD |-> ##[1:$] (cbus_ack0_i && cbus_ack2_i && cbus_ack3_i) ##1 cbus_cmd1_o==`MESI_ISC_CBUS_CMD_EN_WR);
assert_wr_en2:assert property(@(posedge clk) mbus_cmd2_i==`MESI_ISC_MBUS_CMD_WR_BROAD |-> ##[1:$] (cbus_ack0_i && cbus_ack1_i && cbus_ack3_i) ##1 cbus_cmd2_o==`MESI_ISC_CBUS_CMD_EN_WR);
assert_wr_en3:assert property(@(posedge clk) mbus_cmd3_i==`MESI_ISC_MBUS_CMD_WR_BROAD |-> ##[1:$] (cbus_ack0_i && cbus_ack1_i && cbus_ack2_i) ##1 cbus_cmd3_o==`MESI_ISC_CBUS_CMD_EN_WR);

//assertions to check read broadcast -> read enable sequence

assert_rd_en0:assert property(@(posedge clk) mbus_cmd0_i==`MESI_ISC_MBUS_CMD_RD_BROAD |-> ##[1:$] (cbus_ack1_i && cbus_ack2_i && cbus_ack3_i) ##1 cbus_cmd0_o==`MESI_ISC_CBUS_CMD_EN_RD);
assert_rd_en1:assert property(@(posedge clk) mbus_cmd1_i==`MESI_ISC_MBUS_CMD_RD_BROAD |-> ##[1:$] (cbus_ack0_i && cbus_ack2_i && cbus_ack3_i) ##1 cbus_cmd1_o==`MESI_ISC_CBUS_CMD_EN_RD);
assert_rd_en2:assert property(@(posedge clk) mbus_cmd2_i==`MESI_ISC_MBUS_CMD_RD_BROAD |-> ##[1:$] (cbus_ack0_i && cbus_ack1_i && cbus_ack3_i) ##1 cbus_cmd2_o==`MESI_ISC_CBUS_CMD_EN_RD);
assert_rd_en3:assert property(@(posedge clk) mbus_cmd3_i==`MESI_ISC_MBUS_CMD_RD_BROAD |-> ##[1:$] (cbus_ack0_i && cbus_ack1_i && cbus_ack2_i) ##1 cbus_cmd3_o==`MESI_ISC_CBUS_CMD_EN_RD);

//assertions to check if the address corresponding to a write broadcast is being broadcasted consistently by the MESI intersection controller

property assert_caddr_check0_wr;
logic [ADDR_WIDTH-1:0] addr;
@(posedge clk) (mbus_cmd0_i==`MESI_ISC_MBUS_CMD_WR_BROAD,addr=mbus_addr0_i) |-> ##[1:$] (cbus_ack1_i && cbus_ack2_i && cbus_ack3_i) ##1 cbus_addr_o==addr;
endproperty

property assert_caddr_check1_wr;
logic [ADDR_WIDTH-1:0] addr;
@(posedge clk) (mbus_cmd1_i==`MESI_ISC_MBUS_CMD_WR_BROAD,addr=mbus_addr1_i) |-> ##[1:$] (cbus_ack0_i && cbus_ack2_i && cbus_ack3_i) ##1 cbus_addr_o==addr;
endproperty

property assert_caddr_check2_wr;
logic [ADDR_WIDTH-1:0] addr;
@(posedge clk) (mbus_cmd2_i==`MESI_ISC_MBUS_CMD_WR_BROAD,addr=mbus_addr2_i) |-> ##[1:$] (cbus_ack0_i && cbus_ack1_i && cbus_ack3_i) ##1 cbus_addr_o==addr;
endproperty

property assert_caddr_check3_wr;
logic [ADDR_WIDTH-1:0] addr;
@(posedge clk) (mbus_cmd3_i==`MESI_ISC_MBUS_CMD_WR_BROAD,addr=mbus_addr3_i) |-> ##[1:$] (cbus_ack0_i && cbus_ack1_i && cbus_ack2_i) ##1 cbus_addr_o==addr;
endproperty

assert property(assert_caddr_check0_wr);
assert property(assert_caddr_check1_wr);
assert property(assert_caddr_check2_wr);
assert property(assert_caddr_check3_wr);

//assertions to check if the address corresponding to a read broadcast is being broadcasted consistently by the MESI intersection controller

property assert_caddr_check0_rd;
logic [ADDR_WIDTH-1:0] addr;
@(posedge clk) (mbus_cmd0_i==`MESI_ISC_MBUS_CMD_RD_BROAD,addr=mbus_addr0_i) |-> ##[1:$] (cbus_ack1_i && cbus_ack2_i && cbus_ack3_i) ##1 cbus_addr_o==addr;
endproperty

property assert_caddr_check1_rd;
logic [ADDR_WIDTH-1:0] addr;
@(posedge clk) (mbus_cmd1_i==`MESI_ISC_MBUS_CMD_RD_BROAD,addr=mbus_addr1_i) |-> ##[1:$] (cbus_ack0_i && cbus_ack2_i && cbus_ack3_i) ##1 cbus_addr_o==addr;
endproperty

property assert_caddr_check2_rd;
logic [ADDR_WIDTH-1:0] addr;
@(posedge clk) (mbus_cmd2_i==`MESI_ISC_MBUS_CMD_RD_BROAD,addr=mbus_addr2_i) |-> ##[1:$] (cbus_ack0_i && cbus_ack1_i && cbus_ack3_i) ##1 cbus_addr_o==addr;
endproperty

property assert_caddr_check3_rd;
logic [ADDR_WIDTH-1:0] addr;
@(posedge clk) (mbus_cmd3_i==`MESI_ISC_MBUS_CMD_RD_BROAD,addr=mbus_addr3_i) |-> ##[1:$] (cbus_ack0_i && cbus_ack1_i && cbus_ack2_i) ##1 cbus_addr_o==addr;
endproperty

assert property(assert_caddr_check0_rd);
assert property(assert_caddr_check1_rd);
assert property(assert_caddr_check2_rd);
assert property(assert_caddr_check3_rd);

//Cover properties to check coverage

nop0:cover property(@(posedge clk) $changed(mbus_cmd0_i) && mbus_cmd0_i==`MESI_ISC_MBUS_CMD_NOP);
nop1:cover property(@(posedge clk) $changed(mbus_cmd1_i) && mbus_cmd1_i==`MESI_ISC_MBUS_CMD_NOP);
nop2:cover property(@(posedge clk) $changed(mbus_cmd2_i) && mbus_cmd2_i==`MESI_ISC_MBUS_CMD_NOP);
nop3:cover property(@(posedge clk) $changed(mbus_cmd3_i) && mbus_cmd3_i==`MESI_ISC_MBUS_CMD_NOP);

wr_broad0:cover property(@(posedge clk) $changed(mbus_cmd0_i) && mbus_cmd0_i==`MESI_ISC_MBUS_CMD_WR_BROAD);
wr_broad1:cover property(@(posedge clk) $changed(mbus_cmd1_i) && mbus_cmd1_i==`MESI_ISC_MBUS_CMD_WR_BROAD);
wr_broad2:cover property(@(posedge clk) $changed(mbus_cmd2_i) && mbus_cmd2_i==`MESI_ISC_MBUS_CMD_WR_BROAD);
wr_broad3:cover property(@(posedge clk) $changed(mbus_cmd3_i) && mbus_cmd3_i==`MESI_ISC_MBUS_CMD_WR_BROAD);

rd_broad0:cover property(@(posedge clk) $changed(mbus_cmd0_i) && mbus_cmd0_i==`MESI_ISC_MBUS_CMD_RD_BROAD);
rd_broad1:cover property(@(posedge clk) $changed(mbus_cmd1_i) && mbus_cmd1_i==`MESI_ISC_MBUS_CMD_RD_BROAD);
rd_broad2:cover property(@(posedge clk) $changed(mbus_cmd2_i) && mbus_cmd2_i==`MESI_ISC_MBUS_CMD_RD_BROAD);
rd_broad3:cover property(@(posedge clk) $changed(mbus_cmd3_i) && mbus_cmd3_i==`MESI_ISC_MBUS_CMD_RD_BROAD);

cbus_ack0:cover property(@(posedge clk) $rose(cbus_ack0_i));
cbus_ack1:cover property(@(posedge clk) $rose(cbus_ack1_i));
cbus_ack2:cover property(@(posedge clk) $rose(cbus_ack2_i));
cbus_ack3:cover property(@(posedge clk) $rose(cbus_ack3_i));

mbus_addr0:cover property(@(posedge clk) $changed(mbus_addr0_i));
mbus_addr1:cover property(@(posedge clk) $changed(mbus_addr1_i));
mbus_addr2:cover property(@(posedge clk) $changed(mbus_addr2_i));
mbus_addr3:cover property(@(posedge clk) $changed(mbus_addr3_i));

endmodule

module Wrapper;

//Bind the 'mesi_isc_props' module with the 'mesi_isc' module to instantiate the properties
bind mesi_isc mesi_isc_props #(
   .CBUS_CMD_WIDTH(CBUS_CMD_WIDTH),
   .ADDR_WIDTH(ADDR_WIDTH),
   .BROAD_TYPE_WIDTH(BROAD_TYPE_WIDTH),
   .BROAD_ID_WIDTH(BROAD_ID_WIDTH),
   .BROAD_REQ_FIFO_SIZE(BROAD_REQ_FIFO_SIZE),
   .BROAD_REQ_FIFO_SIZE_LOG2(BROAD_REQ_FIFO_SIZE_LOG2),
   .MBUS_CMD_WIDTH(MBUS_CMD_WIDTH),
   .BREQ_FIFO_SIZE(BREQ_FIFO_SIZE),
   .BREQ_FIFO_SIZE_LOG2(BREQ_FIFO_SIZE_LOG2)
  )
  bind_wrapper_inst(
   .clk(clk),
   .rst(rst),
   .mbus_cmd3_i(mbus_cmd3_i),
   .mbus_cmd2_i(mbus_cmd2_i),
   .mbus_cmd1_i(mbus_cmd1_i),
   .mbus_cmd0_i(mbus_cmd0_i),
   .mbus_addr3_i(mbus_addr3_i),
   .mbus_addr2_i(mbus_addr2_i),
   .mbus_addr1_i(mbus_addr1_i),
   .mbus_addr0_i(mbus_addr0_i),
   .cbus_ack3_i(cbus_ack3_i),
   .cbus_ack2_i(cbus_ack2_i),
   .cbus_ack1_i(cbus_ack1_i),
   .cbus_ack0_i(cbus_ack0_i),
   .cbus_addr_o(cbus_addr_o),
   .cbus_cmd3_o(cbus_cmd3_o),
   .cbus_cmd2_o(cbus_cmd2_o),
   .cbus_cmd1_o(cbus_cmd1_o),
   .cbus_cmd0_o(cbus_cmd0_o),
   .mbus_ack3_o(mbus_ack3_o),
   .mbus_ack2_o(mbus_ack2_o),
   .mbus_ack1_o(mbus_ack1_o),
   .mbus_ack0_o(mbus_ack0_o)
  );

endmodule
