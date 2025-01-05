{ x[int($1/10)]++ } # int func convert value to integer and assing it as `x` key
END {
    for (i in x)
        # `i` is the key from assosiative array 
        # `x[i]` is the value
        print "Range:", i*10, "-", (i+1)*10-1, "Count:", x[i]
}