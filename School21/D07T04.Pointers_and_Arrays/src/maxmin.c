#include <stdio.h>

void maxmin(int a, int b, int c, int *max, int *min);

int main() {
    int a, b, c;

    if (scanf("%d %d %d", &a, &b, &c) != 3) {
        printf("n/a");
        return 1;
    }

    int max, min;
    maxmin(a, b, c, &max, &min);

    printf("%d %d", max, min);

    return 0;
}

void maxmin(int a, int b, int c, int *max, int *min) {
    *max = a;
    *min = a;

    if (b > *max)
        *max = b;
    if (b < *min)
        *min = b;

    if (c > *max)
        *max = c;
    if (c < *min)
        *min = c;
}