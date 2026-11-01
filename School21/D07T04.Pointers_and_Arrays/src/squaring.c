#include <stdio.h>

#define MAX_SIZE 100

int input(int *arr, int *n);
void square(int *arr, int n);
void output(int *arr, int n);

int main() {
    int arr[MAX_SIZE];
    int n;

    if (!input(arr, &n)) {
        printf("n/a");
        return 1;
    }

    square(arr, n);
    output(arr, n);

    return 0;
}

int input(int *arr, int *n) {
    if (scanf("%d", n) != 1 || *n <= 0 || *n > MAX_SIZE)
        return 0;

    for (int i = 0; i < *n; i++) {
        if (scanf("%d", &arr[i]) != 1)
            return 0;
    }

    return 1;
}

void square(int *arr, int n) {
    for (int i = 0; i < n; i++) {
        arr[i] = arr[i] * arr[i];
    }
}

void output(int *arr, int n) {
    for (int i = 0; i < n; i++) {
        printf("%d", arr[i]);
        if (i < n - 1)
            printf(" ");
    }
}