/* FastCGI to match if client connect as tor */
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <fcgi_stdio.h>

#define TEXT "/var/cache/dyn/exits.txt"
#define HOST "pickfireywcq2wf2.onion"

/*
 * Appends src to string dst of size dsize (unlike strncat, dsize is the
 * full size of dst, not space left).  At most dsize-1 characters
 * will be copied.  Always NUL terminates (unless dsize <= strlen(dst)).
 * Returns strlen(src) + MIN(dsize, strlen(initial dst)).
 * If retval >= dsize, truncation occurred.
 */
size_t
strlcat(char *dst, const char *src, size_t dsize)
{
        const char *odst = dst;
        const char *osrc = src;
        size_t n = dsize;
        size_t dlen;

        /* Find the end of dst and adjust bytes left but don't go past end. */
        while (n-- != 0 && *dst != '\0')
                dst++;
        dlen = dst - odst;
        n = dsize - dlen;

        if (n-- == 0)
                return(dlen + strlen(src));
        while (*src != '\0') {
                if (n != 0) {
                        *dst++ = *src;
                        n--;
                }
                src++;
        }
        *dst = '\0';

        return(dlen + (src - osrc));    /* count does not include NUL */
}

/*
 * Copy src to string dst of size siz. At most siz-1 characters
 * will be copied. Always NUL terminates (unless siz == 0).
 * Returns strlen(src); if retval >= siz, truncation occurred.
 */
size_t
strlcpy(char *dst, const char *src, size_t siz)
{
        char *d = dst;
        const char *s = src;
        size_t n = siz;
        /* Copy as many bytes as will fit */
        if (n != 0) {
                while (--n != 0) {
                        if ((*d++ = *s++) == '\0')
                                break;
                }
        }
        /* Not enough room in dst, add NUL and traverse rest of src */
        if (n == 0) {
                if (siz != 0)
                        *d = '\0'; /* NUL-terminate dst */
                while (*s++)
                        ;
        }
        return(s - src - 1); /* count does not include NUL */
}

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
			strlcpy(ip, getenv("REMOTE_ADDR"), 15);
			strlcat(ip, "\n", 1);

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
