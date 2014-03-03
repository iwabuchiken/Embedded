#line 1 "C:/WORKS/WS/Electronics/Embedded/D_81_16F84A_Interrupt/D_81_16F84A_Interrupt_v_3_1/D_81_16F84A_Interrupt_v_3_1.c"
unsigned int count;

void interrupt(void)
{

 while(PORTB == 0xFD)
 {
 PORTA = 0x00;
 }

 INTCON &= 0x7F;
 INTCON &= 0xDF;
 INTCON &= 0xFB;

 count++;

 if(count == 76)
 {
 PORTA ^= 0x03;
 count = 0;
 }

 INTCON |= 0x20;
 INTCON |= 0x80;

}

void main(void)
{

 TRISA = 0x00;
 PORTA = 0x02;
 TRISB = 0xFF;

 OPTION_REG &= 0x7F;
 OPTION_REG &= 0xDF;

 OPTION_REG &= 0xF0;
 OPTION_REG |= 0x07;

 count = 0;
 TMR0 = 0;

 INTCON |= 0x20;
 INTCON |= 0x80;

 while(1)
 {

 }

}
