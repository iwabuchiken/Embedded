#line 1 "C:/WORKS/WS/Emb/Embedded/D_85_16F84A_remote/D_85_Remote_v_5_4_0_Snd/D_85_Remote_v_5_4_0_Snd.c"
#line 16 "C:/WORKS/WS/Emb/Embedded/D_85_16F84A_remote/D_85_Remote_v_5_4_0_Snd/D_85_Remote_v_5_4_0_Snd.c"
 unsigned short int  i;

 unsigned short int  custom_code_b;
 unsigned short int  custom_code_a = 0xFA;

 unsigned short int  data_code_a, data_code_b;

 unsigned short int  bit_len = 8;






void _pulse(void)
{


 PORTA = 0x01;
 Delay_us(9);

 PORTA = 0x00;
 Delay_us(17);

}

void _pulse_u_100(int num)
{
 int i;

 for(i = 0; i < num; i++)
 {

 PORTA = 0x01; Delay_us(100);

 PORTA = 0x00; Delay_us(100);

 }

}

void _pulsing(void)
{


 PORTA = 0x01; Delay_ms(1);

 PORTA = 0x00; Delay_ms(1);

}

void _pulsing_10ms(void)
{


 PORTA = 0x01; Delay_ms(10);

 PORTA = 0x00; Delay_ms(10);

}

void _pulsing_u_100()
{

 PORTA = 0x01; Delay_us(100);

 PORTA = 0x00; Delay_us(100);

}

void _reader(void)
{

  TMR0 = 0 ;



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

void _custom_lower(void)
{




 for(i = 0; i < bit_len; i++)
 {






  TMR0 = 0 ;

 while(TMR0 < 11)
 {
 _pulse();

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

void main(void)
{





 TRISA = 0x00;
 PORTA = 0x00;

 TRISB = 0x00;
 PORTB = 0x00;

 OPTION_REG &= 0xDF;
 OPTION_REG &= 0xF0;
 OPTION_REG |= 0x07;



 data_code_a = 0x00;
 data_code_b = ~data_code_a;

 while(1)
 {
 if((PORTB & 0x80) == 0x80)
 {

 _pulsing();

 }
 else if((PORTB & 0x40) == 0x40)
 {

 _pulsing_u_100();

 }
 else
 {

 _pulsing_10ms();

 }
#line 223 "C:/WORKS/WS/Emb/Embedded/D_85_16F84A_remote/D_85_Remote_v_5_4_0_Snd/D_85_Remote_v_5_4_0_Snd.c"
 }

}
