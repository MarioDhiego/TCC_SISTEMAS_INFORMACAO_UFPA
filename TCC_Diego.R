
#######################################################################################
## Universidade : UFPA                       ##########################################
## Curso        : Sistemas de Informação     ##########################################
## Matrícula    : 202240011142               ##########################################
## Discente     : Mário Diego Rocha Valente  ##########################################
## Docente      :                            ##########################################
 ######################################################################################


######################################################################################
## TÍTULO: Avaliação do Desenpenho dos alunos matriculado                        #####
## nos Cursos da Area de Computação, UFPA, que Prestaram ao ENADE DE 2005 A 2017 #####
######################################################################################
## OBJETIVO GERAL: Mensuarar o Desenpenhos(proficiência) dos alunos matriculado  #####
## nos Cursos da Area de Computação, UFPA, que Prestaram ao ENADE DE 2005 A 2017 #####
######################################################################################


## PASSO 1: Baixar os Microdados do ENADE, no sítio do INEP ###########################
#######################################################################################


## Definir Diretório de TrabalhO ######################################################
## Definir Local
setwd("C:/Users/mario Dhiego/Documents/TCC_SISTEMAS_INFORMAÇÃO_UFPA/TCC_SISTEMAS_INFORMAÇÃO_UFPA")

## Testar Local
getwd()
#######################################################################################


## Instalar Pacotes para leitura de Bases de Dados ####################################
install.packages(c("readr", "readxl", "readxlsx", "have"))
####################################################################################### 

## Instalar Pacotes para Manipulação nos Dados ##########################################
install.packages(c("tidyverse","tibble","purr","forcats","stringr","magrittr","dplyr","tidyr"))
#########################################################################################

## Instalar Pacotes para Resumo nos Dados ###############################################
install.packages(c("DT","data.table","DescTools","janitor"))
#########################################################################################

## Instalar Pacotes para Visualização nos Dados #########################################
install.packages(c("ggplot2","graphics","ggThemes","plotly"))
#########################################################################################


#########################################################################################
## Ativação dos Pacotes #################################################################
library(tidyverse)
library(tidyr)
library(dplyr)
library(magrittr)
library(readr)
library(readxlsx)
library(have)
library(readxls)
library(ggplot2)
library(graphics)
library(ggthemes)
library(gridExtra)
library(plotly)
library(DT)
library(data.table)
library(DescTools)
library(janitor)
#########################################################################################

# Desativar Pacotes
detach("package:tidyverse", unload = TRUE)
#########################################################################################


#########################################################################################
## Fazer Leitura dos Microdados do ENADE ################################################
# Leitura da Base de Dados em .txt
Base_Completa=read.table("microdados_enade_2018.txt", 
                         header=TRUE, 
                         sep=";", 
                         dec=",", 
                         colClasses=c(NT_OBJ_FG="numeric"))


## Leitura de Base de Dados via URL do github ##############################################
# Fazer o Download da Base Compactada .rar

download.file(url = "https://github.com/MarioDhiego/ENADE_2018_RMarkdown/blob/main/microdados_enade_2018.rar", destfile = "C:/Users/mario Dhiego/Documents/TCC_SISTEMAS_INFORMAÇÃO_UFPA/TCC_SISTEMAS_INFORMAÇÃO_UFPA/microdados_enade_2018.rar")

datazip <- unzip("TCC_SISTEMAS_INFORMAÇÃO_UFPA/microdados_enade_2018.rar",
                 exdir="TCC_SISTEMAS_INFORMAÇÃO_UFPA")

Dados <- read_table("TCC_SISTEMAS_INFORMAÇÃO_UFPA/microdados_enade_2018.txt")
############################################################################################




########################################################################################
#########################


