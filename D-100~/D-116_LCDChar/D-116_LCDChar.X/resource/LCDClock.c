//	ATtiny2313
//	LCD���p��	�J�����_�[�t�����v
//	
//	�E�J�����_�[�F����^�����ɑΉ�
//	�E���v�F12�^24���Ԑ��ɑΉ�
//	�E�\�����[�h�^�ݒ胂�[�h

/*
	�|�[�g�Ή�	[ATtiny2313]	x:���݂��Ȃ� -:��
	bit		7	6	5	4	3	2	1	0
	portA	x	x	x	x	x	x	-	-		PA2��RESET�Ȃ̂ő��݂��Ȃ����̂Ƃ���
	portB	-	LCD	LCD	LCD	LCD	LCD	LCD	LCD		LCD�ڑ�
	portD	x	-	-	-	-	-	swL	swR		�X�C�b�`
	
	�r���h��
	WinAVR-20080610		�œK���I�v�V����:-Os
	ATtiny2313	1MHz
	
	����
	2009/07/27	v0.01	�J���J�n
	2009/07/30	v1.00	����
							Program:    1780 bytes (86.9% Full)
							Data:          6 bytes (4.7% Full)
	2009/07/31	v1.10	����
							Program:    1668 bytes (81.4% Full)
							Data:         14 bytes (10.9% Full)
	2009/08/12	v1.20	lcdlib.c��lcdPutUInt()������
							Program:    1646 bytes (80.4% Full)
							Data:         19 bytes (14.8% Full)
*/


#include	<avr/io.h>
#include	<avr/interrupt.h>
#include	<avr/pgmspace.h>
#include	"lcdlib.h"
#include	"font5x8.h"


//���샂�[�h
enum	E_OPMODE
{
	OP_CLOCK,		//���v�\��
	OP_ADJ_SEC,		//�b
	OP_ADJ_MIN,		//��
	OP_ADJ_HOUR,	//��
	OP_ADJ_YEAR_10,	//�N�i�\�̈ʁj
	OP_ADJ_YEAR_1,	//�N�i��̈ʁj
	OP_ADJ_MONTH,	//��
	OP_ADJ_DAY,		//��
	OP_ADJ_WEEK		//�j��
};

//���̍ŏI���i���邤�N�͍l�����Ȃ��j
const	prog_uint8_t	LAST_DAY[]	= { 0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };

//�\�����[�h
//bit1:	0	0	1	1	�c 0:24���Ԑ�	1:12���Ԑ�
//bit0:	0	1	0	1	�c 0:����		1:����
//	�l	0	1	2	3
#define	DISPMODE_GENGOU	0x01
#define	DISPMODE_HOUR12	0x02

//�`��X�V�v���̓��e
#define	UPDT_DATE	0x01
#define	UPDT_TIME	0x02

//LCD���ł̕\���ʒu
//		0123456789ABCDEF
//date	2000Y00M00D(W)
//time	A00:00:00
#define	POS_DATE_X	0
#define	POS_DATE_Y	0
#define	POS_TIME_X	0
#define	POS_TIME_Y	1
#define	POS_ADJ_YY	(POS_DATE_X + 2)
#define	POS_ADJ_YY1	(POS_ADJ_YY + 1)
#define	POS_ADJ_MM	(POS_ADJ_YY1 + 3)
#define	POS_ADJ_DD	(POS_ADJ_MM + 3)
#define	POS_ADJ_WK	(POS_ADJ_DD + 3)
#define	POS_ADJ_H	(POS_TIME_X + 2)
#define	POS_ADJ_M	(POS_ADJ_H + 3)
#define	POS_ADJ_S	(POS_ADJ_M + 3)

//�����ݒ蒆�̈ē�
#define	ADJ_INFO	"Adj."
#define	POS_INFO_X	12	//16�� - sizeof(ADJ_INFO)
#define	POS_INFO_Y	1

//LCD���[�U�[��`�����i�L�����N�^�R�[�h�j
enum	E_LCD_GAIJI
{
	LCD_GAIJI_YEAR	= 0x00,
	LCD_GAIJI_MONTH,
	LCD_GAIJI_DAY,
	LCD_GAIJI_WEEK,
	LCD_GAIJI_HEI,
	LCD_GAIJI_SEI,
	LCD_GAIJI_AM,
	LCD_GAIJI_PM
};

