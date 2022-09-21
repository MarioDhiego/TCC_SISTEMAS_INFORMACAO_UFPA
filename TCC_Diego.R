
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


### PASSO 3: INSTALAÇÃO DOS PACOTES NECESSÁRIOS ################################################
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
### PASSO4: Ativação dos Pacotes ###############################################################
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
## PASSO5: Fazer Leitura dos Microdados do ENADE ###############################################
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


#################################################################################################
### PASSO6: MANIPULAÇÃO DOS MICRODADOS/FAXINA ###################################################
### Filtrar as Variáveis SocioEconômicas ########################################################
Base_Filtrada = Base_Completa %>% 
  dplyr::select (NT_OBJ_FG,
                 NT_OBJ_CE,
                 CO_IES,
                 CO_CURSO,
                 CO_MUNIC_CURSO,
                 CO_UF_CURSO,
                 CO_GRUPO,
                 CO_REGIAO_CURSO,
                 QE_I01,
                 QE_I02,
                 CO_TURNO_GRADUACAO,
                 TP_SEXO,
                 NU_IDADE)
################################################################################################


################################################################################################
########################### Descrição das Variáveis ############################################

### Institucional ##############################################################################
# CO_IES             : Código da Instituição Ensino Superior(IES);
# CO_CURSO           : Código do Curso da IES;
# CO_GRUPO           : Código Area de enquadramento do Curso
# CO_MODALIDADE      : Código da Modalidade do Curso(Presencial/Distância)
# CO_MUNIC_CURSO     : Código do Município Funcionamento do Curso;
# CO_UF_CURSO        : Código da UF de Funcionamento do Curso;
################################################################################################

### SocioDemográfica ###########################################################################
# CO_REGIA_CURSO     : Código da Regiao de Funcionamento do Curso;
# QE_I01             : Código do Estado Civil dos Alunos;
# QE_I02             : Código da Raça dos Alunos;
# CO_TURNO_GRADUACAO : Código do Turno de Matrícula dos Alunos;
# TP_SEXO            : Sexo declarado dos Alunos;
# NU_IDADE           : Idade dos Alunos;
################################################################################################

### Notas ######################################################################################
# NT_OBJ_FG          : Nota Bruta/Prova objetiva/Componente: Formação Geral;
# NT_OBJ_CE          : Nota Bruta/Prova Objetiva/Componente: Componente Específico;
#################################################################################################


### Classificação das Variáveis #################################################################
# NT_OBJ_FG          : Variável Quantitativa Contínua 
# CO_GRUPO           : Variável Qualitativa Nominal
# CO_REGIAO_CURSO    : Variável Qualitativa Nominal
# QE_I02             : Variável Qualitativa Nominal
# CO_TURNO_GRADUACAO : Variável Qualitativa Ordinal
#################################################################################################



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


### Selecionar uma Instituição: UFPA, UNAMA, CESUPA ############################################
# Filtrar somente as linhas(alunos) da Instituição (UFPA).
Base_Completa = subset(Base_Completa, Base_Completae$CO_IES == 792);
################################################################################################

### Selecionar um Município: Belém #############################################################
# Filtrar somente as linhas(alunos) do Municipio de Belém 
Belem_enade2018 = subset(Base_Completa, Base_Completa$CO_MUNIC_CURSO == 1501402);
################################################################################################


### Selecionar Uma UF: PA ######################################################################
# Filtrar somente as linhas(alunos) do PARÁ (UF).
enade2018 = subset(enade2018, enade2018$CO_UF_CURSO == 15);
################################################################################################



### Selecionar um Curso #######################################################################
#Filtrando os Dados p/Direito
DIREITO= Base_Completa %>% filter(CO_GRUPO== 2) 

#Filtrando os Dados p/Sistema de Informação
SISTEMAS= Base_Filtrada %>% filter(CO_GRUPO== 2) 

#Filtrando os Dados p/Ciência da Computação
Ciencia_Computacao= Base_Filtrada %>% filter(CO_GRUPO== 2) 
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
### Transformar a Variável: QE_I01 in ESTADO CIVIL #############################################
DIREITO = DIREITO %>% mutate(ESTADO_CIVIL = case_when(QE_I01 == "A" ~ "Solteiro",
                                                      QE_I01 == "B" ~ "Casado",
                                                      QE_I01 == "C" ~ "Separado/Divorciado",
                                                      QE_I01 == "D" ~ "Viuvo",
                                                      QE_I01 == "E" ~ "Outro"))
