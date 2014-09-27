## cube(3) returns 27 (3^3)
cube <- function(x, n) {
  x^3
}

## returns error as if cannot handle vectors
x <- 1:10
if(x > 5) {
  x <- 0
}

## z <-10, f(3) returns 10 (x+y+z = 3+3+4 = 10)
## z = 4 within function, but remains as 10 outside of function 
f <- function(x) {
  g <- function(y) {
    y + z
  }
  z <- 4
  x + g(x)
}

## y = 10
x <- 5
y <- if(x < 3) {
  NA
} else {
  10
}

## f is a free variable
h <- function(x, y = NULL, d = 3L) {
  z <- cbind(x, d)
  if(!is.null(y))
    z <- z + y
  else
    z <- z + f
  g <- x + y / z
  if(d == 3L)
    return(g)
  g <- g + 10
  g
}

