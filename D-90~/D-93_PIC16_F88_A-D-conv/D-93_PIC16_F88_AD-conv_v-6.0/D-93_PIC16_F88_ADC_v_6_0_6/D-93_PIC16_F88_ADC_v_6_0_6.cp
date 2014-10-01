#line 1 "C:/WORKS/WS/Embedded/D-90~/D-93_PIC16_F88_A-D-conv/D-93_PIC16_F88_AD-conv_v-6.0/D-93_PIC16_F88_ADC_v_6_0_6/D-93_PIC16_F88_ADC_v_6_0_6.c"
#line 23 "C:/WORKS/WS/Embedded/D-90~/D-93_PIC16_F88_A-D-conv/D-93_PIC16_F88_AD-conv_v-6.0/D-93_PIC16_F88_ADC_v_6_0_6/D-93_PIC16_F88_ADC_v_6_0_6.c"
void interrupt(void);
void _main_Setup(void);






void main(void)
{

 _main_Setup();

 while(1)
 {
#line 55 "C:/WORKS/WS/Embedded/D-90~/D-93_PIC16_F88_A-D-conv/D-93_PIC16_F88_AD-conv_v-6.0/D-93_PIC16_F88_ADC_v_6_0_6/D-93_PIC16_F88_ADC_v_6_0_6.c"
 }

}

void
interrupt(void) {

 INTCON &= 0x7F;
 INTCON &= 0xDF;
 INTCON &= 0xFB;






 PORTA = 0x01;

 PORTA = 0x02;








 INTCON |= 0x20;
 INTCON |= 0x80;

}

void
_main_Setup(void) {

 TRISA = 0x00;
 TRISB = 0x00;

 PORTA = 0x00;

 PORTB = 0x01;







 ADCON0 = 0x00;

 ANSEL = 0;






 OPTION_REG &= 0x7F;
 OPTION_REG &= 0xDF;


 TMR0 = 0;








 INTCON |= 0x20;
 INTCON |= 0x80;

}
