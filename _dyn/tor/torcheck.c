/* CGI to match if client connect as tor */
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define file "/var/cache/dyn/exits.txt"

int
main(int argc, char *argv[])
{
	FILE *fp;
	char *ip, buf[16];
	int tor = 0;

	printf("Content-Type:text/css\n\n"); /* HTTP Header */

	ip = getenv("REMOTE_ADDR");
	if (!strncat(ip, "\n", 16))
		return 1;

	if (!(fp = fopen(file, "r")))
		return 1;

	while (fgets(buf, 16, fp))
		if (!strncmp(buf, ip, 15)) {
			tor = 1;
			break;
		}
	fclose(fp);

	printf("#tor{color:%s !important}", tor ? "#008700" : "#df0000");
	return 0;
}
