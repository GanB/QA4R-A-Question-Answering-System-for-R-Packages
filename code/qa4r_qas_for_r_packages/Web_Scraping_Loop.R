###

library(XML)
library(RCurl)

url <- "http://finance.yahoo.com/q/op?s=DIA&m=2013-07"

tabs <- getURL(url)
tabs <- readHTMLTable(tabs, stringsAsFactors = F)

tabs

###

library(httr)

tabs <- GET(url)
tabs <- readHTMLTable(rawToChar(tabs$content), stringsAsFactors = F)
tabs

###
library('XML')

url_base <- "https://www.basketball-reference.com/teams/"
teams <- c("ATL", "BOS")

# better still, get the full list of teams as in
# http://stackoverflow.com/a/11804014/1543437

results <- data.frame()
for(team in teams){
  theurl <- paste(url_base, team , sep="/")
  tables <- readHTMLTable(theurl)
  n.rows <- unlist(lapply(tables, function(t) dim(t)[1]))
  team.results <-tables[[which.max(n.rows)]] 
  write.csv(team.results, file=paste0(team, ".csv"))
  team.results$TeamCode <- team
  results <- rbind(results, team.results)
}
write.csv(results, file="AllTeams.csv")

##

library(RCurl)
library(XML)

stem <- "https://CRAN.R-project.org/package="
package <- htmlParse(getURL(stem), asText=T)
package <- xpathSApply(pkgs,"//*/a[contains(@href,'/package/')]", xmlAttrs)[-1]
package <- gsub("/package/(.*)/", "\\1", package)
urls <- paste0(stem, package)

names(package) <- NULL   # get rid of the "href" labels
names(urls) <- package

results <- data.frame()

for(team in package){
  print(urls[package])
  temptables <- readHTMLTable("https://www.basketball-reference.com/teams/ATL")
  print(temptables)
  n.rows <- unlist(lapply(temptables, function(t) dim(t)[1]))
  #print(temptables)
  team.results <- temptables[[which.max(n.rows)]] 
  write.csv(team.results, file=paste0(team, ".csv"))
  package.results$TeamCode <- team
  results <- rbind(results, package.results)
  rm(team.results, n.rows, temptables)
}
rm(stem, package)

write.csv(results, file="AllPackages.csv")

###