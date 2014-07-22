#line 1 "C:/WORKS/WS/Embedded/D_85_16F84A_remote/D_85_16F84A_Remote_v_5_3_2/D_85_16F84A_Remote_v_5_3_2.c"
#line 20 "C:/WORKS/WS/Embedded/D_85_16F84A_remote/D_85_16F84A_Remote_v_5_3_2/D_85_16F84A_Remote_v_5_3_2.c"
 unsigned short int  color;
 unsigned short int  LED_FLAG = 1;

 unsigned short int  i;
 unsigned short int  custom_code_a, custom_code_b;
 unsigned short int  data_code_a, data_code_b;

 unsigned short int  result;


void _pulse(int num)
{
 int i;

 for(i = 0; i < num; i++)
 {

 PORTA = 0x01; Delay_ms(1);

 PORTA = 0x00; Delay_ms(1);

 }

}

void _pulse_u(int num)
{
 int i;

 for(i = 0; i < num; i++)
 {

 PORTA = 0x01; Delay_us(500);

 PORTA = 0x00; Delay_us(500);

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
#line 87 "C:/WORKS/WS/Embedded/D_85_16F84A_remote/D_85_16F84A_Remote_v_5_3_2/D_85_16F84A_Remote_v_5_3_2.c"
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






 if (custom_code_a == 0x0A) {

 _pulse_u(1);

 } else {

 _pulse_u(2);

 }
#line 164 "C:/WORKS/WS/Embedded/D_85_16F84A_remote/D_85_16F84A_Remote_v_5_3_2/D_85_16F84A_Remote_v_5_3_2.c"
}

void _custom_lower(void)
{

  unsigned short int  bit_len = 4;

 custom_code_a = 0x00;



 for(i = 0; i < bit_len; i++)
 {
  TMR0 = 0 ;

 while((PORTB & 0x01) == 0)
 {

  if(TMR0 == 255) break ;

 }

 while((PORTB & 0x01) == 1)
 {

  if(TMR0 == 255) break ;

 }

 if (TMR0 < 33)
 {

 custom_code_a &= ~(0x01 << i);

 }
 else
 {

 custom_code_a |= (0x01 << i);

 }

 }








}

void interrupt(void)
{
#line 228 "C:/WORKS/WS/Embedded/D_85_16F84A_remote/D_85_16F84A_Remote_v_5_3_2/D_85_16F84A_Remote_v_5_3_2.c"
 INTCON &= 0x7F;
 INTCON &= 0xEF;
 INTCON &= 0xFD;
#line 243 "C:/WORKS/WS/Embedded/D_85_16F84A_remote/D_85_16F84A_Remote_v_5_3_2/D_85_16F84A_Remote_v_5_3_2.c"
 TMR0 = 0;
#line 253 "C:/WORKS/WS/Embedded/D_85_16F84A_remote/D_85_16F84A_Remote_v_5_3_2/D_85_16F84A_Remote_v_5_3_2.c"
 _while_PORTB_0x01(0);










 result = _judge_TMR_(156, 196);

 if (result ==  0 ) {



 return;

 }
#line 284 "C:/WORKS/WS/Embedded/D_85_16F84A_remote/D_85_16F84A_Remote_v_5_3_2/D_85_16F84A_Remote_v_5_3_2.c"
 TMR0 = 0;






 _while_PORTB_0x01(1);






 result = _judge_TMR_(68, 108);

 if (result ==  0 ) {



 return;

 }






 _custom_lower();






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
