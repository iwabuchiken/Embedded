#line 1 "C:/WORKS/WS/Electronics/Embedded/D_80_16F84A_Aoki.82_Chattering/D_80_16F84A_Chattering_v_2_0/D_80_16F84A_Chattering_v_2_0.c"
void main(void)
{
 unsigned short int rb0, previous_rb0;

 TRISA = 0x00;
 PORTA = 0x02;
 TRISB = 0xFF;

 OPTION_REG &= 0x7F;

 rb0 = 1;
 previous_rb0 = 1;

 while(1)
 {
 Delay_ms(20);

 rb0 = PORTB & 0x01;

 if(rb0 == 0 && previous_rb0 == 1)
 {
 PORTA ^= 0x03;
 }

 previous_rb0 = rb0;

 }

}
