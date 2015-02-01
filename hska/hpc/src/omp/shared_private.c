#include <stdio.h>
 
int main(void)
{
	int s = 0;
	int p;
	#pragma omp parallel shared(s) private(p)
	{
		p = 0;
		s++;
		p++;
		printf("s = %d\n", s);
		printf("p = %d\n", p);
	}
	return 0;
}