##############################################################################################


################################################################################################
### Transformar a Variável: QE_I02 in RACA #####################################################
DIREITO = DIREITO %>% mutate(RACA = case_when(QE_I02 == "A" ~ "Branca",
                                              QE_I02 == "B" ~ "Preta",
                                              QE_I02 == "C" ~ "Amarela",
                                              QE_I02 == "D" ~ "Indigena",
                                              QE_I02 == "E" ~ "ND"))
################################################################################################


################################################################################################
### Transformar a Variável: CO_TURNO_GRADUACAO in TURNO ########################################
DIREITO = DIREITO %>% mutate(TURNO = case_when(CO_TURNO_GRADUACAO == "1" ~ "Matutino",
                                               CO_TURNO_GRADUACAO == "2" ~ "Vespertino",
                                               CO_TURNO_GRADUACAO == "3" ~ "Integral",
                                               CO_TURNO_GRADUACAO == "4" ~ "Noturno"))
################################################################################################


################################################################################################
### Transformar a Variável: TP_SEXO in SEXO ####################################################
DIREITO = DIREITO %>% mutate(SEXO = case_when(TP_SEXO == "F" ~ "Feminino",
                                              TP_SEXO == "M" ~ "Masculino"))
################################################################################################


### Transformar a Variável: CO_MODALIDADE in MODALIDADE ########################################
DIREITO = DIREITO %>% mutate(MODALIDADE = case_when(CO_MODALIDADE == "1" ~ "Presencial",
                                                    CO_MODALIDADE == "2" ~ "A Distância"))
################################################################################################


### ANÁLISE DE OUTLIER'S/MISSING VALUES #######################################################
### Nota Agrupado/Classes: identificar possíveis dados faltantes (NAs) ########################
DIREITO %>% 
  select(NT_OBJ_FG) %>% 
  group_by(NT_OBJ_FG) %>% 
  summarise(total = n())
################################################################################################

### Total Agrupado/Sexo: identificar possíveis dados faltantes (NAs) ###########################
DIREITO %>% 
  select(SEXO) %>% 
  group_by(SEXO) %>% 
  summarise(total = n())
################################################################################################

### Total Agrupado/Região: identificar possíveis dados faltantes (NAs) #########################
DIREITO %>% 
  select(REGIAO) %>% 
  group_by(REGIAO) %>% 
  summarise(total = n())
################################################################################################


### Total Agrupado/Raça: identificar possíveis dados faltantes (NAs)
DIREITO %>% 
  select(RACA) %>% 
  group_by(RACA) %>% 
  summarise(total = n())
#################################################################################################


### Total agrupado/Turno: identificar possíveis dados faltantes (NAs) ############################
DIREITO %>% 
  select(TURNO) %>% 
  group_by(TURNO) %>% 
  summarise(total = n())
###################################################################################################


### Retirando os missing de todas variaveis
DIREITO_SEM_NA = DIREITO %>% na.omit()
ED_SEM_MISSING = summary(DIREITO_SEM_NA)
ED_SEM_MISSING

# Resumo das Variáveis SEM/NA'S
Resumo_NAS = DIREITO_SEM_NA %>%
  select(everything()) %>%  
  summarise_all(list(~sum(is.na(.))))
Resumo_NAS



################################################################################################



### PASSO 7: Visualização dos Dados ############################################################
### Notas dos Alunos: (RAÇA)
# Gráfico1 de Densidade de Alunos por Raças e Regiões
dados = DIREITO_SEM_NA
grafico_geom_density1=ggplot(dados,aes(NT_OBJ_FG,fill=RACA))+
  geom_density(alpha=0.6)+
  xlab("Nota")+
  ylab("Densidade")+
  ggtitle("Gráfico de Densidade das Notas dos Alunos por Raças e Regiões")+
  facet_grid(~REGIAO)
ggplotly(grafico_geom_density1)
#################################################################################################


