// 20121219_131839
//ex_2_1_v-3.c

unsigned int i;
unsigned int j;
unsigned int k;

unsigned int num = 10000;
unsigned int num2 = 10;


void main(void) {

     TRISA = 0x00;
     PORTA = 0x03;

     TRISB = 0x00;
     PORTB = 0x00;

     while(1)
     {
             PORTA = 0x02;

             k = 0;

             //for(i = 0; i < 1000; i++)
             for (j = 0; j < num2; j ++)
             {
               for(i = 0; i < num; i++)
               {
                   k += 1;
               }
             }

             k = 0;

             PORTA = 0x01;

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
