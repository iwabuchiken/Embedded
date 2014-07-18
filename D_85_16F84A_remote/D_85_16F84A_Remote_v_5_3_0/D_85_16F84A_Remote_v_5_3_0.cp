#line 1 "C:/WORKS/WS/Embedded/D_85_16F84A_remote/D_85_16F84A_Remote_v_5_3_0/D_85_16F84A_Remote_v_5_3_0.c"


void main(void)
{
  unsigned short int  i;
  unsigned short int  custom_code_a, custom_code_b;
  unsigned short int  data_code_a, data_code_b;


 TRISA = 0x00;
 PORTA = 0x00;

 TRISB = 0x00;
 PORTB = 0x00;

 OPTION_REG &= 0xDF;
 OPTION_REG &= 0xF0;
 OPTION_REG |= 0x07;

 custom_code_a = 0xFF;
 custom_code_b = 0x00;
 data_code_a = 0x00;
 data_code_b = ~data_code_a;

 while(1)
 {
#line 30 "C:/WORKS/WS/Embedded/D_85_16F84A_remote/D_85_16F84A_Remote_v_5_3_0/D_85_16F84A_Remote_v_5_3_0.c"
 TMR0 = 0;

 while(TMR0 < 176)
 {

 PORTA = 0x01;
 Delay_us(9);

 PORTA = 0x00;
 Delay_us(17);

 }

 TMR0 = 0;
 PORTA = 0x00;

 while(TMR0 < 88)
 {

 }
#line 59 "C:/WORKS/WS/Embedded/D_85_16F84A_remote/D_85_16F84A_Remote_v_5_3_0/D_85_16F84A_Remote_v_5_3_0.c"
 }

}
