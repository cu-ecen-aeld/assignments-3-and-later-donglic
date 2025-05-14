#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <syslog.h>

int main(int argc, char *argv[]) {
    // Open syslog with LOG_USER facility
    openlog("writer", LOG_PID, LOG_USER);

    // Check argument count
    if (argc != 3) {
        syslog(LOG_ERR, "Invalid number of arguments: expected 2, got %d", argc - 1);
        fprintf(stderr, "Usage: %s <file> <string>\n", argv[0]);
        closelog();
        return 1;
    }

    const char *filename = argv[1];
    const char *text = argv[2];

    // Open the file for writing
    FILE *fp = fopen(filename, "w");
    if (fp == NULL) {
        syslog(LOG_ERR, "Failed to open file '%s' for writing", filename);
        perror("fopen");
        closelog();
        return 1;
    }

    // Write the string
    if (fprintf(fp, "%s", text) < 0) {
        syslog(LOG_ERR, "Failed to write to file '%s'", filename);
        perror("fprintf");
        fclose(fp);
        closelog();
        return 1;
    }

    syslog(LOG_DEBUG, "Writing \"%s\" to \"%s\"", text, filename);

    fclose(fp);
    closelog();
    return 0;
}
