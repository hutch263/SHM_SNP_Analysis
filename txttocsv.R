txt_data <- read.table("all.sample.2.count.txt", header = FALSE, sep = "/")
write.csv(txt_data, "all.sample.2.count.csv", row.names = FALSE)