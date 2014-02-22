void buzzer(unsigned short int us)
{
     unsigned short int i;
     
     PORTA    = 0x00;
     
     for(i = 0; i < us; i++)
     {
           Delay_us(1);
     }
     
     PORTA = 0x01;
     
     for(i = 0; i < us; i++)
     {
           Delay_us(1);
     }
     
}//void buzzer(unsigned short int us)

void main(void)
{
     TRISA     = 0x00;
     PORTA     = 0x03;
     TRISB     = 0xFF;

     OPTION_REG &= 0x7F;

     while(1)
     {
      switch(PORTB)
      {
       case 0xFE : buzzer(239); break;/* 1111 1110 */
       case 0xFD : buzzer(213); break;/* 1111 1101 */
       case 0xFB : buzzer(190); break;/* 1111 1011 */
       default   : break;
      }

     }//while(1)

}//void main(void)