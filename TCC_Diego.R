
#################################################################################################
## Universidade : UFPA                       ####################################################
## Curso        : Sistemas de Informação     ####################################################
## Matrícula    : 202240011142               ####################################################
## Discente     : Mário Diego Rocha Valente  ####################################################
## Docente      :                            ####################################################
 ################################################################################################


#################################################################################################
## TÍTULO: Avaliação do Desenpenho dos alunos matriculado                        ################
## nos Cursos da Area de Computação, UFPA, que Prestaram ao ENADE DE 2005 A 2017 ################
#################################################################################################
## OBJETIVO GERAL: Mensuarar o Desenpenhos(proficiência) dos alunos matriculado  ################
## nos Cursos da Area de Computação, UFPA, que Prestaram ao ENADE DE 2005 A 2017 ################
#################################################################################################


### PASSO 1: Baixar os Microdados do ENADE, no sítio do INEP ###################################
## https://download.inep.gov.br/microdados/microdados_enade_2018_LGPD.zip
## https://download.inep.gov.br/microdados/microdados_enade_2017_LGPD.zip
################################################################################################


### Passo 2: Criação de Diretório de Trabalho: Computador + Github #############################
## Definir Diretório de TrabalhO ###############################################################
## Definir Local
setwd("C:/Users/mario Dhiego/Documents/TCC_SISTEMAS_INFORMACAO/TCC_SISTEMAS_INFORMACAO_UFPA")

## Testar Local
getwd()
################################################################################################


### INSTAÇÃO DOS PACOTES NECESSÁRIOS ###########################################################
## Instalar Pacotes para leitura de Bases de Dados #############################################
install.packages(c("readr", "readxl", "readxlsx", "have"))
################################################################################################ 

## Instalar Pacotes para Manipulação nos Dados #################################################
install.packages(c("tidyverse","tibble","purrr","forcats","stringr","magrittr",
                   "dplyr","tidyr","lubridate"))
################################################################################################

## Instalar Pacotes para Resumo nos Dados ######################################################
install.packages(c("DT","data.table","DescTools","janitor"))
################################################################################################

## Instalar Pacotes para Visualização nos Dados ################################################
install.packages(c("ggplot2","graphics","ggThemes","plotly"))
################################################################################################





################################################################################################
### Ativação dos Pacotes #######################################################################
# Pacotes p/ Maninulacao de Dados
library(tidyverse)
library(magrittr)
library(dplyr)
library(tidyr)
library(tibble)
library(libridate)
library(purrr)
library(forcats)
library(stringr)

# Pacotes p/ Representação Tabular
library(DT)
library(data.table)
library(DescTools)
library(devtools)
library(rmarkdown)
library(knitr)

# Pacotes p/ Representação Gráfica 
library(ggplot2)
library(plotly)
library(graphics)
library(grid)
library(gridExtra)
library(ggthemes)
library(ggThemeAssis)
library(dygraphs)
library(esquisse)
library(RColorBrewer)
library(wesanderson)
library(falrec)
################################################################################################

# Desativar Pacotes
detach("package:tidyverse", unload = TRUE)
################################################################################################


################################################################################################
## Fazer Leitura dos Microdados do ENADE #######################################################
# Leitura da Base de Dados em .txt
Base_Completa=read.table("microdados_enade_2018.txt", 
                         header=TRUE, 
                         sep=";", 
                         dec=",", 
                         colClasses=c(NT_OBJ_FG="numeric"))
################################################################################################

## Leitura de Base de Dados via URL do github ##################################################
# Fazer o Download da Base Compactada .rar

download.file(url = "https://github.com/MarioDhiego/ENADE_2018_RMarkdown/blob/main/microdados_enade_2018.rar", destfile = "C:/Users/mario Dhiego/Documents/TCC_SISTEMAS_INFORMACAO_UFPA/TCC_SISTEMAS_INFORMAÇÃO_UFPA/microdados_enade_2018.rar")

datazip <- unzip("TCC_SISTEMAS_INFORMAÇÃO_UFPA/microdados_enade_2018.rar",
                 exdir="TCC_SISTEMAS_INFORMACAO_UFPA")

Dados <- read_table("TCC_SISTEMAS_INFORMAÇÃO_UFPA/microdados_enade_2018.txt")
################################################################################################

### Leia os Dados a partir do disco, sem carregá-los na RAM ####################################
# Instalar o Pacote ff
install.packages("ff")

# Ativar o Pacote ff
library(ff)

# Leitura dos Microdados
ENADE_2018 <- read.csv.ffdf(file="microdados_enade_2018.txt", header=TRUE)
################################################################################################


