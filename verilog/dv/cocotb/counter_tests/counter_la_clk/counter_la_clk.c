#include <common.h>
#include "../common/common.h"
void main(){
    // Enable managment gpio as output to use as indicator for finishing configuration  
    mgmt_gpio_o_enable();
    mgmt_gpio_wr(0);
    enable_hk_spi(0); // disable housekeeping spi
    // configure all gpios as  user out then chenge gpios from 32 to 37 before loading this configurations
    configure_all_gpios(GPIO_MODE_USER_STD_OUT_MONITORED);
    configure_gpio(36, GPIO_MODE_MGMT_STD_INPUT_PULLDOWN);
    configure_gpio(37, GPIO_MODE_MGMT_STD_INPUT_PULLDOWN);
    gpio_config_load(); // load the configuration 
    enable_user_interface();
    // configure la 64 (clk enable by la) as output from cpu
    // writing 1 in bit 64(first bit in reg 2) to reset 
    set_la_reg(0,0);
    set_la_oen(0,0xBFFFFFFF);
    mgmt_gpio_wr(1); // configuration finished 
   
    for (int i = 0; i < 7; i++){
        set_la_reg(0,0x40000000); // clk pose edge
        mgmt_gpio_wr(0); 
        set_la_reg(0,0);// clk negative edge
        mgmt_gpio_wr(1); 
        }
    return;
}