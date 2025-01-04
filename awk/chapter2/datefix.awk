awk '

function datefix(s,   y, date) {

  split(s, date, "/")

  y = date[3]<40 ? 2000+date[3] : 1900+date[3]  # arbitrary year

  return sprintf("%4d-%02d-%02d", y, date[1], date[2])

}



{ print(datefix($0)) }

' $*
