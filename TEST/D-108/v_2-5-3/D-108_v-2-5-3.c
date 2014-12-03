#include <stdlib.h>
#include <stdio.h>


void conv_Dex_to_Binary(int, char[9]);
//void conv_Dex_to_Binary(int, char*);

int conv_Binary_to_Hex(char[9]);

void shift_Right_Left(int);
void RRF(int);
int RRF_2(int);
int RLF(int);

///////////////////////

// funcs

///////////////////////
void main(void) {

	int num = 0xFA;

	int tmp;

//	int num = 0x6d;
//	int num = 0x6c;
//	int num = 0xEB;
//	int num = 0xEA;

//	char binary[] = "10101101";		// 0xAD
//
//	int tmp;
//
//	printf("[%d] binary: size => %d\n", __LINE__, sizeof(binary));
//
//	tmp = conv_Binary_to_Hex(binary);
//
//	printf("[%d] tmp => %d (%02x)\n", __LINE__, tmp, tmp);

//	conv_Binary_to_Hex(binary, sizeof(binary));

//	tmp = RRF_2(num);
//	tmp = RLF(num);

	printf("[%d] tmp => 0x%02x, d = %d\n", __LINE__, tmp, tmp);

//	RRF_2(num);
//	RRF(num);
//	shift_Right_Left(num);

//	int c1 = 0x0C;
////	int c1 = 0xFC;
//
//	char binary[9];
//
//
//	printf("c1 => %d\n", c1);
//
//	///////////////////////
//
//	// shift
//
//	///////////////////////
//	c1 = c1 >> 1;
//
//	printf("c1 >> 1 ------------------\n");
//	printf("c1 => %d\n", c1);
//
//	///////////////////////
//
//	// conversion
//
//	///////////////////////
//	conv_Dex_to_Binary(0xCE, binary);
////	conv_Dex_to_Binary(0x0C, binary);
//
//	printf("conversion ------------------\n");
//	printf("binary => %s\n", binary);

    return;

}

void conv_Dex_to_Binary
(int num, char result[9]) {

	int i;
	int len = 8;

	int tmp;

//	//debug
//	printf("\n");
//	printf("[%d] start conversion...\n", __LINE__);

//	printf("\n");
//	printf("[%d] hex => %02x, dex => %d\n", __LINE__, num, num);

	for (i = len - 1; i >= 0; i --) {

		tmp = num & 0x01;

		if (tmp == 1) {

			result[i] = '1';

		} else {

			result[i] = '0';

		}

		// shift
		num = num >> 1;

	}

	///////////////////////

	// null char

	///////////////////////
	result[8] = '\0';

	///////////////////////

	// report

	///////////////////////
//	printf("\n");
//	printf("result => %s\n", result);
////	printf("result => %s (%x)\n", result, num);

}

int conv_Binary_to_Hex
(char result[9]) {

	int num;

	int i;

	int len = 8;

	char binary[9];

	num = 0x00;

////	//debug
//	printf("\n");
//	printf("[%d] binary => %s\n", __LINE__, result);

	for (i = 0; i < len; i++) {
//	for (i = len - 1; i >= 0; i --) {

//		printf("[%d] result[%d] => %c\n", __LINE__, i, result[i]);

		num = num << 1;

		if (result[i] == '1') {

			num = num | 0x01;

		} else {

			num = num | 0x00;

		}

	}

	///////////////////////

	// report

	///////////////////////
	conv_Dex_to_Binary(num, binary);

//	printf("[%d] num => %d (%s) (hex=%02x)\n", __LINE__, num, binary, num);

	return num;

}//conv_Binary_to_Hex

void shift_Right_Left(int num) {

	//debug
	printf("\n");
	printf("[%d] ----------- shift_Right_Left -----------\n", __LINE__);

	printf("[%d] num => %d (%02x)\n", __LINE__, num, num);

	///////////////////////

	// shift: right

	///////////////////////
	num = num >> 3;

	//debug
	printf("\n");
	printf("[%d] ----------- num >> 3 -----------\n", __LINE__);

	printf("[%d] num => %d (%02x)\n", __LINE__, num, num);

	///////////////////////

	// shift: left

	///////////////////////
	num = num << 3;

	//debug
	printf("\n");
	printf("[%d] ----------- num << 3 -----------\n", __LINE__);

	printf("[%d] num => %d (%02x)\n", __LINE__, num, num);


}

