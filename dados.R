library(jsonlite)
jsonData <- fromJSON("https://api.cartolafc.globo.com/atletas/mercado") 
exportJson <- toJSON(jsonData)
write(exportJson, "test.json")

names(jsonData)

library("rjson")
json_files <- c("rodada1.json", "rodada2.json", "rodada3.json", "rodada4.json", "rodada5.json")
##result <- fromJSON(file = json_files)

listOfAtletas <- data.frame(
  atleta_id = character(), 
  apelido = character(), 
  clube_id = character(), 
  posicao_id = character(), 
  rodada_id = character(),
  
  pontos_num = integer(),
  preco_num = integer(),
  variacao_num = integer(),
  media_num = integer(),
  
  
  # RB - Roubada de bolas (+ 1,7)
  # G - Gol (+8,0)
  # A - Assist??ncia (+5,0)
  # SG - Jogos sem sofrer gols (+5,0)
  # FS - Falta sofrida ( +0,5)
  # FF - Finaliza????o para fora (+0,7)
  # FD - Finaliza????o defendida (+1,0)
  # FT - Finaliza????o na trave (+3,5)
  # DD - Defesa dif??cil (+3,0)
  # DP - Defesa de p??nalti (+7,0)
  
  # GC - Gol contra (-6,0)
  # CV - Cart??o vermelho (-5,0)
  # CA - Cart??o amarelo (-2,0)
  # GS - Gol sofrido (-5,0)
  # PP - P??nalti perdido (-3,5)
  # FC - Falta cometida (-0,5)
  # I - Impedimento (-0,5)
  # PE - Passe Errado (-0,3)
  # 
  
  #positive
  scout_RB <- integer(),
  scout_G <- integer(),
  scout_A  <- integer(),
  scout_SG <- integer(),
  scout_FS <- integer(),
  scout_FF <- integer(),
  scout_FD <- integer(),
  scout_FT <- integer(),
  scout_DD <- integer(),
  scout_DP <- integer(),
  
  #negative
  scout_GC <- integer(),
  scout_CV <- integer(),
  scout_CA <- integer(),
  scout_GS <- integer(),
  scout_PP <- integer(),
  scout_FC <- integer(),
  scout_I <-integer(),
  scout_PE <-integer()

)


## Function to get JSON data file
## Return the file data
dataFromJSON <- function(file_to_read){
  rawdata<-fromJSON(file = file_to_read)
  return (rawdata)
} 


## function to get the value of variable if exist
# return the value or 0
scout_var <- function(tmp_var){
  if (length(tmp_var) > 0){
    return(tmp_var)
  }else{
    return (0)
  }  
}


## iterate thru files
for (i in 1:length(json_files)){
  result <- dataFromJSON(json_files[i])
  
  for (i in 1:length(result$atletas)){
    tmpDF <- data.frame()
    if (length(result$atletas[[i]]$scout) > 0){
      apelido <- c(result$atletas[[i]]$apelido)
      
      atleta_id <- c(result$atletas[[i]]$atleta_id)
      clube_id <- c(result$atletas[[i]]$clube_id)
      posicao_id <- c(result$atletas[[i]]$posicao_id)
      rodada_id  <- c(result$atletas[[i]]$rodada_id)
      
      print(apelido)
      pontos_num <- (result$atletas[[i]]$pontos_num)
      preco_num <- (result$atletas[[i]]$preco_num)
      variacao_num <- (result$atletas[[i]]$variacao_num)
      media_num <- (result$atletas[[i]]$media_num)
      
      
      
      #positive
      scout_RB <- scout_var(result$atletas[[i]]$scout$RB)
      scout_G <- scout_var(result$atletas[[i]]$scout$G)
      scout_A  <- scout_var(result$atletas[[i]]$scout$A)
      scout_SG <- scout_var(result$atletas[[i]]$scout$SG)
      scout_FS <- scout_var(result$atletas[[i]]$scout$FS)
      scout_FF <- scout_var(result$atletas[[i]]$scout$FF)
      scout_FD <- scout_var(result$atletas[[i]]$scout$FD)
      scout_FT <- scout_var(result$atletas[[i]]$scout$FT)
      scout_DD <- scout_var(result$atletas[[i]]$scout$DD)
      scout_DP <- scout_var(result$atletas[[i]]$scout$DP)
      
      #negative
      scout_GC <- scout_var(result$atletas[[i]]$scout$GC)
      scout_CV <- scout_var(result$atletas[[i]]$scout$CV)
      scout_CA <- scout_var(result$atletas[[i]]$scout$CA)
      scout_GS <- scout_var(result$atletas[[i]]$scout$GS)
      scout_PP <- scout_var(result$atletas[[i]]$scout$PP)
      scout_FC <- scout_var(result$atletas[[i]]$scout$FC)
      scout_I  <- scout_var(result$atletas[[i]]$scout$I)
      scout_PE <- scout_var(result$atletas[[i]]$scout$PE)
      
      tmpDF <- data.frame(atleta_id, apelido,clube_id, posicao_id, rodada_id, 
                          pontos_num ,
                          preco_num ,
                          variacao_num ,
                          media_num ,
                          
                          scout_RB ,
                          scout_G ,
                          scout_A  ,
                          scout_SG ,
                          scout_FS ,
                          scout_FF ,
                          scout_FD ,
                          scout_FT ,
                          scout_DD ,
                          scout_DP ,
                          
                          #negative
                          scout_GC ,
                          scout_CV ,
                          scout_CA ,
                          scout_GS ,
                          scout_PP ,
                          scout_FC ,
                          scout_I ,
                          scout_PE 
      )
      listOfAtletas <-rbind(listOfAtletas, tmpDF)
    }
  }
}

#(aggregate(listOfAtletas[, 6:8], list(listOfAtletas$apelido), mean))

