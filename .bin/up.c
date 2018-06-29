#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#define MAX_PATH (2 << 8)

int main(int argc, char **argv) {
	if (argc < 2) {
		printf("Usage: %s file-or-dir\n", argv[0]);
		return -1;
	}

	int status = EXIT_FAILURE;
	char *path = malloc(sizeof(char) * MAX_PATH);
	do {
		getcwd(path, MAX_PATH);
		if (access(argv[1], F_OK) == 0) {
			printf("%s\n", path);
			status = EXIT_SUCCESS;
			goto exit;
		}

		chdir("..");
	} while (strcmp("/", path) != 0);

exit:
	free(path);
	return status;
}