//----------------------------------------------------------------------
//	lcdlib.c���g������֐��A�}�N��
//----------------------------------------------------------------------

static	uint8_t	data[8] = {0};

//lcdDefChar()�̃v���O�����̈�Ή���
void	lcdDefCharP(uint8_t id, uint8_t eidx)
{
	uint8_t	i;
	for (i = 0; i < 8; i++)
		data[i] = pgm_read_byte(&dots[eidx][i]);
	lcdDefChar(id, data);
}

//�����ݒ胂�[�h�ւ̈ڍs�A���A
#define	lcdAdjModeOn()	lcdCmd(LCD_CMD_DISPLAY_MODE | LCD_SUBCMD_SET_DISPLAY | LCD_SUBCMD_SET_CURSOR)
#define	lcdAdjModeOff()	lcdCmd(LCD_CMD_DISPLAY_MODE | LCD_SUBCMD_SET_DISPLAY)

//1���̕����Ȃ�����
#define	lcdPutInt1(n)	lcdPutChar('0' + (n))

//2���̕����Ȃ�����
void	lcdPutInt2(uint8_t n, uint8_t pad)
{
	if (n < 10) lcdPutChar(pad);
	lcdPutUInt(n);
}

//0�l��2���̕����Ȃ�����
void	lcdPutInt02(uint8_t n)
{
	lcdPutInt2(n, '0');
}

//�󔒋l��2���̕����Ȃ�����
void	lcdPutIntSP2(uint8_t n)
{
	lcdPutInt2(n, ' ');
}

//----------------------------------------------------------------------

//���t��\������i�N�j
void	displayDateYear(uint8_t year, uint8_t dispMode)
{
	if (dispMode & DISPMODE_GENGOU)
	{
		lcdPutChar(LCD_GAIJI_HEI);
		lcdPutChar(LCD_GAIJI_SEI);
		lcdPutInt02(year + 12);
	}
	else
	{
		lcdPutUInt(2000 + year);
	}
}

//���t��\������
void	displayDate(uint8_t year, uint8_t dispMode, uint8_t month, uint8_t day, uint8_t week)
{
	displayDateYear(year, dispMode);
	lcdPutChar(LCD_GAIJI_YEAR);
	
	lcdPutIntSP2(month);
	lcdPutChar(LCD_GAIJI_MONTH);
	
	lcdPutIntSP2(day);
	lcdPutChar(LCD_GAIJI_DAY);
	
	lcdPutChar('(');
	lcdPutChar(LCD_GAIJI_WEEK);
	lcdPutChar(')');
}

//������\������i���j
void	displayTimeHour(uint8_t ampm, uint8_t hour)
{
	lcdPutChar(ampm);
	lcdPutIntSP2(hour);
}

//������\������
void	displayTime(uint8_t ampm, uint8_t hour, uint8_t min, uint8_t sec)
{
	displayTimeHour(ampm, hour);
	lcdPutChar(':');
	
	lcdPutInt02(min);
	lcdPutChar(':');
	
	lcdPutInt02(sec);
}

//���荞�ݔ�����ʒm����t���O�i�����W�X�^R2�Ɋ���t����j
volatile	register	uint8_t	bTC	asm("r2");

//16bit�^�C�}	1(sec)���Ƃ̌Ăяo��
ISR(TIMER1_COMPA_vect)
{
	bTC = 1;
}

