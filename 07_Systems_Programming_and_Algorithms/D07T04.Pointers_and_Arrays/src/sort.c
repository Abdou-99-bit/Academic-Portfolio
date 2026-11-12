#include <stdio.h>

#define SIZE 10

int input(int *arr);
void sort(int *arr, int n);
void output(int *arr, int n);

int main() {
    int arr[SIZE];

    if (!input(arr)) {
        printf("n/a");
        return 1;
    }

    sort(arr, SIZE);
    output(arr, SIZE);

    return 0;
}

int input(int *arr) {
    for (int i = 0; i < SIZE; i++) {
        if (scanf("%d", &arr[i]) != 1)
            return 0;
    }
    return 1;
}

void sort(int *arr, int n) {
    for (int i = 0; i < n - 1; i++) {
        for (int j = 0; j < n - i - 1; j++) {
            if (arr[j] > arr[j + 1]) {
                int tmp = arr[j];
                arr[j] = arr[j + 1];
                arr[j + 1] = tmp;
            }
        }
    }
}

void output(int *arr, int n) {
    for (int i = 0; i < n; i++) {
        printf("%d", arr[i]);
        if (i < n - 1)
            printf(" ");
    }
}