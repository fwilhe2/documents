#include <stdio.h>
 
int main(void)
{
	int s = 1, p = 1;
	#pragma omp parallel shared(s) private(p)
	{
		s++;
		p++;
		printf("s = %d\n", s);
		printf("p = %d\n", p);
	}
	return 0;
}