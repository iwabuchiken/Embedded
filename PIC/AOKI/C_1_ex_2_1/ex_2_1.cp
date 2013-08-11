#line 1 "C:/WORKS/WS/Electronics/PIC/AOKI/C_1_ex_2_1/ex_2_1.c"



unsigned int i;
unsigned int j;
unsigned int k;

unsigned int num = 10000;
unsigned int num2 = 10;


void main(void) {

 TRISA = 0x00;
 PORTA = 0x07;

 TRISB = 0x00;
 PORTB = 0x00;

 while(1)
 {
 PORTA = 0x00;

 Delay_ms(1000);



 PORTA = 0x02;

 Delay_ms(1000);

 PORTA = 0x02;

 Delay_ms(1000);

 PORTA = 0x01;

 Delay_ms(1000);

 }

}
