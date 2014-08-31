#line 1 "C:/WORKS/WS/Embedded/D-90~/D-91_PIC16_color_changer/D-91_PIC16_color_changer_v-2.0/D-91_PIC16_color_changer_v-2.0.c"
#line 26 "C:/WORKS/WS/Embedded/D-90~/D-91_PIC16_color_changer/D-91_PIC16_color_changer_v-2.0/D-91_PIC16_color_changer_v-2.0.c"
void main(void)
{


 TRISA = 0x00;
 PORTA = 0x00;

 TRISB = 0xFF;

 OPTION_REG &= 0x7F;

 while(1)
 {

 if ( PORTB & 0x01 == 0x01 ) {

  PORTA = 0x01 ;

 } else {

  PORTA = 0x00 ;

 }

 }

}
