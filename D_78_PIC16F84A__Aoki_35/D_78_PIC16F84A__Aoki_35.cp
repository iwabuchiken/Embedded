#line 1 "C:/WORKS/WS/Electronics/Embedded/D_78_PIC16F84A__Aoki_35/D_78_PIC16F84A__Aoki_35.c"


void main(void)
{
 TRISA = 0x00;
 PORTA = 0x03;
 TRISB = 0x00;
 PORTB = 0x00;

 while(1)
 {
 PORTA = 0x02;
 Delay_ms(1000);

 PORTA = 0x01;
 Delay_ms(1000);


 }

}
