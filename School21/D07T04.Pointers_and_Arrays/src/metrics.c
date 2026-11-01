#include <stdio.h>

#define MAX_SIZE 100

int input(int *arr, int *n);
void output(int *arr, int n);
int max(int *arr, int n);
int min(int *arr, int n);
double mean(int *arr, int n);
double variance(int *arr, int n, double mean_val);

int main() {
    int arr[MAX_SIZE];
    int n;

    if (!input(arr, &n)) {
        printf("n/a");
        return 1;
    }

    output(arr, n);

    int max_val = max(arr, n);
    int min_val = min(arr, n);
    double mean_val = mean(arr, n);
    double var_val = variance(arr, n, mean_val);

    printf("\n%d %d %.6f %.6f", max_val, min_val, mean_val, var_val);

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

void output(int *arr, int n) {
    for (int i = 0; i < n; i++) {
        printf("%d", arr[i]);
        if (i < n - 1)
            printf(" ");
    }
}

int max(int *arr, int n) {
    int max_val = arr[0];
    for (int i = 1; i < n; i++)
        if (arr[i] > max_val)
            max_val = arr[i];
    return max_val;
}

int min(int *arr, int n) {
    int min_val = arr[0];
    for (int i = 1; i < n; i++)
        if (arr[i] < min_val)
            min_val = arr[i];
    return min_val;
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