################################################################################################
 







#################################################################################################
### Passo 8: Análise via Teoria Classica dos Testes #############################################





################################################################################################





#################################################################################################
### Passo 9: Análise via Teoria da Resposta Ao Item #############################################





################################################################################################

















################################################################################################
################################################################################################


### Referências Bibliográficas ####################################################################
# Software's

- R DEVELOPMENT CORE TEAM. R4.0: A language and Enviornment for Statistical Computing, 2020. https://cran.r-project.org/bin/windows/base 
- RSTUDIO. Rstudio: Integrated Development Environment for R (versão 1.2.5).
https://rstudio.com/products/rstudio/download/#download


# Packages ########################################################################################

- Allaire, JJ, Rich Iannone, Alison Presmanes Hill, and Yihui Xie. 2020. **Distill: R Markdown Format for Scientific and Technical Writing**. https://CRAN.R-project.org/package=distill.

- Zhu, Hao. 2020. **kableExtra: Construct Complex Table with Kable and Pipe Syntax**. https://CRAN.R-project.org/package=kableExtra.

- Hadley Wickham; Romain François;Lionel Henry; Kirill Müller. **dplyr: A Grammar of Data Manipulation**
  https://cloud.r-project.org/web/packages/dplyr/index.html.

- Alboukadel Kassambara. **rstatix: Pipe-Friendly Framework for Basic Statistical Tests**
  https://cran.r-project.org/web/packages/rstatix/index.html.

- Joe Cheng; Carson Sievert; Winston Chang; Yihui Xie; Jeff Allen. **htmltools: Tools for HTML**
  https://cran.r-project.org/web/packages/htmltools/index.html.

- Phil Chalmers; Joshua Pritikin; Alexander Robitzsch; Mateusz Zoltak; KwonHyun Kim; Carl F. Falk; Adam Meade; Lennart Schneider; David King; Chen-Wei Liu; Ogreden Oguzhan. **mirt: Multidimensional Item Response Theory** https://cran.r-project.org/web/packages/mirt/index.html.

- Dimitris Rizopoulos.**ltm: Latent Trait Models under IRT**
  https://cran.r-project.org/web/packages/ltm/index.html.

- William Revelle. **psych: Procedures for Psychological, Psychometric, and Personality Research**
  https://cran.r-project.org/web/packages/psych/index.html.

- Ivailo Partchev; Gunter Maris; Tamaki Hattori. **irtoys: A Collection of Functions Related to Item Response Theory (IRT)** https://cran.r-project.org/web/packages/irtoys/index.html.

# Books ###############################################################################################

- ANDRADE, D. F., TAVARES, H. R., VALLE, R. C. **Teoria da resposta ao item: conceitos
e aplicações**. São Paulo, 2000. https://docs.ufpr.br/~aanjos/CE095/LivroTRI_DALTON.pdf

- BAKER, F. B. **The Basics of Item Response Theory**. 2 ed. USA, 2001. https://eric.ed.gov/?id=ED458219

- Yihui Xie, J. J. Allaire, Garrett Grolemund. **R Markdown: The Definitive Guide**. https://bookdown.org/yihui/rmarkdown/.

- Yihui Xie. **Dynamic Documents with R and knitr**,(Chapman & Hall/CRC The R Series) 2nd Edition.
https://yihui.org/knitr/.

- Field, A. P., Miles, J., & Field, Z. (2012). Discovering statistics using R. https://aedmoodle.ufpa.br/pluginfile.php/401852/mod_resource/content/5/Material_PDF/1.Discovering%20Statistics%20Using%20R.pdf
#######################################################################################################


### Considerações Finais ##############################################################################

- Este estudo teve como objetivo mensurar o desempenho(proficiência) no ENDE/2017, dos estudantes de Computação matriculados na UFPA, por meio TRI. Apartir da estimação realizada com o modelo logistico de 2 e 3 parâmetros nos 35 itens da prova objetiva, verificou-se que, a prova não apresentou nem o domínio cognitivo compreendido pela escala. Este Resultado corrobora o baixo desempenho dos estudantes, apontado aspectos de fragilidades de aprendizagem. 
#########################################################################################################


















