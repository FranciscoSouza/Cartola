## read a json
library("rjson")
json_file <- "atletas_posicoes.json"
json_data2 <- fromJSON(paste(readLines(json_file), collapse=""))
