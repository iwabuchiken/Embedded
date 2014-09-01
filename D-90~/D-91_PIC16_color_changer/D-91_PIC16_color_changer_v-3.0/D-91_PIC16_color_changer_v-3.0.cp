#line 1 "C:/WORKS/WS/Embedded/D-90~/D-91_PIC16_color_changer/D-91_PIC16_color_changer_v-3.0/D-91_PIC16_color_changer_v-3.0.c"
#line 53 "C:/WORKS/WS/Embedded/D-90~/D-91_PIC16_color_changer/D-91_PIC16_color_changer_v-3.0/D-91_PIC16_color_changer_v-3.0.c"
void _reader(void)
{

 TMR0 = 0;



 while( TMR0 < 176 )
 {

 PORTA = 0x01;
 Delay_us(9);

 PORTA = 0x00;
 Delay_us(17);

 }

 TMR0 = 0;
 PORTA = 0x00;

 while( TMR0 < 88 )

 {

 }

}

void
_Opearations() {

 while( (PORTB & 0x01) == 0x01 ) {







 if (( (PORTB & 0x02) == 0x02 ) && !( (PORTB & 0x04) == 0x04 ) && !( (PORTB & 0x08) == 0x08 )) {

 _reader();

 } else {

  PORTA = 0x00 ;

 }

 }

}

void interrupt(void)
{
#line 118 "C:/WORKS/WS/Embedded/D-90~/D-91_PIC16_color_changer/D-91_PIC16_color_changer_v-3.0/D-91_PIC16_color_changer_v-3.0.c"
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
