//	ATtiny2313
//	LCD応用例	カレンダー付き時計
//	
//	・カレンダー：西暦／元号に対応
//	・時計：12／24時間制に対応
//	・表示モード／設定モード

/*
	ポート対応	[ATtiny2313]	x:存在しない -:空き
	bit		7	6	5	4	3	2	1	0
	portA	x	x	x	x	x	x	-	-		PA2はRESETなので存在しないものとする
	portB	-	LCD	LCD	LCD	LCD	LCD	LCD	LCD		LCD接続
	portD	x	-	-	-	-	-	swL	swR		スイッチ
	
	ビルド環境
	WinAVR-20080610		最適化オプション:-Os
	ATtiny2313	1MHz
	
	履歴
	2009/07/27	v0.01	開発開始
	2009/07/30	v1.00	完成
							Program:    1780 bytes (86.9% Full)
							Data:          6 bytes (4.7% Full)
	2009/07/31	v1.10	改造
							Program:    1668 bytes (81.4% Full)
							Data:         14 bytes (10.9% Full)
	2009/08/12	v1.20	lcdlib.cのlcdPutUInt()を改造
							Program:    1646 bytes (80.4% Full)
							Data:         19 bytes (14.8% Full)
*/


#include	<avr/io.h>
#include	<avr/interrupt.h>
#include	<avr/pgmspace.h>
#include	"lcdlib.h"
#include	"font5x8.h"


//操作モード
enum	E_OPMODE
{
	OP_CLOCK,		//時計表示
	OP_ADJ_SEC,		//秒
	OP_ADJ_MIN,		//分
	OP_ADJ_HOUR,	//時
	OP_ADJ_YEAR_10,	//年（十の位）
	OP_ADJ_YEAR_1,	//年（一の位）
	OP_ADJ_MONTH,	//月
	OP_ADJ_DAY,		//日
	OP_ADJ_WEEK		//曜日
};

//月の最終日（うるう年は考慮しない）
const	prog_uint8_t	LAST_DAY[]	= { 0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };

//表示モード
//bit1:	0	0	1	1	… 0:24時間制	1:12時間制
//bit0:	0	1	0	1	… 0:西暦		1:元号
//	値	0	1	2	3
#define	DISPMODE_GENGOU	0x01
#define	DISPMODE_HOUR12	0x02

//描画更新要求の内容
#define	UPDT_DATE	0x01
#define	UPDT_TIME	0x02

//LCD内での表示位置
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

//日時設定中の案内
#define	ADJ_INFO	"Adj."
#define	POS_INFO_X	12	//16桁 - sizeof(ADJ_INFO)
#define	POS_INFO_Y	1

//LCDユーザー定義文字（キャラクタコード）
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
//	lcdlib.cを拡張する関数、マクロ
//----------------------------------------------------------------------

static	uint8_t	data[8] = {0};

//lcdDefChar()のプログラム領域対応版
void	lcdDefCharP(uint8_t id, uint8_t eidx)
{
	uint8_t	i;
	for (i = 0; i < 8; i++)
		data[i] = pgm_read_byte(&dots[eidx][i]);
	lcdDefChar(id, data);
}

//日時設定モードへの移行、復帰
#define	lcdAdjModeOn()	lcdCmd(LCD_CMD_DISPLAY_MODE | LCD_SUBCMD_SET_DISPLAY | LCD_SUBCMD_SET_CURSOR)
#define	lcdAdjModeOff()	lcdCmd(LCD_CMD_DISPLAY_MODE | LCD_SUBCMD_SET_DISPLAY)

//1桁の符号なし整数
#define	lcdPutInt1(n)	lcdPutChar('0' + (n))

//2桁の符号なし整数
void	lcdPutInt2(uint8_t n, uint8_t pad)
{
	if (n < 10) lcdPutChar(pad);
	lcdPutUInt(n);
}

//0詰め2桁の符号なし整数
void	lcdPutInt02(uint8_t n)
{
	lcdPutInt2(n, '0');
}

//空白詰め2桁の符号なし整数
void	lcdPutIntSP2(uint8_t n)
{
	lcdPutInt2(n, ' ');
}

//----------------------------------------------------------------------

//日付を表示する（年）
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

//日付を表示する
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

//時刻を表示する（時）
void	displayTimeHour(uint8_t ampm, uint8_t hour)
{
	lcdPutChar(ampm);
	lcdPutIntSP2(hour);
}

//時刻を表示する
void	displayTime(uint8_t ampm, uint8_t hour, uint8_t min, uint8_t sec)
{
	displayTimeHour(ampm, hour);
	lcdPutChar(':');
	
	lcdPutInt02(min);
	lcdPutChar(':');
	
	lcdPutInt02(sec);
}

//割り込み発生を通知するフラグ（をレジスタR2に割り付ける）
volatile	register	uint8_t	bTC	asm("r2");

//16bitタイマ	1(sec)ごとの呼び出し
ISR(TIMER1_COMPA_vect)
{
	bTC = 1;
}