int	main(void)
{
	uint8_t	year, month, day, week;		//���2���A���A���A�j���i0-6��7�j���j
	uint8_t	hour24, hour, min, sec;		//���i24���ԁj�A���i�\���p�j���A�b
	uint8_t	ampm;						//�ߑO�^�ߌ�
	uint8_t	opMode, dispMode;			//���샂�[�h�A�\�����[�h
	uint8_t	doUpdate;		//�`��X�V�t���O
	uint8_t	sw, psw;		//�X�C�b�`�ǂݎ��
	uint8_t	swOn[2];		//�X�C�b�`�̏�Ԃ��i�[����z��	1:on	0:off
	uint8_t	loopCnt;		//�^�C�~���O�҂��ȂǂɎg���J�E���^
	
	year = 0;
	month = day = 1;
	week = 0;
	hour24 = hour = min = sec = 0;
	ampm = ' ';
	opMode = OP_CLOCK;
	dispMode = 0;
	doUpdate = UPDT_DATE | UPDT_TIME;
	psw = sw = 0;
	loopCnt = 0;
	
	//�|�[�g�ݒ�
	PORTD	= 0b00000011;	//�X�C�b�`��2��	PD1-PD0
	
	//LCD������
	lcdInit();
	
	//LCD���[�U�[��`������o�^����
	lcdDefCharP(LCD_GAIJI_YEAR,	E_YEAR);
	lcdDefCharP(LCD_GAIJI_MONTH,	E_MON);
	lcdDefCharP(LCD_GAIJI_DAY,	E_SUN);
	lcdDefCharP(LCD_GAIJI_WEEK,	E_MON);
	lcdDefCharP(LCD_GAIJI_HEI,	E_HEI);
	lcdDefCharP(LCD_GAIJI_SEI,	E_SEI);
	lcdDefCharP(LCD_GAIJI_AM,	E_AM);
	lcdDefCharP(LCD_GAIJI_PM,	E_PM);
	
	//16bit�^�C�}�[
	TCCR1A	= (0 << WGM11) | (0 << WGM10);	//CTC����	TCCR1B:WGM12=1, TCCR1A:WGM11=0, TCCR1A:WGM10=0
	TCCR1B	= (1 << WGM12) | (0 << CS12) | (1 << CS11) | (1 << CS10);	//������(64����)	CS12=0, CS11=1, CS10=1
	OCR1A	= F_CPU / 64 - 1;	//��r�l	1�b���v������iF_CPU=1MHz��z��j
	
	//���荞�ݐݒ�
	TIMSK	= (1 << OCIE1A);	//16bit�^�C�}:��r��v���荞��
	
	bTC = 0;
	sei();		//���荞�݋���
	
	while (1)
	{
		//���荞�ݔ����i���Ԍo�߁j
		if (bTC)
		{
			bTC = 0;
			doUpdate |= UPDT_TIME;
			if (++sec >= 60)
			{
				sec = 0;
				if (++min >= 60)
				{
					min = 0;
					if (++hour24 >= 24)		//�펞24���Ԑ��ŃJ�E���g���A�\���i�K�ŉ��H����
					{
						doUpdate |= UPDT_DATE;
						hour24 = 0;
						if (++week >= 7) week = 0;
						lcdDefCharP(LCD_GAIJI_WEEK, E_MON + week);
						if (++day > pgm_read_byte(&LAST_DAY[month]))
						{
							day = 1;
							if (++month > 12)
							{
								month = 1;
								if (++year >= 100) year = 0;	//year�͐���̉�2��
							}
						}
					}
				}
			}
		}
		
		//�\���X�V
		if (doUpdate & UPDT_DATE)
		{
			lcdSetPos(POS_DATE_X, POS_DATE_Y);
			displayDate(year, dispMode, month, day, week);
		}
		
		if (doUpdate & UPDT_TIME)
		{
			//n���Ԑ��̎����\��
			//12: 12, 1,..........,12, 1,..,11,12
			//24:  0, 1,..........,12,13,..,23, 0
			hour = hour24;
			if (dispMode & DISPMODE_HOUR12)
			{
				if (hour == 0) hour = 12;
				if (12 < hour) hour -= 12;
				//���^��Ƃ�12:00�̏u�ԂɌߑO�^�ߌ��؂�ւ���
				ampm = (12 <= hour24) ? LCD_GAIJI_PM : LCD_GAIJI_AM;
			}
			else
			{
				//AM/PM�\���͋�
				ampm = ' ';
			}
			
			lcdSetPos(POS_TIME_X, POS_TIME_Y);
			displayTime(ampm, hour, min, sec);
		}
		
		doUpdate = 0;
		
		//�X�C�b�`�ǂݎ��
		swOn[1] = swOn[0] = 0;
		if ((++loopCnt & 0x20) == 0x20)		//�`���^�����O������ł�����x�Ƀ��[�v�Ԋu���󂯂�
		{
			sw = PIND & 0b00000011;
			if (psw != sw)
			{
				swOn[0] = ~sw & 0b00000001;
				swOn[1] = ~sw & 0b00000010;
				psw = sw;
			}
		}
		
		//�\�����e�ύX
		switch (opMode)
		{
		case OP_ADJ_YEAR_10:
			lcdSetPos(POS_ADJ_YY, POS_DATE_Y);
			//�X�C�b�`���͔���
			if (swOn[0])
			{
				opMode = OP_ADJ_YEAR_1;
			}
			if (swOn[1])
			{
				if (year < 90) year += 10;
				else year %= 10;
				doUpdate = UPDT_DATE;
			}
			break;
			
		case OP_ADJ_YEAR_1:
			lcdSetPos(POS_ADJ_YY1, POS_DATE_Y);
			//�X�C�b�`���͔���
			if (swOn[0])
			{
				opMode = OP_ADJ_MONTH;
			}
			if (swOn[1])
			{
				if (year % 10 < 9) year++;
				else year /= 10;
				doUpdate = UPDT_DATE;
			}
			break;
			
		case OP_ADJ_MONTH:
			lcdSetPos(POS_ADJ_MM, POS_DATE_Y);
			//�X�C�b�`���͔���
			if (swOn[0])
			{
				opMode = OP_ADJ_DAY;
			}
			if (swOn[1])
			{
				if (++month > 12) month = 1;
				doUpdate = UPDT_DATE;
			}
			break;
			
		case OP_ADJ_DAY:
			lcdSetPos(POS_ADJ_DD, POS_DATE_Y);
			//�X�C�b�`���͔���
			if (swOn[0])
			{
				opMode = OP_ADJ_WEEK;
			}
			if (swOn[1])
			{
				if (++day > 31) day = 1;	//�������ɂ�����炸31���܂Őݒ�ł���
				doUpdate = UPDT_DATE;
			}
			break;
			
		case OP_ADJ_WEEK:
			lcdSetPos(POS_ADJ_WK, POS_DATE_Y);
			//�X�C�b�`���͔���
			if (swOn[0])
			{
				opMode = OP_ADJ_HOUR;
			}
			if (swOn[1])
			{
				if (++week >= 7) week = 0;
				lcdDefCharP(LCD_GAIJI_WEEK, E_MON + week);
				doUpdate = UPDT_DATE;
			}
			break;
			
		case OP_ADJ_HOUR:
			lcdSetPos(POS_ADJ_H, POS_TIME_Y);
			//�X�C�b�`���͔���
			if (swOn[0])
			{
				opMode = OP_ADJ_MIN;
			}
			if (swOn[1])
			{
				if (++hour24 >= 24) hour24 = 0;
				doUpdate = UPDT_TIME;
			}
			break;
			
		case OP_ADJ_MIN:
			lcdSetPos(POS_ADJ_M, POS_TIME_Y);
			//�X�C�b�`���͔���
			if (swOn[0])
			{
				opMode = OP_ADJ_SEC;
			}
			if (swOn[1])
			{
				if (++min >= 60) min = 0;
				doUpdate = UPDT_TIME;
			}
			break;
			
		case OP_ADJ_SEC:
			lcdSetPos(POS_ADJ_S, POS_TIME_Y);
			//�X�C�b�`���͔���
			if (swOn[0])
			{
				//�\�����[�h�֕��A����
				opMode = OP_CLOCK;
				lcdAdjModeOff();
				lcdCls();
				doUpdate = UPDT_DATE | UPDT_TIME;
			}
			if (swOn[1])
			{
				sec = 0;
				doUpdate = UPDT_TIME;
			}
			break;
			
		//case OP_CLOCK:
		default:
			//�X�C�b�`���͔���
			if (swOn[0])
			{
				//�ݒ胂�[�h�p�̓����\���ɕύX����
				dispMode = 0;	//����A24���Ԑ�
				doUpdate = UPDT_DATE | UPDT_TIME;
				
				//�ݒ胂�[�h�ֈڍs����
				opMode = OP_ADJ_YEAR_10;
				lcdAdjModeOn();
				lcdSetPos(POS_INFO_X, POS_INFO_Y);
				lcdPutStr((uint8_t*)ADJ_INFO);
			}
			if (swOn[1])
			{
				//�\�����[�h�ύX
				if (++dispMode > 3) dispMode = 0;
				doUpdate = UPDT_DATE | UPDT_TIME;
			}
			break;
			
		}	//switch()
		
	}	//while()
	
	return 0;
}
