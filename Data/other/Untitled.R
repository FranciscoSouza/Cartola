con = url('https://www.coursera.org/learn/data-cleaning/exam/RJBrZ/week-2-quiz')
htmlCode <- readLines(con)
close(con)
htmlCode
