#line 1 "C:/WORKS/WS/Embedded/D_85_16F84A_remote/D_85_16F84A_Remote_v_5_3_2a/D_85_16F84A_Remote_v_5_3_2a.c"
#line 16 "C:/WORKS/WS/Embedded/D_85_16F84A_remote/D_85_16F84A_Remote_v_5_3_2a/D_85_16F84A_Remote_v_5_3_2a.c"
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

void _reader(void)
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
#line 149 "C:/WORKS/WS/Embedded/D_85_16F84A_remote/D_85_16F84A_Remote_v_5_3_2a/D_85_16F84A_Remote_v_5_3_2a.c"
 _reader();
#line 154 "C:/WORKS/WS/Embedded/D_85_16F84A_remote/D_85_16F84A_Remote_v_5_3_2a/D_85_16F84A_Remote_v_5_3_2a.c"
 _custom_lower();
#line 160 "C:/WORKS/WS/Embedded/D_85_16F84A_remote/D_85_16F84A_Remote_v_5_3_2a/D_85_16F84A_Remote_v_5_3_2a.c"
 }

}
