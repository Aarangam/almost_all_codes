a <- 40
b <- 15.5
c <- "Money"
d <- FALSE
e <- c(10,20,30,40,50)
f <- list(name = "Jon",age = 40,country = "India")
g <- data.frame(
  name = c("Yellow","Blue","Green","Pink"),
  type = c("Secondary","Primary","Primary","Secondary"),
  Score = c(40,60,38,10)
)

class(g)
typeof(c)

h <- as.integer(5)

class(h)
typeof(h)

print(a+b)
print(c*h)
print(e*h)