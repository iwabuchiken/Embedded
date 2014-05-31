#line 1 "C:/WORKS/WS/Embedded/D_85_16F84A_remote/D_85_16F84A_remote_v_4_0/D_85_16F84A_Remote_v_4_0.c"





void main(void)
{
  unsigned short int  i;
  unsigned short int  custom_code_a, custom_code_b;
  unsigned short int  data_code_a, data_code_b;


  unsigned short int  input_a = 0xFE;
  unsigned short int  input_b = 0xFD;


  unsigned short int  LED_Left = 0x02;
  unsigned short int  LED_Right = 0x01;
  unsigned short int  LED_Both =0x03;


 TRISA = 0x00;
 PORTA = 0x00;

 TRISB = 0xFF;
 OPTION_REG &= 0x7F;

 while(1)
 {
 if (PORTB == input_a) {


 PORTA = LED_Left;

 } else if(PORTB == input_b) {


 PORTA = LED_Right;

 } else {

 PORTA = LED_Both;

 }

 }

}
