// 20121219_131839
//ex_2_1_c-2_v-1_t-2.c

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
             // ON: RA0
             //PORTA = 0x02;    // 0000 0010
             PORTA = 0x06;    // 0000 0110

             k = 0;

             Delay_ms(1000);

             // ON: RA1
             k = 0;

             //PORTA = 0x01;  // 0001
             PORTA = 0x05;  // 0101

             Delay_ms(1000);

             // ON: RA2
             k = 0;

             //PORTA = 0x04;  // 0100
             PORTA = 0x03;  // 0011

             Delay_ms(1000);

     }//while(1)

}

