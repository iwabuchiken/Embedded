#line 1 "C:/WORKS/WS/Electronics/Embedded/D_84_16F84A_Flasher/D_84_16F84A_Flasher_v_4_0/D_84_16F84A_Flasher_v_4_0.c"
unsigned short int count;
unsigned short int duty;

void interrupt(void)
{
 INTCON &= 0x7F;
 INTCON &= 0xDF;
 INTCON &= 0xFB;

 if(count < duty)
 {
 PORTA = 0x01;
 }
 else
 {
 PORTA = 0x00;
 }

 count++;

 if(count == 100)
 {
 count = 0;
 }

 INTCON |= 0x20;
 INTCON |= 0x80;

}

void main(void)
{
 unsigned short int i, j;


 TRISA = 0x00;
 PORTA = 0x00;
 TRISB = 0x00;
 PORTB = 0x00;

 OPTION_REG &= 0xDF;

 count = 0;
 duty = 0;

 TMR0 = 0;

 INTCON |= 0x20;
 INTCON |= 0x80;

 while(1)
 {
 j = rand() % 100;

 for(i = j; i < 100; i++)
 {
 duty = i;
 Delay_ms(10);
 }

 for(i = j; i < 100; i++)
 {
 duty = 99 - i;
 Delay_ms(10);
 }

 }

}