int	main(void)
{
	uint8_t	year, month, day, week;		//西暦下2桁、月、日、曜日（0-6で7曜日）
	uint8_t	hour24, hour, min, sec;		//時（24時間）、時（表示用）分、秒
	uint8_t	ampm;						//午前／午後
	uint8_t	opMode, dispMode;			//操作モード、表示モード
	uint8_t	doUpdate;		//描画更新フラグ
	uint8_t	sw, psw;		//スイッチ読み取り
	uint8_t	swOn[2];		//スイッチの状態を格納する配列	1:on	0:off
	uint8_t	loopCnt;		//タイミング待ちなどに使うカウンタ
	
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
	
	//ポート設定
	PORTD	= 0b00000011;	//スイッチが2個	PD1-PD0
	
	//LCD初期化
	lcdInit();
	
	//LCDユーザー定義文字を登録する
	lcdDefCharP(LCD_GAIJI_YEAR,	E_YEAR);
	lcdDefCharP(LCD_GAIJI_MONTH,	E_MON);
	lcdDefCharP(LCD_GAIJI_DAY,	E_SUN);
	lcdDefCharP(LCD_GAIJI_WEEK,	E_MON);
	lcdDefCharP(LCD_GAIJI_HEI,	E_HEI);
	lcdDefCharP(LCD_GAIJI_SEI,	E_SEI);
	lcdDefCharP(LCD_GAIJI_AM,	E_AM);
	lcdDefCharP(LCD_GAIJI_PM,	E_PM);
	
	//16bitタイマー
	TCCR1A	= (0 << WGM11) | (0 << WGM10);	//CTC動作	TCCR1B:WGM12=1, TCCR1A:WGM11=0, TCCR1A:WGM10=0
	TCCR1B	= (1 << WGM12) | (0 << CS12) | (1 << CS11) | (1 << CS10);	//分周比(64分周)	CS12=0, CS11=1, CS10=1
	OCR1A	= F_CPU / 64 - 1;	//比較値	1秒を計測する（F_CPU=1MHzを想定）
	
	//割り込み設定
	TIMSK	= (1 << OCIE1A);	//16bitタイマ:比較一致割り込み
	
	bTC = 0;
	sei();		//割り込み許可
	
	while (1)
	{
		//割り込み発生（時間経過）
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
					if (++hour24 >= 24)		//常時24時間制でカウントし、表示段階で加工する
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
								if (++year >= 100) year = 0;	//yearは西暦の下2桁
							}
						}
					}
				}
			}
		}
		
		//表示更新
		if (doUpdate & UPDT_DATE)
		{
			lcdSetPos(POS_DATE_X, POS_DATE_Y);
			displayDate(year, dispMode, month, day, week);
		}
		
		if (doUpdate & UPDT_TIME)
		{
			//n時間制の時刻表現
			//12: 12, 1,..........,12, 1,..,11,12
			//24:  0, 1,..........,12,13,..,23, 0
			hour = hour24;
			if (dispMode & DISPMODE_HOUR12)
			{
				if (hour == 0) hour = 12;
				if (12 < hour) hour -= 12;
				//昼／夜とも12:00の瞬間に午前／午後を切り替える
				ampm = (12 <= hour24) ? LCD_GAIJI_PM : LCD_GAIJI_AM;
			}
			else
			{
				//AM/PM表示は空欄
				ampm = ' ';
			}
			
			lcdSetPos(POS_TIME_X, POS_TIME_Y);
			displayTime(ampm, hour, min, sec);
		}
		
		doUpdate = 0;
		
		//スイッチ読み取り
		swOn[1] = swOn[0] = 0;
		if ((++loopCnt & 0x20) == 0x20)		//チャタリングが回避できる程度にループ間隔を空ける
		{
			sw = PIND & 0b00000011;
			if (psw != sw)
			{
				swOn[0] = ~sw & 0b00000001;
				swOn[1] = ~sw & 0b00000010;
				psw = sw;
			}
		}
		
		//表示内容変更
		switch (opMode)
		{
		case OP_ADJ_YEAR_10:
			lcdSetPos(POS_ADJ_YY, POS_DATE_Y);
			//スイッチ入力判定
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
			//スイッチ入力判定
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
			//スイッチ入力判定
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
			//スイッチ入力判定
			if (swOn[0])
			{
				opMode = OP_ADJ_WEEK;
			}
			if (swOn[1])
			{
				if (++day > 31) day = 1;	//何月かにかかわらず31日まで設定できる
				doUpdate = UPDT_DATE;
			}
			break;
			
		case OP_ADJ_WEEK:
			lcdSetPos(POS_ADJ_WK, POS_DATE_Y);
			//スイッチ入力判定
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
			//スイッチ入力判定
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
			//スイッチ入力判定
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
			//スイッチ入力判定
			if (swOn[0])
			{
				//表示モードへ復帰する
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
			//スイッチ入力判定
			if (swOn[0])
			{
				//設定モード用の日時表示に変更する
				dispMode = 0;	//西暦、24時間制
				doUpdate = UPDT_DATE | UPDT_TIME;
				
				//設定モードへ移行する
				opMode = OP_ADJ_YEAR_10;
				lcdAdjModeOn();
				lcdSetPos(POS_INFO_X, POS_INFO_Y);
				lcdPutStr((uint8_t*)ADJ_INFO);
			}
			if (swOn[1])
			{
				//表示モード変更
				if (++dispMode > 3) dispMode = 0;
				doUpdate = UPDT_DATE | UPDT_TIME;
			}
			break;
			
		}	//switch()
		
	}	//while()
	
	return 0;
}
