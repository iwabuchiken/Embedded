#line 1 "C:/WORKS/WS/Electronics/Embedded/D_79_PIC16F84A__Aoki_66/D_79_PIC16F84A__Aoki_66_v-1.0/D_79_PIC16F84A__Aoki_66.c"
void main(void)
{
 TRISA = 0x00;
 PORTA = 0x03;
 TRISB = 0xFF;

 OPTION_REG &= 0x7F;

 while(1)
 {

 if (PORTB == 0xFE)
 {
 PORTA = 0x02;
 }
 else if (PORTB == 0xFD)
 {
 PORTA = 0x01;
 }
 else
 {
 PORTA = 0x03;
 }

 }

}
