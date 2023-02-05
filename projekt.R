library(smoof)
pure_random_search <- function(function_name, dimensions, iter , min_range , max_range) {
  min_point = Inf
  for (i in 1:iter) {
          point <- runif(dimensions,min = min_range,max = max_range)
          value <- function_name(point)
          min_point = min(min_point,value)
      }
  return(min_point)
}
multi_start <- function(function_name, dimensions, iter, min_range , max_range) {
  min_value <- c()
  counts <- c()
  for (i in 1:iter) {
    res <- optim(runif(dimensions,min_range , max_range),function_name, method = "L-BFGS-B" , lower = min_range , upper = max_range)
    value <- res$value
    count <- res$counts[1]
    min_value[i] = value
    counts[i] = count
  }
  tmpbudget <<- mean(counts)
  return(min(min_value))
}


compare <- function(func, d,min_range,max_range){
  resultsPRS <- c()
  resultsMS <- c()

  multi_start(func, d, 100,min_range, max_range)
  budget <- tmpbudget

  resultsMS = replicate(n=50 , c(resultsMS, multi_start(func, d, ceiling(budget),min_range, max_range)))
  print("Mean MS")
  print(mean(resultsMS))
  print("Standard deviation MS")
  print(sd(resultsMS))
  print(t.test(resultsMS))

  resultsPRS = replicate(n=50 , c(resultsPRS, pure_random_search(func, d, ceiling(budget) ,min_range, max_range)))
  print("Mean PRS")
  print(mean(resultsPRS))
  print("Standard deviation PRS")
  print(sd(resultsPRS))
  print(t.test(resultsPRS))
  print(t.test(resultsMS, resultsPRS))
  
  
  
  jpeg(file="graphs/histogramMS.jpeg")
  hist(resultsMS, main = "MS")
  dev.off()

  jpeg(file="graphs/histogramPRS.jpeg")
  hist(resultsPRS, main = "PRS")
  dev.off()

  jpeg(file="graphs/wykresPRS.jpeg")
  boxplot(resultsPRS, main = "PRS")
  dev.off()

  jpeg(file="graphs/wykresMS.jpeg")
  boxplot(resultsMS, main = "MS")
  dev.off()
  
}
d = 10
ackley <- makeAckleyFunction(dimensions = d)
rosenbrock <- makeRosenbrockFunction(dimensions = d)
compare(ackley,d,-32.768, 32.768)
# compare(rosenbrock,d,-30,30)