### Instalando Gerenciador de Base de Dados: RSQlite ou MonetDBLite ############################
install.packages('RSQlite', dependencies = TRUE)
install.packages('MonetDBLite', dependencies = TRUE)
################################################################################################


### Filtrar as Variáveis SocioEconômicas #######################################################
Base_Filtrada = Base_Completa %>% dplyr::select (NT_OBJ_FG,
                                        CO_GRUPO,
                                        CO_REGIAO_CURSO,
                                        QE_I02,
                                        CO_TURNO_GRADUACAO, 
                                        TP_SEXO,
                                        NU_IDADE)
################################################################################################



### Visualização das Bases de Dados ############################################################
# Base Completa
View(Base_Completa)
glimpse(Base_Completa)

# Base Filtrada
View(Base_Filtrada)
glimpse(Base_Filtrada)
################################################################################################


### Checagem e Verificação dos Filtros #########################################################
# Conferindo o Nome das Variáveis 
names(Base_Completa)
names(Base_Filtrada)

# Verificando as dimensões (número de linhas e colunas)
dim(Base_Completa)
dim(Base_Filtrada)

# Resumo dos Dados com as Variáveis selecionadas
Resumo=summary(Base_Completa)
Resumo

Descritiva=describe(Base_Completa)
Descritiva
################################################################################################


### Selecionar um Curso #######################################################################
#Filtrando os Dados p/Direito
DIREITO= Base_Completa %>% filter(CO_GRUPO== 2) 

#Filtrando os Dados p/Sistema de Informação
SISTEMAS= Base_Filtrada %>% filter(CO_GRUPO== ) 

#Filtrando os Dados p/Ciência da Computação
Ciencia_Computacao= Base_Filtrada %>% filter(CO_GRUPO== ) 
################################################################################################




#### Salvar as Novas Bases de Dados Limpa ######################################################
write.csv(enade2018, file= "microdados_enade_2018_Direiro.csv")
write.csv(enade2018, file= "microdados_enade_2018_Sistemas_Informacao.csv")
write.csv(enade2018, file= "microdados_enade_2018_Ciencias_Computacao.csv")
################################################################################################


####################### Transformar o Curso/DIREITO ############################################
DIREITO = DIREITO %>% mutate(CURSO = case_when(CO_GRUPO== 2 ~ "Direito"))
################################################################################################

####################### Transformar o Curso/SISTEMAS ############################################
SISTEMAS = SISTEMAS %>% mutate(CURSO = case_when(CO_GRUPO== 2 ~ "Sistemas de Informação"))
################################################################################################






################################################################################################
### Transformar a Variável: CO_REGIAO in REGIAO ################################################
DIREITO = DIREITO %>% mutate(REGIAO = case_when(CO_REGIAO_CURSO == 1 ~ "Norte",
                                                CO_REGIAO_CURSO == 2 ~ "Nordeste",
                                                CO_REGIAO_CURSO == 3 ~ "Sudeste",
                                                CO_REGIAO_CURSO == 4 ~ "Sul",
                                                CO_REGIAO_CURSO == 5 ~ "Centro-Oeste"))
################################################################################################


################################################################################################
### Transformar a Variável: QE_I02 in RACA #####################################################
DIREITO = DIREITO %>% mutate(RACA = case_when(QE_I02 == "A" ~ "Branca",
                                              QE_I02 == "B" ~ "Preta",
                                              QE_I02 == "C" ~ "Amarela",
                                              QE_I02 == "D" ~ "Indigena",
                                              QE_I02 == "E" ~ "ND"))
################################################################################################


################################################################################################
### TransformaR a Variável: CO_TURNO_GRADUACAO in TURNO ########################################
DIREITO = DIREITO %>% mutate(TURNO = case_when(CO_TURNO_GRADUACAO == "1" ~ "Matutino",
                                               CO_TURNO_GRADUACAO == "2" ~ "Vespertino",
                                               CO_TURNO_GRADUACAO == "3" ~ "Integral",
                                               CO_TURNO_GRADUACAO == "4" ~ "Noturno"))
################################################################################################



################################################################################################
### TransformaR a Variável: TP_SEXO in SEXO ########################################
DIREITO = DIREITO %>% mutate(SEXO = case_when(TP_SEXO == "F" ~ "Feminino",
                                              TP_SEXO == "M" ~ "Masculino"))
################################################################################################






################################################################################################
### Retirando os missing de todas variaveis
DIREITO = DIREITO %>% na.omit()
ED_SEM_MISSING = summary(DIREITO)
ED_SEM_MISSING
################################################################################################


















################################################################################################
################################################################################################





















