// 20121219_094520

void main(void) {

     TRISA = 0x00;
     PORTA = 0x03;
     
     TRISB = 0x00;
     PORTB = 0x00;
     
     while(1)
     {
             PORTA = 0x02;
             Delay_ms(1000);
             
             PORTA = 0x01;
             Delay_ms(1000);

     }//while(1)

}