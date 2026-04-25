#Instale e carregue os pacotes necessários
install.packages(c("DBI", "RSQLite", "readr", "dplyr"))
library(DBI)
library(RSQLite)
library(readr)
library(dplyr)

conexao <- dbConnect(SQLite(), dbname = "meu_banco.db")

appointments <- read_csv("appointments.csv")

treatments <- read_csv("treatments.csv")


dbWriteTable(conexao, "appointments", appointments, overwrite = TRUE)
dbWriteTable(conexao, "treatments", treatments, overwrite = TRUE)

dbListTables(conexao)

dbDisconnect(conexao)

# Join no SQLite

SELECT *
FROM treatments
FULL JOIN appointments
ON treatments.appointment_id = appointments.appointment_id

#JOIN no R
JOIN <- full_join(appointments, treatments, by = "appointment_id")
write_csv(JOIN, "tabela_unificada.csv")
