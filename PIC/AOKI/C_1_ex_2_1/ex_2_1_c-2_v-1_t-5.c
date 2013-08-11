// 20121219_131839
//ex_2_1_c-2_v-1_t-5.c

unsigned int i;
unsigned int j;
unsigned int k;

unsigned int num = 10000;
unsigned int num2 = 10;


void main(void) {

     TRISA = 0x00;
     PORTA = 0x07;  // 0000 0111

     TRISB = 0x00;
     PORTB = 0x00;

     while(1)
     {
             PORTA = 0x00;    // 0000

             Delay_ms(1000);

             //
             PORTA = 0x04;  // 0100

             Delay_ms(1000);

             PORTA = 0x02;  // 0010

             Delay_ms(1000);

     }//while(1)

}