void RRF(int num) {

	int tmp1 = num & 0x01;
	int tmp2;
//	int tmp1 = 0x01;

	char tmp1_bin[9];
	char tmp2_bin[9];

	char num_bin[9];

	conv_Dex_to_Binary(tmp1, tmp1_bin);
	conv_Dex_to_Binary(num, num_bin);

	//debug
	printf("\n");
	printf("[%d] ----------- shift_Right_Left -----------\n", __LINE__);

	//REF printf + hex value http://stackoverflow.com/questions/3649026/how-to-display-hexadecimal-numbers-in-c answered Sep 6 '10 at 4:40
	printf("[%d] num => %s (d=%d) (0x%02x)\n", __LINE__, num_bin, num, num);

	printf("[%d] tmp1 => %s (0x%02x)\n", __LINE__, tmp1_bin, tmp1);

	///////////////////////

	// shift 7

	///////////////////////
	printf("\n");
	printf("[%d] ----------- tmp1 << 7 -----------\n", __LINE__);

	tmp1 = tmp1 << 7;

	conv_Dex_to_Binary(tmp1, tmp1_bin);

	printf("[%d] tmp1 => %s (0x%02x)\n", __LINE__, tmp1_bin, tmp1);

	///////////////////////

	// modify

	///////////////////////
	printf("\n");
	printf("[%d] ----------- tmp1 | 0x7F -----------\n", __LINE__);
//	printf("[%d] ----------- tmp1 | 0xFF -----------\n", __LINE__);

	tmp1 = tmp1 | 0x7F;
//	tmp1 = tmp1 | 0xFF;

	conv_Dex_to_Binary(tmp1, tmp1_bin);

	printf("[%d] tmp1 => %s (0x%02x)\n", __LINE__, tmp1_bin, tmp1);

	///////////////////////

	// shift: >> 1

	///////////////////////
	num = num >> 1;

	conv_Dex_to_Binary(num, num_bin);

	//debug
	printf("\n");
	printf("[%d] ----------- shift 1: num >> 1 -----------\n", __LINE__);

	printf("[%d] num => %s (d=%d) (0x%02x)\n", __LINE__, num_bin, num, num);

	///////////////////////

	// shift 2: >> 1

	///////////////////////
	num = num >> 1;

	conv_Dex_to_Binary(num, num_bin);

	//debug
	printf("\n");
	printf("[%d] ----------- shift 2: num >> 1 -----------\n", __LINE__);

	printf("[%d] num => %s (d=%d) (0x%02x)\n", __LINE__, num_bin, num, num);

	///////////////////////

	// rotate

	///////////////////////
	printf("\n");
	printf("[%d] ----------- tmp1 & num -----------\n", __LINE__);
//	printf("[%d] ----------- tmp1 | 0xFF -----------\n", __LINE__);

	tmp2 = tmp1 & num;
//	tmp1 = tmp1 | 0xFF;

	conv_Dex_to_Binary(tmp2, tmp2_bin);

	printf("[%d] tmp2 => %s (d=%d) (0x%02x)\n", __LINE__, tmp2_bin, tmp2, tmp2);

}

int RRF_2(int num) {

	int tmp1;
	int tmp2;
	int tmp3;
	int tmp;

	char tmp_bin[9];

	char num_bin[9];

//	conv_Dex_to_Binary(tmp1, tmp1_bin);
	conv_Dex_to_Binary(num, num_bin);

	//debug
	printf("\n");
	printf("[%d] ----------- num -----------\n", __LINE__);

	//REF printf + hex value http://stackoverflow.com/questions/3649026/how-to-display-hexadecimal-numbers-in-c answered Sep 6 '10 at 4:40
	printf("[%d] num => %s (d=%d) (0x%02x)\n", __LINE__, num_bin, num, num);

	//debug
	printf("\n");
	printf("[%d] ----------- tmp1 = num & 0x01 -----------\n", __LINE__);

	tmp1 = num & 0x01;
	conv_Dex_to_Binary(tmp1, tmp_bin);

	printf("[%d] tmp1 => %s (d=%d) (0x%02x)\n", __LINE__, tmp_bin, tmp1, tmp1);

	//debug
	printf("\n");
	printf("[%d] ----------- tmp1 = tmp1 << 7 -----------\n", __LINE__);

	tmp1 = tmp1 << 7;
	conv_Dex_to_Binary(tmp1, tmp_bin);

	//REF printf + hex value http://stackoverflow.com/questions/3649026/how-to-display-hexadecimal-numbers-in-c answered Sep 6 '10 at 4:40
	printf("[%d] tmp1 => %s (d=%d) (0x%02x)\n", __LINE__, tmp_bin, tmp1, tmp1);

	//debug
	printf("\n");
	printf("[%d] ----------- num = num >> 1 -----------\n", __LINE__);

	num = num >> 1;
	conv_Dex_to_Binary(num, num_bin);

	//REF printf + hex value http://stackoverflow.com/questions/3649026/how-to-display-hexadecimal-numbers-in-c answered Sep 6 '10 at 4:40
	printf("[%d] num => %s (d=%d) (0x%02x)\n", __LINE__, num_bin, num, num);

	//debug
	printf("\n");
	printf("[%d] ----------- tmp2 = num & 0x7F -----------\n", __LINE__);

	tmp2 = num & 0x7F;
	conv_Dex_to_Binary(tmp2, tmp_bin);

	//REF printf + hex value http://stackoverflow.com/questions/3649026/how-to-display-hexadecimal-numbers-in-c answered Sep 6 '10 at 4:40
	printf("[%d] tmp2 => %s (d=%d) (0x%02x)\n", __LINE__, tmp_bin, tmp2, tmp2);

	//debug
	printf("\n");
	printf("[%d] ----------- tmp3 = tmp1 | tmp2 -----------\n", __LINE__);

	tmp3 = tmp1 | tmp2;
	conv_Dex_to_Binary(tmp3, tmp_bin);

	//REF printf + hex value http://stackoverflow.com/questions/3649026/how-to-display-hexadecimal-numbers-in-c answered Sep 6 '10 at 4:40
	printf("[%d] tmp3 => %s (d=%d) (0x%02x)\n", __LINE__, tmp_bin, tmp3, tmp3);

	tmp = conv_Binary_to_Hex(tmp_bin);

	printf("[%d] tmp_bin => %s (d=%d, 0x%02x)\n", __LINE__, tmp_bin, tmp, tmp);

//	printf("[%d] tmp1 => %s (0x%02x)\n", __LINE__, tmp1_bin, tmp1);

	return tmp;

}

