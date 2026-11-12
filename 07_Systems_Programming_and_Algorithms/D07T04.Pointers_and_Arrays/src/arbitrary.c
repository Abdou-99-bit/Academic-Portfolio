#include <stdio.h>

#define MAX_DIGITS 100

int input_number(int *arr, int *len);
void add_numbers(int *a, int len_a, int *b, int len_b, int *res, int *len_res);
int subtract_numbers(int *a, int len_a, int *b, int len_b, int *res, int *len_res);
void print_number(int *arr, int len);

int main() {
    int a[MAX_DIGITS], b[MAX_DIGITS];
    int len_a, len_b;

    if (!input_number(a, &len_a) || !input_number(b, &len_b)) {
        printf("n/a");
        return 0;
    }

    int sum[MAX_DIGITS + 1], len_sum;
    add_numbers(a, len_a, b, len_b, sum, &len_sum);
    print_number(sum, len_sum);
    printf("\n");

    int diff[MAX_DIGITS], len_diff;
    if (!subtract_numbers(a, len_a, b, len_b, diff, &len_diff)) {
        printf("n/a");
        return 0;
    }
    print_number(diff, len_diff);

    return 0;
}


int input_number(int *arr, int *len) {
    int i = 0, val;
    *len = 0;
    while (scanf("%d", &val) == 1) {
        if (val < 0 || val > 9) return 0; 
        if (i >= MAX_DIGITS) return 0;
        arr[i++] = val;
    }
    *len = i;
    return i > 0;
}


void add_numbers(int *a, int len_a, int *b, int len_b, int *res, int *len_res) {
    int i = len_a - 1, j = len_b - 1, k = 0, carry = 0;
    int temp[MAX_DIGITS + 1];

    while (i >= 0 || j >= 0 || carry) {
        int sum = carry;
        if (i >= 0) sum += a[i--];
        if (j >= 0) sum += b[j--];
        temp[k++] = sum % 10;
        carry = sum / 10;
    }

    
    for (int m = 0; m < k; m++)
        res[m] = temp[k - m - 1];
    *len_res = k;
}


int subtract_numbers(int *a, int len_a, int *b, int len_b, int *res, int *len_res) {
    
    if (len_b > len_a) return 0;
    if (len_b == len_a) {
        for (int i = 0; i < len_a; i++) {
            if (b[i] > a[i]) return 0;
            if (b[i] < a[i]) break;
        }
    }

    int i = len_a - 1, j = len_b - 1, k = 0, borrow = 0;
    int temp[MAX_DIGITS];

    while (i >= 0) {
        int sub = a[i] - borrow;
        if (j >= 0) sub -= b[j--];
        if (sub < 0) { sub += 10; borrow = 1; } else borrow = 0;
        temp[k++] = sub;
        i--;
    }


    while (k > 1 && temp[k - 1] == 0) k--;

    
    for (int m = 0; m < k; m++)
        res[m] = temp[k - m - 1];
    *len_res = k;

    return 1;
}


void print_number(int *arr, int len) {
    for (int i = 0; i < len; i++)
        printf("%d", arr[i]);
}