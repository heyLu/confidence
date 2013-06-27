#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

int main(int argc, char **argv) {
	if (argc < 2) {
		printf("Usage: %s file-or-dir\n", argv[0]);
		return -1;
	}

	int max_path = 2 << 8;
	char *path = malloc(sizeof(char) * max_path);
	do {
		getcwd(path, max_path);
		if (access(argv[1], F_OK) == 0) {
			printf("%s\n", path);
			return 0;
		} else {
			chdir("..");
		}
	} while (strcmp("/", path) != 0);

	return 1;
}
