#line 1 "C:/WORKS/WS/Electronics/Embedded/D_81_16F84A_Interrupt/D_81_16F84A_Interrupt_v_1_0/D_81_16F84A_Interrupt_v_1_0.c"
void interrupt(void)
{
 INTCON &= 0x7F;
 INTCON &= 0xEF;
 INTCON &= 0xFD;

 Delay_ms(20);

 if((PORTB & 0x01) == 0)
 {
 PORTA ^= 0x03;
 }

 INTCON |= 0x10;
 INTCON |= 0x80;

}

void main(void)
{

 TRISA = 0x00;
 PORTA = 0x02;
 TRISB = 0xFF;

 OPTION_REG &= 0x7F;
 OPTION_REG &= 0xBF;

 INTCON |= 0x10;
 INTCON |= 0x80;

 while(1)
 {

 }

}
