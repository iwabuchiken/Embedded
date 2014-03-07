#line 1 "C:/WORKS/WS/Electronics/Embedded/D_82_16F84A_SD1602/D_82_16F84A_SD1602_v_4_1/D_82_16F84A_SD1602_v_4_1.c"
#line 1 "c:/works/ws/electronics/embedded/d_82_16f84a_sd1602/d_82_16f84a_sd1602_v_4_1/sd1602_4bit_mode.h"
void SD1602_write(char c, char r)
{
 PORTB = c & 0xF0;

 if (r == 1)
 {
 PORTA |= 0x02;
 }
 else
 {
 PORTA &= 0xFD;
 }

 PORTA &= 0xFE;
 Delay_us(1);
 PORTA |= 0x01;
 Delay_us(1);
 PORTA &= 0xFE;
}

void SD1602_display(char c)
{
 SD1602_write(c, 1);
 SD1602_write(c << 4, 1);
 Delay_us(50);
}

void SD1602_control(char c)
{
 SD1602_write(c, 0);
 SD1602_write(c << 4, 0);
 Delay_us(50);
}

void SD1602_clear(void)
{
 SD1602_write(0x01, 0);
 SD1602_write(0x01 << 4, 0);
 Delay_ms(2);
}

void SD1602_init(void)
{
 Delay_ms(20);
 SD1602_write(0x30, 0);
 Delay_ms(5);
 SD1602_write(0x30, 0);
 Delay_ms(5);
 SD1602_write(0x30, 0);
 Delay_ms(5);
 SD1602_write(0x20, 0);
 Delay_ms(5);
 SD1602_control(0x28);
 SD1602_control(0x08);
 SD1602_control(0x0C);
 SD1602_control(0x06);
}

void SD1602_print(char *s)
{
 while (*s != 0x00)
 {
 SD1602_display(*s);
 s++;
 }
}
#line 1 "c:/works/ws/electronics/embedded/d_82_16f84a_sd1602/d_82_16f84a_sd1602_v_4_1/utils.h"

void strConstCpy
(char *dest, const char *source)
{
 while(*source)
 *dest++ = *source++ ;

 *dest = 0 ;
}
#line 5 "C:/WORKS/WS/Electronics/Embedded/D_82_16F84A_SD1602/D_82_16F84A_SD1602_v_4_1/D_82_16F84A_SD1602_v_4_1.c"
const char s1[] = "Psedoscience";
const char s2[] = "ad nauseam";


char s[30];


void interrupt(void)
{
 INTCON &= 0x7F;
 INTCON &= 0xEF;
 INTCON &= 0xFD;

 Delay_ms(20);

 if((PORTB & 0x01) == 0)
 {
 Delay_ms(2000);







 }

 INTCON |= 0x10;
 INTCON |= 0x80;

}


void main(void)
{





 TRISA = 0x00;
 PORTA = 0x00;
 TRISB = 0x00;

 PORTB = 0x80;

 OPTION_REG &= 0x7F;
 OPTION_REG &= 0xBF;

 INTCON |= 0x10;
 INTCON |= 0x80;


 SD1602_init();

 SD1602_clear();



 while(1)
 {

 strConstCpy(s, s2);


 SD1602_control(0x80);
 SD1602_print(s);

 Delay_ms(1000);

 SD1602_clear();

 Delay_ms(500);
#line 94 "C:/WORKS/WS/Electronics/Embedded/D_82_16F84A_SD1602/D_82_16F84A_SD1602_v_4_1/D_82_16F84A_SD1602_v_4_1.c"
 }

}
