
#include "stdint.h"
#include "stdbool.h"
#include <pdk/device.h>

#define get(port,pin)		(port & (1<<pin))
#define set1(port,pin)		port |=  (1<<pin)
#define set0(port,pin)		port &= ~(1<<pin)
#define set(port,pin,val)	{if (val) set1(port,pin); else set0(port,pin);}

uint16_t cnt;
static const uint16_t th=0x1234;

void main() {
	for(;;) {
		if get(PA,0) {
			set0(PA,0);
		}
		else{
			set1(PA,0);
		}
		while ( get(PA,1) ) {}
		while ( get(PA,2) ) cnt++;
		do 
			cnt++;
		while ( get(PA,3) );
		do 
			cnt++;
		while ( !get(PA,3) );
		set(PA,4, (cnt>th) );
	}
}