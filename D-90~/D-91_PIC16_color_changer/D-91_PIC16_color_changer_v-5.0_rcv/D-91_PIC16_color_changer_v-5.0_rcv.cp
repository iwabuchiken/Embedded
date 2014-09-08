#line 1 "C:/WORKS/WS/Embedded/D-90~/D-91_PIC16_color_changer/D-91_PIC16_color_changer_v-5.0_rcv/D-91_PIC16_color_changer_v-5.0_rcv.c"
#line 32 "C:/WORKS/WS/Embedded/D-90~/D-91_PIC16_color_changer/D-91_PIC16_color_changer_v-5.0_rcv/D-91_PIC16_color_changer_v-5.0_rcv.c"
 unsigned short int  color;
 unsigned short int  LED_FLAG = 1;

 unsigned short int  i;
 unsigned short int  custom_code_a, custom_code_b;
 unsigned short int  data_code_a, data_code_b;

 unsigned short int  result;

 unsigned short int  bit_len;







int _read_Reader(void);
void _read_Custom(void);

void _main_Setup(void);

void _response_2(void);

void _pulse(int);
void _pulse_ms(int);






void _pulse(int num)
{
 int i;

 for(i = 0; i < num; i++)
 {

 PORTA = 0x01; Delay_ms(1);

 PORTA = 0x00; Delay_ms(1);

 }

}

void _pulse_ms(int num)
{
 int i;

 for(i = 0; i < num; i++)
 {

 PORTA = 0x01; Delay_ms(1);

 PORTA = 0x00; Delay_ms(1);

 }

}

void _pulse_500u(int num)
{
 int i;

 for(i = 0; i < num; i++)
 {

 PORTA = 0x01; Delay_us(500);

 PORTA = 0x00; Delay_us(500);

 }

}

void _pulse_u_len(int num, int duration)
{
 int i;

 for(i = 0; i < num; i++)
 {

 PORTA = 0x01; Delay_us(100);

 PORTA = 0x00; Delay_us(100);







 }

}

void _pulse_u_100(int num)
{
 int i;

 for(i = 0; i < num; i++)
 {

 PORTA = 0x01; Delay_us(100);

 PORTA = 0x00; Delay_us(100);

 }

}

void
_pulse_u_50(int num)
{
 int i;

 for(i = 0; i < num; i++)
 {

 PORTA = 0x01; Delay_us(50);

 PORTA = 0x00; Delay_us(50);

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
#line 188 "C:/WORKS/WS/Embedded/D-90~/D-91_PIC16_color_changer/D-91_PIC16_color_changer_v-5.0_rcv/D-91_PIC16_color_changer_v-5.0_rcv.c"
int _judge_TMR_(int low, int high) {

 if(TMR0 < low)
 {

 INTCON |= 0x10;
 INTCON |= 0x80;






 _pulse_u_50(3);

 return  0 ;










 } else if (TMR0 > high) {

 INTCON |= 0x10;
 INTCON |= 0x80;


 _pulse_u_50(2);


 return  0 ;

 }

 return  1 ;

}

void _response(void)
{








 if (custom_code_a == 15) {


 _pulse_u_100(6);

 } else if (custom_code_a == 8) {

 _pulse_u_100(3);

 } else if (custom_code_a == 10) {

 _pulse(2);

 } else {

 _pulse_u_100(1);

 }
#line 277 "C:/WORKS/WS/Embedded/D-90~/D-91_PIC16_color_changer/D-91_PIC16_color_changer_v-5.0_rcv/D-91_PIC16_color_changer_v-5.0_rcv.c"
}

void
_response_2(void) {

 switch(custom_code_a) {








 case 1:
 case 2:
 case 3:
 case 4:
 case 5:
 case 6:
 case 7:
 PORTA = custom_code_a;

 break;

 default: _pulse(2); break;

 }

}

void _custom_lower(void)
{



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
#line 370 "C:/WORKS/WS/Embedded/D-90~/D-91_PIC16_color_changer/D-91_PIC16_color_changer_v-5.0_rcv/D-91_PIC16_color_changer_v-5.0_rcv.c"
 INTCON &= 0x7F;
 INTCON &= 0xEF;
 INTCON &= 0xFD;






 PORTA = 0x00;






 result = _read_Reader();






 if (result ==  0 ) {



 return;

 }






 _read_Custom();
#line 423 "C:/WORKS/WS/Embedded/D-90~/D-91_PIC16_color_changer/D-91_PIC16_color_changer_v-5.0_rcv/D-91_PIC16_color_changer_v-5.0_rcv.c"
 _response_2();







 INTCON &= 0x7F;
 INTCON &= 0xEF;
 INTCON &= 0xFD;
#line 449 "C:/WORKS/WS/Embedded/D-90~/D-91_PIC16_color_changer/D-91_PIC16_color_changer_v-5.0_rcv/D-91_PIC16_color_changer_v-5.0_rcv.c"
 INTCON |= 0x10;
 INTCON |= 0x80;

}


void
main(void)
{

 _main_Setup();

 INTCON |= 0x10;
 INTCON |= 0x80;

 while(1)
 {

 PORTA = custom_code_a;







 }

}

int
_read_Reader() {






  TMR0 = 0 ;
#line 497 "C:/WORKS/WS/Embedded/D-90~/D-91_PIC16_color_changer/D-91_PIC16_color_changer_v-5.0_rcv/D-91_PIC16_color_changer_v-5.0_rcv.c"
 _while_PORTB_0x01(0);










 result = _judge_TMR_(156, 196);

 if (result ==  0 ) {



 return  0 ;

 }
#line 528 "C:/WORKS/WS/Embedded/D-90~/D-91_PIC16_color_changer/D-91_PIC16_color_changer_v-5.0_rcv/D-91_PIC16_color_changer_v-5.0_rcv.c"
  TMR0 = 0 ;






 _while_PORTB_0x01(1);






 result = _judge_TMR_(68, 108);

 if (result ==  0 ) {



 return  0 ;

 }






 return  1 ;

}

void
_read_Custom() {

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

void
_main_Setup() {


 TRISA = 0x00;
 PORTA = 0x00;

 TRISB = 0xFF;

 OPTION_REG &= 0x7F;

 OPTION_REG &= 0xBF;

 OPTION_REG &= 0xDF;
 OPTION_REG &= 0xF0;
 OPTION_REG |= 0x07;






 bit_len = 4;

 custom_code_a = 0;

}
