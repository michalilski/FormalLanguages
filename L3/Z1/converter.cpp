#include "converter.h"

unsigned long convert(long value, long base){
    long mod = value % base;
    if (mod < 0){
        mod += base;
    }
    return mod;
}

unsigned long power(long a, long b, long p){
    unsigned long res = 1;

    if (b < 0){
       long b = convert(b, p);
    } 
    
    for (long i=0; i<b; ++i){
        res = convert(res*a, p);
    }
    return res;
}

unsigned long divide(long a, long b, long p){
    long x, y;
    long gcd = gcdExtended(p,b,&x,&y);
    unsigned long y2 = convert(y, p);
    return convert(y2*a, p); 
}

long gcdExtended(long a, long b, long *x, long *y)
{ 
	// Base Case 
	if (a == 0) 
	{ 
		*x = 0; 
		*y = 1; 
		return b; 
	} 

	long x1, y1; // To store results of recursive call 
	long gcd = gcdExtended(b%a, a, &x1, &y1); 

	// Update x and y using results of 
	// recursive call 
	*x = y1 - (b/a) * x1; 
	*y = x1; 

	return gcd; 
} 