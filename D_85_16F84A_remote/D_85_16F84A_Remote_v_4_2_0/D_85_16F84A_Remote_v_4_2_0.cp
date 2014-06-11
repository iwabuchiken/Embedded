#line 1 "C:/WORKS/WS/Embedded/D_85_16F84A_remote/D_85_16F84A_Remote_v_4_2_0/D_85_16F84A_Remote_v_4_2_0.c"
#line 11 "C:/WORKS/WS/Embedded/D_85_16F84A_remote/D_85_16F84A_Remote_v_4_2_0/D_85_16F84A_Remote_v_4_2_0.c"
 unsigned short int  color;

 unsigned short int  LED_FLAG = 1;

void interrupt(void)
{
  unsigned short int  i;
  unsigned short int  custom_code_a, custom_code_b;
  unsigned short int  data_code_a, data_code_b;

 INTCON &= 0x7F;
 INTCON &= 0xEF;
 INTCON &= 0xFD;


 if(LED_FLAG == 1)
 {

 PORTA = 0x01;

 LED_FLAG *= -1;

 } else {


 PORTA = 0x00;

 LED_FLAG *= -1;

 }
#line 123 "C:/WORKS/WS/Embedded/D_85_16F84A_remote/D_85_16F84A_Remote_v_4_2_0/D_85_16F84A_Remote_v_4_2_0.c"
 INTCON |= 0x10;
 INTCON |= 0x80;

}


void main(void)
{


 TRISA = 0x00;
 PORTA = 0x00;

 TRISB = 0xFF;

 OPTION_REG &= 0x7F;
 OPTION_REG &= 0xBF;
 OPTION_REG &= 0xDF;

 OPTION_REG &= 0xF0;
 OPTION_REG |= 0x07;







 INTCON |= 0x10;
 INTCON |= 0x80;

 while(1)
 {




 }

}
