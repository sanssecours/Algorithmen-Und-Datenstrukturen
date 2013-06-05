void function(int n)
{
    if (n < 1) return;
	/* Loop with Theta (n^4) — f(n) = n^4, c = 4 */
	for (int count = 0; count < pow(n,4); count++);
	/*	a = 16 (calls), b = 2 (half the run time for recursive
        function) */
	for (int count = 0; count < 16; count++) function(n/2);
}
