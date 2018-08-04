/* FastCGI to match if client connect as tor */
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <fcgi_stdio.h>

#define TEXT "/var/cache/dyn/exits.txt"
#define HOST "pickfireywcq2wf2.onion"

int main()
{
	FILE *fp;
	char *ip, buf[16];
	int tor;

	while (FCGI_Accept() >= 0) {
		tor = 0;

		if (strstr(HOST, getenv("SERVER_NAME")) != NULL)
			tor = 1;
		else {
			ip = strncat(getenv("REMOTE_ADDR"), "\n", 15);

			if (!(fp = fopen(TEXT, "r")))
				return 1;
			while (fgets(buf, 16, fp))
				if (!strncmp(buf, ip, 15)) {
					tor = 1;
					break;
				}
			fclose(fp);
		}
		printf("Content-type: text/css\r\n\r\n#tor{color:%s}",
			tor ? "#008700" : "#df0000");
	}
}
