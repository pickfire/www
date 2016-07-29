/*
 * Update the tor exit lists
 * Usage: ./update | sort -n | uniq > exits.txt
 */

#include <stdio.h>
#include <unistd.h>
#include <dirent.h>
#include <string.h>

#include <sys/stat.h>

#define f_dir "/var/cache/dyn/descriptors/recent/exit-lists/"

int
main(int argc, char *argv[])
{
	struct dirent *ep;

	DIR  *dp;
	FILE *fp;
	char desc[6], ip[16];
	int c, i;

	if ((dp = opendir(f_dir)) == NULL)
		perror("Couldn't open the directory");
	chdir(f_dir);

	while ((ep = readdir(dp)) != NULL) {
		struct stat st;
		stat(ep->d_name, &st);
		if (!S_ISREG(st.st_mode))
			continue;

		fp = fopen(ep->d_name, "r");
		for (i = 0; i < 5; i++) /* skip 5 lines */
			while ((c = getc(fp)) != EOF && c != '\n');

		while (fgets(desc, 6, fp)) {
			if (strcmp(desc, "ExitA")) {
				while ((c = getc(fp)) != EOF && c != '\n');
				continue;
			}
			fscanf(fp, "ddress %s", ip);

			printf("%s\n", ip);
			while ((c = getc(fp)) != EOF && c != '\n');
		}

		fclose(fp);
	}

	return 0;
}