int RLF(int num) {

	int tmp1;
	int tmp2;
	int tmp3;
	int tmp;

	char tmp_bin[9];

	char num_bin[9];

//	conv_Dex_to_Binary(tmp1, tmp1_bin);
	conv_Dex_to_Binary(num, num_bin);

	//debug
	printf("\n");
	printf("[%d] ----------- num -----------\n", __LINE__);

	//REF printf + hex value http://stackoverflow.com/questions/3649026/how-to-display-hexadecimal-numbers-in-c answered Sep 6 '10 at 4:40
	printf("[%d] num => %s (d=%d) (0x%02x)\n", __LINE__, num_bin, num, num);

	//debug
	printf("\n");
	printf("[%d] ----------- tmp1 = num & 0x80 -----------\n", __LINE__);

	tmp1 = num & 0x80;
	conv_Dex_to_Binary(tmp1, tmp_bin);

	printf("[%d] tmp1 => %s (d=%d) (0x%02x)\n", __LINE__, tmp_bin, tmp1, tmp1);

	//debug
	printf("\n");
	printf("[%d] ----------- tmp1 = tmp1 >> 7 -----------\n", __LINE__);

	tmp1 = tmp1 >> 7;
	conv_Dex_to_Binary(tmp1, tmp_bin);

	//REF printf + hex value http://stackoverflow.com/questions/3649026/how-to-display-hexadecimal-numbers-in-c answered Sep 6 '10 at 4:40
	printf("[%d] tmp1 => %s (d=%d) (0x%02x)\n", __LINE__, tmp_bin, tmp1, tmp1);

	//debug
	printf("\n");
	printf("[%d] ----------- num = num << 1 -----------\n", __LINE__);

	num = num << 1;
	conv_Dex_to_Binary(num, num_bin);

	//REF printf + hex value http://stackoverflow.com/questions/3649026/how-to-display-hexadecimal-numbers-in-c answered Sep 6 '10 at 4:40
	printf("[%d] num => %s (d=%d) (0x%02x)\n", __LINE__, num_bin, num, num);

	//debug
	printf("\n");
	printf("[%d] ----------- tmp2 = num & 0xFE -----------\n", __LINE__);

	tmp2 = num & 0xFE;
	conv_Dex_to_Binary(tmp2, tmp_bin);

	//REF printf + hex value http://stackoverflow.com/questions/3649026/how-to-display-hexadecimal-numbers-in-c answered Sep 6 '10 at 4:40
	printf("[%d] tmp2 => %s (d=%d) (0x%02x)\n", __LINE__, tmp_bin, tmp2, tmp2);

	//debug
	printf("\n");
	printf("[%d] ----------- tmp3 = tmp1 | tmp2 -----------\n", __LINE__);

	tmp3 = tmp1 | tmp2;
	conv_Dex_to_Binary(tmp3, tmp_bin);

	//REF printf + hex value http://stackoverflow.com/questions/3649026/how-to-display-hexadecimal-numbers-in-c answered Sep 6 '10 at 4:40
	printf("[%d] tmp3 => %s (d=%d) (0x%02x)\n", __LINE__, tmp_bin, tmp3, tmp3);

	tmp = conv_Binary_to_Hex(tmp_bin);
//
//	printf("[%d] tmp_bin => %s (d=%d, 0x%02x)\n", __LINE__, tmp_bin, tmp, tmp);

//	printf("[%d] tmp1 => %s (0x%02x)\n", __LINE__, tmp1_bin, tmp1);

	return tmp;

}
