// 20121219_131839
//ex_2_1_c-2_v-1.c

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
             // ON: RA1
             PORTA = 0x02;    // 0000 0010

             k = 0;

             //for(i = 0; i < 1000; i++)
             for (j = 0; j < num2; j ++)
             {
               for(i = 0; i < num; i++)
               {
                   k += 1;
               }
             }

             // ON: RA2
             k = 0;

             PORTA = 0x01;  // 0001

             //for(i = 0; i < 1000; i++)
             for (j = 0; j < num2; j ++)
             {
               for(i = 0; i < num; i++)
               {
                   k += 1;
               }
             }

             // ON: RA3
             k = 0;

             //PORTA = 0x04;  // 0100
             PORTA = 0x03;  // 0011

             //for(i = 0; i < 1000; i++)
             for (j = 0; j < num2; j ++)
             {
               for(i = 0; i < num; i++)
               {
                   k += 1;
               }
             }

     }//while(1)

}
