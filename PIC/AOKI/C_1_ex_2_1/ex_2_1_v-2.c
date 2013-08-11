// 20121219_094520

unsigned int i;

void dl(int mil_sec) {

     for (i = 0; i < mil_sec; i++)
     {
         Delay_ms(1000);
     }

}

void main(void) {

     TRISA = 0x00;
     PORTA = 0x03;

     TRISB = 0x00;
     PORTB = 0x00;

     while(1)
     {
             PORTA = 0x02;
             Delay_ms(200);
             //dl(1);

             PORTA = 0x01;
             Delay_ms(1000);
             //dl(2);

     }//while(1)

}