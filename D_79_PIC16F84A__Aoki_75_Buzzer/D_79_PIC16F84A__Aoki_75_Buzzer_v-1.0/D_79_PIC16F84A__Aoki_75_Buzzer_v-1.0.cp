#line 1 "C:/WORKS/WS/Electronics/Embedded/D_79_PIC16F84A__Aoki_75_Buzzer/D_79_PIC16F84A__Aoki_75_Buzzer_v-1.0/D_79_PIC16F84A__Aoki_75_Buzzer_v-1.0.c"
void buzzer(unsigned short int us)
{
 unsigned short int i;

 PORTA = 0x00;

 for(i = 0; i < us; i++)
 {
 Delay_us(1);
 }

 PORTA = 0x01;

 for(i = 0; i < us; i++)
 {
 Delay_us(1);
 }

}

void main(void)
{
 TRISA = 0x00;
 PORTA = 0x03;
 TRISB = 0xFF;

 OPTION_REG &= 0x7F;

 while(1)
 {
 switch(PORTB)
 {
 case 0xFE : buzzer(239); break;
 case 0xFD : buzzer(213); break;
 case 0xFB : buzzer(190); break;
 default : break;
 }

 }

}
