#line 1 "C:/WORKS/WS/Embedded/D-90~/D-91_PIC16_color_changer/D-91_PIC16_color_changer_v-1.0/D-91_PIC16_color_changer_v-1.0.c"
#line 27 "C:/WORKS/WS/Embedded/D-90~/D-91_PIC16_color_changer/D-91_PIC16_color_changer_v-1.0/D-91_PIC16_color_changer_v-1.0.c"
 unsigned short int  color;
 unsigned short int  LED_FLAG = 1;

 unsigned short int  i;
 unsigned short int  custom_code_a, custom_code_b;
 unsigned short int  data_code_a, data_code_b;

 unsigned short int  result;

 unsigned short int  bit_len = 8;

void _Opearations(void) {

 while(PORTB & 0x01 == 0x01) {

 if (PORTB & 0x02 == 0x02) {


  PORTA = 0x00 ;
  PORTA = 0x02 ;

 } else if (PORTB & 0x02 != 0x02) {

  PORTA = 0x01 ;
  PORTA = 0x00 ;

 } else {

  PORTA = 0x01 ;
  PORTA = 0x02 ;

 }

 }

}

void interrupt(void)
{
#line 75 "C:/WORKS/WS/Embedded/D-90~/D-91_PIC16_color_changer/D-91_PIC16_color_changer_v-1.0/D-91_PIC16_color_changer_v-1.0.c"
 INTCON &= 0x7F;
 INTCON &= 0xEF;
 INTCON &= 0xFD;

 _Opearations();







 INTCON |= 0x10;
 INTCON |= 0x80;

}


void main(void)
{


 TRISA = 0x00;
 PORTA = 0x00;

 TRISB = 0xFF;

 OPTION_REG &= 0x7F;
 OPTION_REG &= 0xFF;


 OPTION_REG &= 0xDF;
 OPTION_REG &= 0xF0;
 OPTION_REG |= 0x07;







 INTCON |= 0x10;
 INTCON |= 0x80;

 while(1)
 {


  PORTA = 0x00 ;


 }

}
