#line 1 "C:/WORKS/WS/Electronics/Embedded/D_84_16F84A_Flasher/D_84_16F84A_Flasher_v_3_1/D_84_16F84A_Flasher_v_3_1.c"
unsigned short int count;
unsigned short int duty;
unsigned int led_pattern;


void interrupt(void)
{
 INTCON &= 0x7F;
 INTCON &= 0xDF;
 INTCON &= 0xFB;

 if(count < duty)
 {


 PORTA = led_pattern & 0xFF;
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
 unsigned short int i;


 TRISA = 0x00;
 PORTA = 0x00;
 TRISB = 0x00;
 PORTB = 0x00;

 OPTION_REG &= 0xDF;



 count = 0;
 duty = 0;

 TMR0 = 0;



 led_pattern = 0x0001;


 INTCON |= 0x20;
 INTCON |= 0x80;

 while(1)
 {
 for(i = 0; i < 100; i++)
 {
 duty = i;
 Delay_ms(10);
 }

 for(i = 0; i < 100; i++)
 {
 duty = 99 - i;
 Delay_ms(10);
 }

 if(led_pattern == 0x08)
 {
 led_pattern = 0x0001;
 }
 else
 {
 led_pattern <<= 1;
 }
#line 98 "C:/WORKS/WS/Electronics/Embedded/D_84_16F84A_Flasher/D_84_16F84A_Flasher_v_3_1/D_84_16F84A_Flasher_v_3_1.c"
 }

}
