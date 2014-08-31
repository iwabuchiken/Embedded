#line 1 "C:/WORKS/WS/Embedded/D-90~/D-91_PIC16_color_changer/D-91_PIC16_color_changer_v-1.0/D-91_PIC16_color_changer_v-1.0.c"
#line 35 "C:/WORKS/WS/Embedded/D-90~/D-91_PIC16_color_changer/D-91_PIC16_color_changer_v-1.0/D-91_PIC16_color_changer_v-1.0.c"
void _Opearations(void) {

 while( (PORTB & 0x01) == 0x01 ) {


 if ( (PORTB & 0x03) == 0x03 ) {




  PORTA = 0x03 ;

 } else if ( (PORTB & 0x01) == 0x01  && !( (PORTB & 0x02) == 0x02 )) {


  PORTA = 0x01 ;


 } else if (!( (PORTB & 0x01) == 0x01 ) && ( (PORTB & 0x02) == 0x02 )) {



  PORTA = 0x02 ;

 } else {

  PORTA = 0x00 ;



 }

 }

}

void interrupt(void)
{
#line 82 "C:/WORKS/WS/Embedded/D-90~/D-91_PIC16_color_changer/D-91_PIC16_color_changer_v-1.0/D-91_PIC16_color_changer_v-1.0.c"
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
#line 123 "C:/WORKS/WS/Embedded/D-90~/D-91_PIC16_color_changer/D-91_PIC16_color_changer_v-1.0/D-91_PIC16_color_changer_v-1.0.c"
 INTCON |= 0x10;
 INTCON |= 0x80;

 while(1)
 {


  PORTA = 0x00 ;

 }

}
