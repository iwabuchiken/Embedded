#line 1 "C:/WORKS/WS/Embedded/D-90~/D-93_PIC16_F88_A-D-conv/D-93_PIC16_F88_A-D-conv_v-3.0/D-93_PIC16_F88_A-D-conv_v-3.0.c"
#line 48 "C:/WORKS/WS/Embedded/D-90~/D-93_PIC16_F88_A-D-conv/D-93_PIC16_F88_A-D-conv_v-3.0/D-93_PIC16_F88_A-D-conv_v-3.0.c"
 unsigned short int  i;
 unsigned short int  custom_code_a, custom_code_b;
 unsigned short int  data_code_a, data_code_b;

 unsigned short int  bit_len;







void _main_Setup(void);

void
_Delay_50ms(void);

void _pulsing_u_100(void);

void _custom_lower_num(int);

void _send_StopBit(void);

void _Stop(void);

void _output(int);

void _pulse_Modulation(void);

void _reader(void);

void
_custom_lower(void);






void main(void)
{
#line 114 "C:/WORKS/WS/Embedded/D-90~/D-93_PIC16_F88_A-D-conv/D-93_PIC16_F88_A-D-conv_v-3.0/D-93_PIC16_F88_A-D-conv_v-3.0.c"
 while(1)
 {

 PORTA = 0x01;

 Delay_ms(50);

 PORTA = 0x02;

 Delay_ms(50);

 }

}

void _main_Setup(void) {


 TRISA = 0x00;


 TRISB = 0xFF;
#line 153 "C:/WORKS/WS/Embedded/D-90~/D-93_PIC16_F88_A-D-conv/D-93_PIC16_F88_A-D-conv_v-3.0/D-93_PIC16_F88_A-D-conv_v-3.0.c"
 ANSEL = 0;



}

void
_pulse_Modulation(void)
{


 PORTA = 0x01;
 Delay_us(9);

 PORTA = 0x00;
 Delay_us(17);

}

void
_reader(void)
{

 TMR0 = 0;



 while( TMR0 < 176 )
 {

 PORTA = 0x01;
 Delay_us(9);

 PORTA = 0x00;
 Delay_us(17);

 }

 TMR0 = 0;
 PORTA = 0x00;

 while( TMR0 < 88 )

 {

 }

}

void
_custom_lower(void)
{

 bit_len = 4;

 custom_code_a = 0x05;


 for(i = 0; i < bit_len; i++)
 {






  TMR0 = 0 ;

 while(TMR0 < 11)
 {
 _pulse_Modulation();

 }






 PORTA = 0x00;

 if (((custom_code_a >> i) & 0x01) == 0)
 {

 while(TMR0 < 22)
 {

 }

 } else {

 while(TMR0 < 44)
 {

 }

 }

 }

}

void
_custom_lower_num(int code)
{

 bit_len = 4;

 custom_code_a = code;



 for(i = 0; i < bit_len; i++)
 {






  TMR0 = 0 ;

 while(TMR0 < 11)
 {
 _pulse_Modulation();

 }






 PORTA = 0x00;

 if (((custom_code_a >> i) & 0x01) == 0)
 {

 while(TMR0 < 22)
 {

 }

 } else {

 while(TMR0 < 44)
 {

 }

 }

 }

}

void
_Delay_50ms(void) {

 Delay_ms(50);

}

void
_Opearations() {

 while( (PORTB & 0x01) == 0x01 ) {







 if (( (PORTB & 0x02) == 0x02 ) && !( (PORTB & 0x04) == 0x04 ) && !( (PORTB & 0x08) == 0x08 )) {

 _output(4);
#line 360 "C:/WORKS/WS/Embedded/D-90~/D-93_PIC16_F88_A-D-conv/D-93_PIC16_F88_A-D-conv_v-3.0/D-93_PIC16_F88_A-D-conv_v-3.0.c"
 } else if (!( (PORTB & 0x02) == 0x02 ) && ( (PORTB & 0x04) == 0x04 ) && !( (PORTB & 0x08) == 0x08 )) {

 _output(2);

 } else if (!( (PORTB & 0x02) == 0x02 ) && !( (PORTB & 0x04) == 0x04 ) && ( (PORTB & 0x08) == 0x08 )) {

 _output(1);

 } else if (!( (PORTB & 0x02) == 0x02 ) && ( (PORTB & 0x04) == 0x04 ) && ( (PORTB & 0x08) == 0x08 )) {

 _output(3);

 } else if (( (PORTB & 0x02) == 0x02 ) && ( (PORTB & 0x04) == 0x04 ) && !( (PORTB & 0x08) == 0x08 )) {

 _output(6);

 } else if (( (PORTB & 0x02) == 0x02 ) && !( (PORTB & 0x04) == 0x04 ) && ( (PORTB & 0x08) == 0x08 )) {

 _output(5);

 } else if (( (PORTB & 0x02) == 0x02 ) && ( (PORTB & 0x04) == 0x04 ) && ( (PORTB & 0x08) == 0x08 )) {

 _output(7);

 } else {

  PORTA = 0x00 ;

 }

 }
#line 406 "C:/WORKS/WS/Embedded/D-90~/D-93_PIC16_F88_A-D-conv/D-93_PIC16_F88_A-D-conv_v-3.0/D-93_PIC16_F88_A-D-conv_v-3.0.c"
}


void interrupt(void)
{
#line 420 "C:/WORKS/WS/Embedded/D-90~/D-93_PIC16_F88_A-D-conv/D-93_PIC16_F88_A-D-conv_v-3.0/D-93_PIC16_F88_A-D-conv_v-3.0.c"
 INTCON &= 0x7F;
 INTCON &= 0xEF;
 INTCON &= 0xFD;

 _Opearations();







 INTCON |= 0x10;
 INTCON |= 0x80;

}



void
_pulsing_u_100()
{

 PORTA = 0x00;

 PORTA = 0x01; Delay_us(100);

 PORTA = 0x00; Delay_us(100);

}

void _send_StopBit(void) {

  TMR0 = 0 ;

 while(TMR0 < 11) {

 _pulse_Modulation();

 }

}

void _Stop(void) {






 _send_StopBit();






 PORTA = 0x00;







 _Delay_50ms();


}

void
_output(int num) {

 _reader();


 _custom_lower_num(num);






 _send_StopBit();






 PORTA = 0x00;







 _Delay_50ms();

}
