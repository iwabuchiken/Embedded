#line 1 "C:/WORKS/WS/Embedded/D-90~/D-97_LCD/D-97_LCD_v-2.x/D-97_LCD_v-2.2/D-97_LCD_v-2.2.c"
#line 1 "c:/works/ws/embedded/d-90~/d-97_lcd/d-97_lcd_v-2.x/d-97_lcd_v-2.2/sd1602_4bit_mode.h"
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
#line 3 "C:/WORKS/WS/Embedded/D-90~/D-97_LCD/D-97_LCD_v-2.x/D-97_LCD_v-2.2/D-97_LCD_v-2.2.c"
void main(void)
{
 char s[] = "Hello!";

 TRISA = 0x00;
 PORTA = 0x00;
 TRISB = 0x00;
 PORTB = 0x00;


 SD1602_init();

 SD1602_clear();


 while(1)
 {

 SD1602_control(0x80);
 SD1602_print(s);

 Delay_ms(1000);
 }

}