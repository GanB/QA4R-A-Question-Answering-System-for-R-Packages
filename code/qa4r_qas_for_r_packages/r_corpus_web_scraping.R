# Building R packages corpus from CRAN

#Loading the all the required packages
library('rvest')
library(xml2)
library(tidyverse)
library(janitor)
library(elastic)
library(elasticsearchr)
library(data.table)

r_packages_content <- read_html("https://cran.r-project.org/web/packages/available_packages_by_name.html")
r_packages_tables <- r_packages_content %>% html_table(fill = TRUE)
r_packages_list <- r_packages_tables[[1]]
r_packages_list <- r_packages_list[-1,]
r_packages_list <- r_packages_list %>% rename(r_package_name = X1, description = X2)
#r_packages_list
r_packages_list <- r_packages_list %>% clean_names()

#write.csv(r_packages,"r_packages_list.csv")

es <- elastic("http://localhost:9200", "r_packages_list", "data")
elastic("http://localhost:9200", "r_packages_list", "data") %index% r_packages_list

for_everything <- query('{
  "match_all": { }
}')

elastic("http://localhost:9200", "r_packages_list", "data") %search% for_everything
conn <- connect('http://localhost')
count(conn, index='r_packages_list')
xx1 <- data.table(Search(conn, index='r_packages_list', pretty = TRUE, q = 'tidy', size=10)$hits$hits)

ss1 <- Search(conn, index='r_packages_list', pretty = TRUE, q = 'tidy', size=10)$hits$hits

ss2 <- Search(conn, index='r_packages_list', pretty = TRUE, q = 'tidy', 
              body = '{
                 "sort": { "_score": { "order": "desc" }}
                 }', 
              size=1
)$hits$hits [[1]][5][[1]]

ss2[[1]][5][[1]]
ss2[[1]][5][[1]][2]
lapply(ss2, '[[', 1)

"_source": {
  "includes": ["r_package_name", "description"]
},

"fields": [
  "r_package_name",
  "description"
],

ss1[[1]][1]
df <- data.frame(ss1)
t <- as.data.frame(ss1)
df
ss2 <- unlist(ss1)
ss2[2]
typeof(ss1)

datalist <- list()

j <- 1
df_2 <- data.frame(matrix(ncol = 6, nrow = 0))
x <- c("index", "type", "id", "score", "package_name", "desc")
colnames(df_2) <- x

temp <- list()
for (i in length(ss1)) {
  temp[i] <- append(temp, list(ss1[i]))
}


for (i in ss1) {
  datalist[[]] <- i
  #dat <- data.frame(i)
  #dat$i <- i
  #datalist[[i]] <- dat
}

big_data = do.call(rbind, datalist)
big_data_1 <- dplyr::bind_rows(datalist)
big_data_2 <- data.table::rbindlist(datalist)


datalist = list()

for (i in ss1) {
  # ... make some data
  dat <- data.frame(x = rnorm(10), y = runif(10))
  dat$i <- i  # maybe you want to keep track of which iteration produced it?
  datalist[[i]] <- dat # add it to your list
}

big_data = do.call(rbind, datalist)
# or big_data <- dplyr::bind_rows(datalist)
# or big_data <- data.table::rbindlist(datalist)


for (i in ss1) {
  
  
}

df

######
## dplyr, tidyr, stringr, lubridate, httr, ggvis, ggplot2, shiny, rio, markdown

dplyr_content <- read_html("https://cran.r-project.org/web/packages/dplyr/index.html")
dplyr_tables <- dplyr_content %>% html_table(fill = TRUE)
dplyr_df <- dplyr_tables[[1]]
dplyr_df <- dplyr_df[-1,]
dplyr_df <- dplyr_df %>% rename(attribute = X1, value = X2)
#r_packages_list
dplyr_df <- dplyr_df %>% clean_names()

es <- elastic("http://localhost:9200", "dplyr_df", "data")
elastic("http://localhost:9200", "dplyr_df", "data") %index% dplyr_df

#elastic("http://localhost:9200", "dplyr_df", "data")
elastic("http://localhost:9200", "dplyr_df", "data") %index% dplyr_df


tidyr_content <- read_html("https://cran.r-project.org/web/packages/tidyr/index.html")
tidyr_tables <- tidyr_content %>% html_table(fill = TRUE)
tidyr_df <- tidyr_tables[[1]]
tidyr_df <- tidyr_df[-1,]
tidyr_df <- tidyr_df %>% rename(attribute = X1, value = X2)
#r_packages_list
tidyr_df <- tidyr_df %>% clean_names()

es <- elastic("http://localhost:9200", "tidyr_df", "data")
elastic("http://localhost:9200", "tidyr_df", "data") %index% tidyr_df

#elastic("http://localhost:9200", "tidyr_df", "data")
elastic("http://localhost:9200", "tidyr_df", "data") %index% tidyr_df

##

stringr_content <- read_html("https://cran.r-project.org/web/packages/stringr/index.html")
stringr_tables <- stringr_content %>% html_table(fill = TRUE)
stringr_df <- stringr_tables[[1]]
stringr_df <- stringr_df[-1,]
stringr_df <- stringr_df %>% rename(attribute = X1, value = X2)
#r_packages_list
stringr_df <- stringr_df %>% clean_names()

es <- elastic("http://localhost:9200", "stringr_df", "data")
elastic("http://localhost:9200", "stringr_df", "data") %index% stringr_df

#elastic("http://localhost:9200", "stringr_df", "data")
elastic("http://localhost:9200", "stringr_df", "data") %index% stringr_df

##

ggplot2_content <- read_html("https://cran.r-project.org/web/packages/ggplot2/index.html")
ggplot2_tables <- ggplot2_content %>% html_table(fill = TRUE)
ggplot2_df <- ggplot2_tables[[1]]
ggplot2_df <- ggplot2_df[-1,]
ggplot2_df <- ggplot2_df %>% rename(attribute = X1, value = X2)
#r_packages_list
ggplot2_df <- ggplot2_df %>% clean_names()

es <- elastic("http://localhost:9200", "ggplot2_df", "data")
elastic("http://localhost:9200", "ggplot2_df", "data") %index% ggplot2_df

elastic("http://localhost:9200", "ggplot2_df", "data") %index% ggplot2_df
