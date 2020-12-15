#include "helpers.h"
#include <math.h>
#include <stdlib.h>

// Convert image to grayscale
void grayscale(int height, int width, RGBTRIPLE image[height][width])
{
    float average = 0;

    for (int i = 0; i < height; i++)
    {
        for (int j = 0; j < width; j++)
        {
            average = (image[i][j].rgbtBlue + image[i][j].rgbtGreen + image[i][j].rgbtRed);
            average = average / 3;
            average = round(average);

            image[i][j].rgbtBlue = average;
            image[i][j].rgbtGreen = average;
            image[i][j].rgbtRed = average;

        }
    }
    return;
}

// Reflect image horizontally
void reflect(int height, int width, RGBTRIPLE image[height][width])
{
    int tmpBlue = 0;
    int tmpGreen = 0;
    int tmpRed = 0;

    for (int i = 0; i < height; i++)
    {
        for (int j = 0; j < width / 2; j++)
        {
            tmpBlue = image[i][j].rgbtBlue;
            tmpGreen = image[i][j].rgbtGreen;
            tmpRed = image[i][j].rgbtRed;

            image[i][j].rgbtBlue = image[i][width - 1 - j].rgbtBlue;
            image[i][j].rgbtGreen = image[i][width - 1 - j].rgbtGreen;
            image[i][j].rgbtRed = image[i][width - 1 - j].rgbtRed;

            image[i][width - 1 - j].rgbtBlue = tmpBlue;
            image[i][width - 1  - j].rgbtGreen = tmpGreen;
            image[i][width - 1 - j].rgbtRed = tmpRed;
        }
    }
    return;
}

// Blur image
void blur(int height, int width, RGBTRIPLE image[height][width])
{
    // copy of original image
    RGBTRIPLE copy[height][width];

    for (int i = 0; i < height; i++)
    {
        for (int j = 0; j < width; j++)
        {
            float avgBlue = 0;
            float avgGreen = 0;
            float avgRed = 0;

            int coords_i[3] = {i - 1, i, i + 1};
            int coords_j[3] = {j - 1, j, j + 1};

            int count = 0;

            for (int k = 0; k < 3; k++)
            {
                for (int l = 0; l < 3; l++)
                {
                    int row = coords_i[k];
                    int col = coords_j[l];

                    if (row >= 0 && row < height && col >= 0 && col < width)
                    {
                        RGBTRIPLE temp = image[row][col];

                        avgBlue += temp.rgbtBlue;
                        avgGreen += temp.rgbtGreen;
                        avgRed += temp.rgbtRed;

                        count++;
                    }

                }
            }

            copy[i][j].rgbtBlue = round(avgBlue / count);
            copy[i][j].rgbtGreen = round(avgGreen / count);
            copy[i][j].rgbtRed = round(avgRed / count);

        }
    }

    for (int i = 0; i < height; i++)
    {
        for (int j = 0; j < width; j++)
        {
            image[i][j].rgbtBlue = copy[i][j].rgbtBlue;
            image[i][j].rgbtGreen = copy[i][j].rgbtGreen;
            image[i][j].rgbtRed = copy[i][j].rgbtRed;
        }
    }

    return;
}

// Detect edges
void edges(int height, int width, RGBTRIPLE image[height][width])
{
    // copy of original image
    RGBTRIPLE copy[height][width];

    const int gx[3][3] =
    {
        {-1, 0, 1},
        {-2, 0, 2},
        {-1, 0, 1}
    };

    const int gy[3][3] =
    {
        {-1, -2, -1},
        { 0,  0,  0},
        { 1,  2,  1}
    };

    for (int i = 0; i < height; i++)
    {
        for (int j = 0; j < width; j++)
        {
            float gx_blue = 0;
            float gy_blue = 0;
            float total_blue = 0;

            float gx_green = 0;
            float gy_green = 0;
            float total_green = 0;

            float gx_red = 0;
            float gy_red = 0;
            float total_red = 0;

            int coords_i[3] = {i - 1, i, i + 1};
            int coords_j[3] = {j - 1, j, j + 1};

            for (int k = 0; k < 3; k++)
            {
                for (int l = 0; l < 3; l++)
                {
                    int row = coords_i[k];
                    int col = coords_j[l];

                    if (row >= 0 && row < height && col >= 0 && col < width)
                    {
                        RGBTRIPLE temp = image[row][col];

                        gx_blue += temp.rgbtBlue * gx[k][l];
                        gy_blue += temp.rgbtBlue * gy[k][l];

                        gx_green += temp.rgbtGreen * gx[k][l];
                        gy_green += temp.rgbtGreen * gy[k][l];

                        gx_red += temp.rgbtRed * gx[k][l];
                        gy_red += temp.rgbtRed * gy[k][l];

                    }

                }
            }



            total_blue = round(sqrt(pow(gx_blue, 2) + pow(gy_blue, 2)));
            copy[i][j].rgbtBlue = total_blue > 255 ? 255 : total_blue;

            total_green = round(sqrt(pow(gx_green, 2) + pow(gy_green, 2)));
            copy[i][j].rgbtGreen = total_green > 255 ? 255 : total_green;

            total_red = round(sqrt(pow(gx_red, 2) + pow(gy_red, 2)));
            copy[i][j].rgbtRed = total_red > 255 ? 255 : total_red;

        }
    }

    for (int i = 0; i < height; i++)
    {
        for (int j = 0; j < width; j++)
        {
            image[i][j].rgbtBlue = copy[i][j].rgbtBlue;
            image[i][j].rgbtGreen = copy[i][j].rgbtGreen;
            image[i][j].rgbtRed = copy[i][j].rgbtRed;
        }
    }

    return;
}
