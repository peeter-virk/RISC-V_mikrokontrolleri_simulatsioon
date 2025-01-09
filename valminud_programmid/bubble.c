#include <stdio.h>
#pragma GCC section data=".data"

int arr[]  = {64, 34, 25, 12, 22, 11, 1};

void bubbleSort(int arr[], int n) {
    for (int i = 0; i < n-1; i++) {
        for (int j = 0; j < n-i-1; j++) {
            if (arr[j] > arr[j+1]) {
                // Swap arr[j] and arr[j+1]
                int temp = arr[j];
                arr[j] = arr[j+1];
                arr[j+1] = temp;
            }
        }
    }
}

int main() {

    bubbleSort(arr, 7);
    while(1);
}
