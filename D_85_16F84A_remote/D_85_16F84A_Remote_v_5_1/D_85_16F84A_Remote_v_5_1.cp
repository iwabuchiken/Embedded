#line 1 "C:/WORKS/WS/Embedded/D_85_16F84A_remote/D_85_16F84A_Remote_v_5_1/D_85_16F84A_Remote_v_5_1.c"
#line 15 "C:/WORKS/WS/Embedded/D_85_16F84A_remote/D_85_16F84A_Remote_v_5_1/D_85_16F84A_Remote_v_5_1.c"
 unsigned short int  color;

 unsigned short int  LED_FLAG = 1;

void _pulse(int num)
{
 int i;

 for(i = 0; i < num; i++)
 {

 PORTA = 0x01; Delay_ms(1);

 PORTA = 0x00; Delay_ms(1);

 }

}

void _while_PORTB_0x01(int num)
{

 while((PORTB & 0x01) == num)
 {

 if(TMR0 == 255)
 {


 _pulse(3);


 return;

 }

 }

 return;

}

void interrupt(void)
{
#line 62 "C:/WORKS/WS/Embedded/D_85_16F84A_remote/D_85_16F84A_Remote_v_5_1/D_85_16F84A_Remote_v_5_1.c"
  unsigned short int  i;
  unsigned short int  custom_code_a, custom_code_b;
  unsigned short int  data_code_a, data_code_b;

  unsigned short int  result;

 INTCON &= 0x7F;
 INTCON &= 0xEF;
 INTCON &= 0xFD;
#line 75 "C:/WORKS/WS/Embedded/D_85_16F84A_remote/D_85_16F84A_Remote_v_5_1/D_85_16F84A_Remote_v_5_1.c"
 TMR0 = 0;






 _while_PORTB_0x01(0);
#line 110 "C:/WORKS/WS/Embedded/D_85_16F84A_remote/D_85_16F84A_Remote_v_5_1/D_85_16F84A_Remote_v_5_1.c"
 if(TMR0 < 156)
 {

 INTCON |= 0x10;
 INTCON |= 0x80;


 PORTA = 0x01;
 Delay_ms(1);
 PORTA = 0x00;

 return;










 } else if (TMR0 > 196) {

 INTCON |= 0x10;
 INTCON |= 0x80;


 _pulse(2);

 }



 if(LED_FLAG == 1)
 {

 PORTA = 0x01;

 LED_FLAG *= -1;

 } else {


 PORTA = 0x00;

 LED_FLAG *= -1;

 }
#line 227 "C:/WORKS/WS/Embedded/D_85_16F84A_remote/D_85_16F84A_Remote_v_5_1/D_85_16F84A_Remote_v_5_1.c"
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
