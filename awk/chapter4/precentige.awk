# percent - compute percentage each input number represents
#   input: a column of nonnegative numbers
#   output: each number and its percentage of the total
    { x[NR] = $1; sum += $1 ;y[NR] = $2; sum2 += $2}
END { if (sum != 0)
          for (i = 1; i <= NR; i++)
              #printf("%10.2f %5.1f\n", x[i], 100*x[i]/sum)
              printf("colum 2: %10.2f %5.1f\n", y[i], 100*y[i]/sum2)
    }