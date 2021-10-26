/* Lucas Voron
10/04/2021
COEN 20L
Lab 2 */

#include <stdint.h>

int32_t Bits2Signed(int8_t bits[8]) // Convert array of bits to signed int
{
    int n;
    int i;

    n=-1*bits[7]; // Makes the integer created multiplied by the sign of the array
    for(i=6; i>=0; i--) // Loops through the remaining 7 bits in the array and converts to integer value
    {
        n=2*n+bits[i];
    }
    return n;
}

uint32_t Bits2Unsigned(int8_t bits[8]) // Convert array of bits to unsigned int
{
    int n=0;
    int i;

    for(i=7; i>=0; i--) // Goes through the array and multiplies each bit to get integer number
    {
        n=2*n+bits[i];
    }
    return n;
}

void Increment(int8_t bits[8]) // Add 1 to value represented by bit pattern
{
    int i;

    for(i=0; i<=7; i++) //Goes through the array to check if the last digit can be incremented, and then continues moving
    {
        if(bits[i] == 0)
        {
			bits[i] = 1;
			break;
		}
		bits[i] = 0;
    }
    return;
}

void Unsigned2Bits(uint32_t n, int8_t bits[8]) // Opposite of Bits2Unsigned
{
	int i;
    for(i=0; i<=7; i++) // Goes through the array of bits and divides for remainder
    {
		bits[i] = n%2;
		n = n/2;
	}
}