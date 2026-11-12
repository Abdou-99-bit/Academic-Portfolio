#include <stdio.h>
#include <math.h>

#define MAX_SIZE 30

int input(int *arr, int *n);
double mean(int *arr, int n);
double variance(int *arr, int n, double mean_val);
int search(int *arr, int n, double mean_val, double std_dev);

int main() {
    int arr[MAX_SIZE];
    int n;

    if (!input(arr, &n)) {
        printf("n/a");
        return 1;
    }

    double mean_val = mean(arr, n);
    double var_val = variance(arr, n, mean_val);
    double std_dev = sqrt(var_val);

    int result = search(arr, n, mean_val, std_dev);

    printf("%d", result);

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

double mean(int *arr, int n) {
    double sum = 0.0;
    for (int i = 0; i < n; i++)
        sum += arr[i];
    return sum / n;
}

double variance(int *arr, int n, double mean_val) {
    double sum = 0.0;
    for (int i = 0; i < n; i++) {
        double diff = arr[i] - mean_val;
        sum += diff * diff;
    }
    return sum / n;
}

int search(int *arr, int n, double mean_val, double std_dev) {
    for (int i = 0; i < n; i++) {
        int x = arr[i];

        if (x != 0 &&
            x % 2 == 0 &&
            x >= mean_val &&
            fabs(x - mean_val) <= 3 * std_dev) {
            return x;
        }
    }
    return 0;
}