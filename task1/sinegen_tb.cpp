#include "Vsinegen.h"
#include "verilated.h"
#include "verilated_vcd_c.h"
#include "vbuddy.cpp"

int main(int argc, char **argv, char **env){
    int i;
    int clk;

    Verilated::commandArgs(argc, argv);
    //  init top verilog instance
    Vsinegen* top = new Vsinegen;
    //  init trace dump
    Verilated::traceEverOn(true);
    VerilatedVcdC* tfp = new VerilatedVcdC;
    top->trace (tfp, 99);
    tfp->open ("sinegen.vcd");

    // init Vbuddy
    if(vbdOpen()!=1) return (-1);
    vbdHeader("Lab 2: Sinegen");

    //initialize simulation inputs
    top->clk = 1;
    top->rst = 1;
    top->en = 0;
    top->incr = 1;


    //run simulation for many clock cycles
    for (i=0; i<1000000; i++) {
        // either simulation finished, or 'q' is pressed
        if ((Verilated::gotFinish()) || (vbdGetkey()=='q')){ 
        exit(0);                // ... exit if finish OR 'q' pressed
        }

        // dump variables in VCD files and toggle check
        for (clk = 0; clk<2; clk++){
            tfp->dump (2*i+clk);        //unit is in ps!!!
            top->clk = !top->clk;
            top->eval ();
        }

        // ++++     Seond count value to Vbuddy
        vbdPlot(int(top->dout), 0, 255);
        vbdCycle(i+1);
        // vbdHex(4, (int(top->dout)  >> 12 ) & 0xF);
        // vbdHex(3, (int(top->dout)  >> 8 ) & 0xF);
        // vbdHex(2, (int(top->dout)  >> 4 ) & 0xF);
        // vbdHex(1, int(top->dout) & 0xF);

        // ----     End of Vbuddy output section

        //change input stimuli
        top->rst = (i==15);
        top->en = vbdFlag();
        top->incr = vbdValue();
        if(Verilated::gotFinish())  exit(0);
    }

    vbdClose();
    tfp->close();
    exit(0);
}
