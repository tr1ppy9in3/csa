#define _POSIX_C_SOURCE 200809L
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define MAXN 1024
#define RUNS 5
#define STRASSEN_THRESHOLD 64

static int n;
static double a[MAXN][MAXN], b[MAXN][MAXN];
static double c[MAXN][MAXN], ref[MAXN][MAXN];

static double now(void) {
    struct timespec ts;
    clock_gettime(CLOCK_MONOTONIC, &ts);
    return ts.tv_sec + ts.tv_nsec * 1e-9;
}

static void init(void) {
    for (int i = 0; i < n; i++)
        for (int j = 0; j < n; j++) {
            a[i][j] = (double)rand() / RAND_MAX;
            b[i][j] = (double)rand() / RAND_MAX;
        }
}

/* Эталон: обычное умножение, нужно для проверки и как базовый случай. */
static void naive(double out[MAXN][MAXN]) {
    for (int i = 0; i < n; i++)
        for (int j = 0; j < n; j++) {
            double s = 0;
            for (int k = 0; k < n; k++)
                s += a[i][k] * b[k][j];
            out[i][j] = s;
        }
}

static void base_matmul(int d, const double *A, int lda,
                               const double *B, int ldb,
                               double *C, int ldc) {
    for (int i = 0; i < d; i++)
        for (int j = 0; j < d; j++)
            C[i * ldc + j] = 0.0;

    for (int i = 0; i < d; i++) {
        for (int k = 0; k < d; k++) {
            double aik = A[i * lda + k];
            for (int j = 0; j < d; j++) {
                C[i * ldc + j] += aik * B[k * ldb + j];
            }
        }
    }
}

static void add_mat(int d, const double *X, int ldx,
                           const double *Y, int ldy,
                           double *Z, int ldz) {
    for (int i = 0; i < d; i++)
        for (int j = 0; j < d; j++)
            Z[i * ldz + j] = X[i * ldx + j] + Y[i * ldy + j];
}

static void sub_mat(int d, const double *X, int ldx,
                           const double *Y, int ldy,
                           double *Z, int ldz) {
    for (int i = 0; i < d; i++)
        for (int j = 0; j < d; j++)
            Z[i * ldz + j] = X[i * ldx + j] - Y[i * ldy + j];
}

static void strassen_recursive(int d, const double *A, int lda,
                                const double *B, int ldb,
                                double *C, int ldc) {
    if (d <= STRASSEN_THRESHOLD) {
        base_matmul(d, A, lda, B, ldb, C, ldc);
        return;
    }

    int m = d / 2;
    int sz = m * m;

    double *buf = (double *)malloc(sz * 9 * sizeof(double));
    if (!buf) {
        base_matmul(d, A, lda, B, ldb, C, ldc);
        return;
    }

    double *T1 = buf + 0 * sz;
    double *T2 = buf + 1 * sz;

    double *M1 = buf + 2 * sz;
    double *M2 = buf + 3 * sz;
    double *M3 = buf + 4 * sz;
    double *M4 = buf + 5 * sz;
    double *M5 = buf + 6 * sz;
    double *M6 = buf + 7 * sz;
    double *M7 = buf + 8 * sz;

    const double *A11 = A;
    const double *A12 = A + m;
    const double *A21 = A + m * lda;
    const double *A22 = A + m * lda + m;

    const double *B11 = B;
    const double *B12 = B + m;
    const double *B21 = B + m * ldb;
    const double *B22 = B + m * ldb + m;

    // M1 = (A11 + A22) * (B11 + B22)
    add_mat(m, A11, lda, A22, lda, T1, m);
    add_mat(m, B11, ldb, B22, ldb, T2, m);
    strassen_recursive(m, T1, m, T2, m, M1, m);

    // M2 = (A21 + A22) * B11
    add_mat(m, A21, lda, A22, lda, T1, m);
    strassen_recursive(m, T1, m, B11, ldb, M2, m);

    // M3 = A11 * (B12 - B22)
    sub_mat(m, B12, ldb, B22, ldb, T2, m);
    strassen_recursive(m, A11, lda, T2, m, M3, m);

    // M4 = A22 * (B21 - B11)
    sub_mat(m, B21, ldb, B11, ldb, T2, m);
    strassen_recursive(m, A22, lda, T2, m, M4, m);

    // M5 = (A11 + A12) * B22
    add_mat(m, A11, lda, A12, lda, T1, m);
    strassen_recursive(m, T1, m, B22, ldb, M5, m);

    // M6 = (A21 - A11) * (B11 + B12)
    sub_mat(m, A21, lda, A11, lda, T1, m);
    add_mat(m, B11, ldb, B12, ldb, T2, m);
    strassen_recursive(m, T1, m, T2, m, M6, m);

    // M7 = (A12 - A22) * (B21 + B22)
    sub_mat(m, A12, lda, A22, lda, T1, m);
    add_mat(m, B21, ldb, B22, ldb, T2, m);
    strassen_recursive(m, T1, m, T2, m, M7, m);

    // C11 = M1 + M4 - M5 + M7
    // C12 = M3 + M5
    // C21 = M2 + M4
    // C22 = M1 - M2 + M3 + M6
    for (int i = 0; i < m; i++) {
        for (int j = 0; j < m; j++) {
            int idx = i * m + j;
            C[i * ldc + j]             = M1[idx] + M4[idx] - M5[idx] + M7[idx];
            C[i * ldc + (j + m)]       = M3[idx] + M5[idx];
            C[(i + m) * ldc + j]       = M2[idx] + M4[idx];
            C[(i + m) * ldc + (j + m)] = M1[idx] - M2[idx] + M3[idx] + M6[idx];
        }
    }

    free(buf);
}

static void strassen(void) {
    strassen_recursive(n, &a[0][0], MAXN, &b[0][0], MAXN, &c[0][0], MAXN);
}

static double maxdiff(void) {
    double d = 0;
    for (int i = 0; i < n; i++)
        for (int j = 0; j < n; j++) {
            double x = fabs(c[i][j] - ref[i][j]);
            if (x > d) d = x;
        }
    return d;
}

int main(void) {
    const int sizes[] = {128, 256, 512, 1024};
    const int nsizes = (int)(sizeof sizes / sizeof sizes[0]);

    printf("n,method,run,seconds,gflops,maxdiff\n");
    for (int s = 0; s < nsizes; s++) {
        n = sizes[s];
        init();
        naive(ref);

        for (int m = 0; m < 2; m++) {
            const char *name = m ? "strassen" : "naive";
            for (int r = 1; r <= RUNS; r++) {
                for (int i = 0; i < n; i++)
                    for (int j = 0; j < n; j++)
                        c[i][j] = 0.0;

                double t0 = now();
                if (m) strassen();
                else   naive(c);
                double t = now() - t0;

                printf("%d,%s,%d,%.6f,%.3f,%.3e\n",
                       n, name, r, t, 2.0 * n * n * n / t / 1e9, maxdiff());
            }
        }
    }
    return 0;
}
