#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

int main(int argc, char *argv[])
{
    // Check usage
    if (argc != 2)
    {
        printf("Usage: ./recover image");
        return 1;
    }

    // Open file
    FILE *file = fopen(argv[1], "r");
    if (!file)
    {
        return 1;
    }

    // creating buffer
    unsigned char buffer[512];

    // image counter and file to write
    int image_count = 0;
    FILE *image_ptr = NULL;

    // check if jpeg was found
    bool jpeg_already_found = false;

    while (fread(buffer, 512, 1, file) == 1)
    {
        // Check first four bytes
        if (buffer[0] == 0xff && buffer[1] == 0xd8 && buffer[2] == 0xff && (buffer[3] & 0xf0) == 0xe0)
        {
            if (jpeg_already_found)
            {
                fclose(image_ptr);
            }
            else
            {
                jpeg_already_found = true;
            }

            char filename[8];
            sprintf(filename, "%03i.jpg", image_count);
            image_ptr = fopen(filename, "w");
            image_count++;
        }
        if (jpeg_already_found)
        {
            fwrite(buffer, 512, 1, image_ptr);
        }
    }


    // Closing files
    fclose(file);
    fclose(image_ptr);

    return 0;
}
