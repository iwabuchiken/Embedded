//http://www.mikroe.com/forum/viewtopic.php?t=8946
void strConstCpy
(char *dest, const char *source)
{
	while(*source)
	*dest++ = *source++ ;

	*dest = 0 ;
}

void strConstCpy2
(char *dest, const char *source)
{
	while(*source)
	*dest++ = *source++ ;

	*dest = 0 ;
}