#line 1 "C:/WORKS/WS/Electronics/Embedded/D_84_16F84A_Flasher/D_84_16F84A_Flasher_v_2_0/D_84_16F84A_Flasher_v_2_0.c"
unsigned short int i;
unsigned short int p[8] = {
 0x00,
 0x7E,
 0x11,
 0x11,

 0x11,
 0x7E,
 0x00,
 0x00
};

void interrupt(void)
{
 INTCON &= 0x7F;
 INTCON &= 0xDF;
 INTCON &= 0xFB;

 i++;


 Delay_ms(20);


 if(i == 8)
 {
 i = 0;
 }

 PORTB = p[i];




 INTCON |= 0x20;
 INTCON |= 0x80;

}

void main(void)
{

 TRISA = 0x00;
 PORTA = 0x00;
 TRISB = 0x00;
 PORTB = 0x00;

 OPTION_REG &= 0xDF;
 OPTION_REG &= 0xF0;
 OPTION_REG &= 0x07;

 i = 0;

 TMR0 = 0;

 INTCON |= 0x20;
 INTCON |= 0x80;

 while(1)
 {

 }

}
