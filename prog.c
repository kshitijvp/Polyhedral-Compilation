#include <stdio.h>
int A[200][200];

int main() {
        int i, j;
        for (j = 0; j < 200; j++) {
                A[0][j] = 1;
        }
        for (i = 0; i < 200; i++) {
                A[i][0] = 1;
        }
        
        for (i = 1; i < 200; i++) {
                for (j = 1; j < 200; j++) {
                        A[i][j] = A[i - 1][j - 1] + (i * j); //stmtforbody3
                }
        
        }
        return 0;
}