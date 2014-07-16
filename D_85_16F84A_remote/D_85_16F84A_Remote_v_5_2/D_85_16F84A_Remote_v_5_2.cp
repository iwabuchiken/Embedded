#line 1 "C:/WORKS/WS/Embedded/D_85_16F84A_remote/D_85_16F84A_Remote_v_5_2/D_85_16F84A_Remote_v_5_2.c"
#line 15 "C:/WORKS/WS/Embedded/D_85_16F84A_remote/D_85_16F84A_Remote_v_5_2/D_85_16F84A_Remote_v_5_2.c"
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
#line 61 "C:/WORKS/WS/Embedded/D_85_16F84A_remote/D_85_16F84A_Remote_v_5_2/D_85_16F84A_Remote_v_5_2.c"
int _judge_TMR_(int low, int high) {

 if(TMR0 < low)
 {

 INTCON |= 0x10;
 INTCON |= 0x80;






 _pulse(1);

 return  0 ;










 } else if (TMR0 > high) {

 INTCON |= 0x10;
 INTCON |= 0x80;


 _pulse(2);

 return  0 ;

 }

 return  1 ;

}

void _response(void)
{



 if(LED_FLAG == 1)
 {

 PORTA = 0x01;

 LED_FLAG *= -1;

 } else {

 PORTA = 0x00;

 LED_FLAG *= -1;

 }

}

void interrupt(void)
{
#line 130 "C:/WORKS/WS/Embedded/D_85_16F84A_remote/D_85_16F84A_Remote_v_5_2/D_85_16F84A_Remote_v_5_2.c"
  unsigned short int  i;
  unsigned short int  custom_code_a, custom_code_b;
  unsigned short int  data_code_a, data_code_b;

  unsigned short int  result;

 INTCON &= 0x7F;
 INTCON &= 0xEF;
 INTCON &= 0xFD;
#line 151 "C:/WORKS/WS/Embedded/D_85_16F84A_remote/D_85_16F84A_Remote_v_5_2/D_85_16F84A_Remote_v_5_2.c"
 TMR0 = 0;
#line 161 "C:/WORKS/WS/Embedded/D_85_16F84A_remote/D_85_16F84A_Remote_v_5_2/D_85_16F84A_Remote_v_5_2.c"
 _while_PORTB_0x01(0);










 result = _judge_TMR_(156, 196);

 if (result ==  0 ) {



 return;

 }
#line 192 "C:/WORKS/WS/Embedded/D_85_16F84A_remote/D_85_16F84A_Remote_v_5_2/D_85_16F84A_Remote_v_5_2.c"
 TMR0 = 0;






 _while_PORTB_0x01(1);






 result = _judge_TMR_(68, 108);

 if (result ==  0 ) {



 return;

 }






 _response();







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
