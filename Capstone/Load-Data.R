# set working directory
setwd("~/datasciencecoursera")

# Downloading Capstone dataset
if(!file.exists("./Capstone")){dir.create("./Capstone")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip"
download.file(fileUrl,destfile="./Capstone/Capstone Dataset.zip")

# Unzip Capstone Dataset to ./Capstone directory
unzip(zipfile="./Capstone/Capstone Dataset.zip",exdir="./Capstone")