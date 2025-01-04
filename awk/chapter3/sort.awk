# awk -f sort.awk titanic.tvs | sort -k3 -nr
# Child  Second   100.0%
# Female   First    97.2%
# Female    Crew    87.0%
# Female  Second    86.0%
# Child   First    83.3%
# Female   Third    46.1%
# Child   Third    34.2%
# Male   First    32.6%
# Male    Crew    21.7%
# Male   Third    16.2%
# Male  Second     8.3%

 NR > 1 { printf("%6s  %6s  %6.1f%%\n", $1, $2, 100 * $4/$3) }
