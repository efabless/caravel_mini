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

    mgmt_gpio_wr(1); // configuration finished 
    
    set_la_reg(0,7);
    set_la_oen(0,0xC0000000);
    set_la_oen(0,0xFFFFFFFF);

    return;
}
