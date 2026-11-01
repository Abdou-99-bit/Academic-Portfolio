#include <stdio.h>

#define MAX_SIZE 10

int input(int *arr, int *n);
int sum_even(int *arr, int n);
int filter_divisible(int *arr, int n, int sum, int *out_arr);
void output_sum(int sum);
void output_array(int *arr, int n);

int main() {
    int arr[MAX_SIZE];
    int n;

    if (!input(arr, &n)) {
        printf("n/a");
        return 0;
    }

    int sum = sum_even(arr, n);
    if (sum == 0) {
        printf("n/a");
        return 0;
    }

    int new_arr[MAX_SIZE];
    int new_size = filter_divisible(arr, n, sum, new_arr);

    output_sum(sum);
    output_array(new_arr, new_size);

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


int sum_even(int *arr, int n) {
    int sum = 0;
    for (int i = 0; i < n; i++) {
        if (arr[i] != 0 && arr[i] % 2 == 0)
            sum += arr[i];
    }
    return sum;
}


int filter_divisible(int *arr, int n, int sum, int *out_arr) {
    int k = 0;
    for (int i = 0; i < n; i++) {
        if (arr[i] != 0 && sum % arr[i] == 0) { 
            out_arr[k++] = arr[i];
        }
        
        else if (arr[i] == 1 || arr[i] == -1) {
            out_arr[k++] = arr[i];
        }
    }
    return k;
}


void output_sum(int sum) {
    printf("%d\n", sum);
}


void output_array(int *arr, int n) {
    for (int i = 0; i < n; i++) {
        printf("%d", arr[i]);
        if (i < n - 1)
            printf(" ");
    }
}