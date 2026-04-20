#Instale e carregue os pacotes necessários
install.packages(c("DBI", "RSQLite", "readr"))
library(DBI)
library(RSQLite)
library(readr)

conexao <- dbConnect(SQLite(), dbname = "meu_banco.db")

appointments <- read_csv("appointments.csv")
treatments <- read_csv("treatments.csv")

dbWriteTable(conexao, "appointments", appointments, overwrite = TRUE)
dbWriteTable(conexao, "treatments", treatments, overwrite = TRUE)

dbListTables(conexao)

dbDisconnect(conexao)
