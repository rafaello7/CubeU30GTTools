#include <stdio.h>
#include <fcntl.h>
#include <linux/fb.h>

int main(int argc, char *argv[])
{
    int fd;

    if( argc == 1 || strcmp(argv[1], "resume") )
        return 0;
    if( (fd = open("/dev/fb0", O_RDWR)) < 0 ) {
        perror("/dev/fb0");
        return 1;
    }
    if( ioctl(fd, FBIOBLANK, VESA_NO_BLANKING) != 0 )
        perror("ioctl");
    return 0;
}
