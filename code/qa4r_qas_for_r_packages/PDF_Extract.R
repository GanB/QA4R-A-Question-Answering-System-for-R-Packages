library(pdftools)
library(tidyverse)

dbi_pdf <- pdf_text("https://cran.r-project.org/web/packages/DBI/DBI.pdf") %>%
  readr::read_lines() #open the PDF inside your project folder
dbi_pdf[10]
cat(dbi_pdf[11])

pdf_info("https://cran.r-project.org/web/packages/DBI/DBI.pdf") 
pdf_text("https://cran.r-project.org/web/packages/DBI/DBI.pdf") 
pdf_data("https://cran.r-project.org/web/packages/DBI/DBI.pdf") 
pdf_fonts("https://cran.r-project.org/web/packages/DBI/DBI.pdf") 
pdf_attachments("https://cran.r-project.org/web/packages/DBI/DBI.pdf") 
pdf_toc("https://cran.r-project.org/web/packages/DBI/DBI.pdf") 
pdf_pagesize("https://cran.r-project.org/web/packages/DBI/DBI.pdf") 


PDF.grass <-PDF[-c(1:3,6:8,20:35)] # remove lines
PDF.grass

link <- paste0(
  "https://cran.r-project.org/web/packages/DBI/DBI.pdf")
download.file(link, "r_pkg_dbi.pdf", mode = "wb")

txt <- pdf_text("r_pkg_dbi.pdf")
test <- txt[49]  #P.49
test
rows<-scan(textConnection(test), what="character",
           sep = "\n")  

name<-c()
total<-c()

for (i in 7:length(rows)){
  row = unlist(strsplit(rows[i]," \\s+ "))
  if (!is.na(row[3])){
    name <- c(name, row[2])
    total<- c(total,
              as.numeric((gsub(",", "", row[3]))))
  }
}