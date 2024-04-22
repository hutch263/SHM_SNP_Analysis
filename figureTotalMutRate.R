# ============================================
# = track mutation rate along the ref genome =
# ============================================

args <- commandArgs(TRUE) # args = c("all.sample.allele.count", "bc1,bc2,bc3,", "figureTotalMutRate.pdf", "Myriad Pro")
library("RColorBrewer")

# prepare file to plot - edit size based on # of samples you have
# ============================================================

file.width = 90
pdf(file = args[3], width = file.width/25.4, height = file.width/25.4*1.5)
lower.margin = 0.08
layout(matrix(c(1, 2, 3), byrow = T, ncol = 1, nrow = 3), heights = c(rep((1-lower.margin)/3, 2), (1-lower.margin)/3+lower.margin))

# read counts
# ============================================================

samples <- unlist(strsplit(args[2], split = ","))
all.data <- read.table(args[1], header = FALSE, as.is = TRUE)

mut.freq <- matrix(nrow = nrow(all.data), ncol = length(samples))
nuc.table <- c("A", "C", "G", "T", "N")

for (i in 1:nrow(all.data)) {
  
  ref <- all.data[i, 3]
  
  for (j in 1:ncol(mut.freq)) {
    
    this.sample <- colSums(matrix(as.numeric(unlist(strsplit(all.data[i, j + 4], split = "/"))), nrow = 2, byrow = T))
    mut.freq[i, j] <- sum(this.sample[-c(match(ref, nuc.table), 5)])/sum(this.sample[-5])
    
  }
  
}

# make plot
# ============================================================

par(las = 1, tcl = -0.2, mai = c(0.02, 0.1, 0.02, 0.02)*file.width/25.4, ps = 7, lwd = 0.5, xpd = F)

for (i in 1:(length(samples)-1)) {

plot(c(-0.5, nrow(mut.freq) + 0.5), c(0, 0.04), type = "n", xlab = "", ylab = "", axes = FALSE)
points(seq(-0.5, nrow(mut.freq) + 0.5, 1), c(0, mut.freq[, i], 0), type = "s", lwd = 0.2)
axis(side = 1, mgp = c(0.8, 0.05, 0), lwd = 0.5, cex.axis = 7/par("ps")/par("cex"))
axis(side = 2, mgp = c(2, 0.3, 0), lwd = 0.5, cex.axis = 7/par("ps")/par("cex"))
title(ylab = "Mutation rate", mgp = c(1.8, 0.3, 0), cex.lab = 7/par("ps")/par("cex"))
box(bty = "l", lwd = 0.5)
text(0, 0.03, samples[i], cex = 7/par("ps")/par("cex"))

}

par(las = 1, tcl = -0.2, mai = c(0.02 + lower.margin, 0.1, 0.02, 0.02)*file.width/25.4, ps = 7, lwd = 0.5, xpd = F)
plot(c(-0.5, nrow(mut.freq) + 0.5), c(0, 0.04), type = "n", xlab = "", ylab = "", axes = FALSE)
points(seq(-0.5, nrow(mut.freq) + 0.5, 1), c(0, mut.freq[, length(samples)], 0), type = "s", lwd = 0.2)
axis(side = 1, mgp = c(0.8, 0.05, 0), lwd = 0.5, cex.axis = 7/par("ps")/par("cex"))
axis(side = 2, mgp = c(2, 0.3, 0), lwd = 0.5, cex.axis = 7/par("ps")/par("cex"))
title(ylab = "Mutation rate", mgp = c(1.8, 0.3, 0), cex.lab = 7/par("ps")/par("cex"))
box(bty = "l", lwd = 0.5)
text(0, 0.03, samples[length(samples)], cex = 7/par("ps")/par("cex"))
title(xlab = "Nucleotide position", mgp = c(1, 0, 0), cex.lab = 7/par("ps")/par("cex"))

# title(xlab = expression(paste(Delta, "log", ""[2], "TPM (old - young)")), mgp = c(1, 0, 0), cex.lab = 7/par("ps")/par("cex"))
# legend(-6, 2800, pch = 22, pt.bg = c(brewer.pal(9, "Reds")[9]),
#        legend = c("FDR = 0.05"), bty = "n",
#        x.intersp = 0.5, y.intersp = 0.6, cex = 7/par("ps")/par("cex"))
# box(bty = "l", lwd = 0.5)
# text(2, 1500, "\u2640", cex = 20/par("ps")/par("cex"), col = brewer.pal(9, "Reds")[9], pos = 4, family = "Arial")
# text(grconvertX(0.05, from = "inches", to = "user"), grconvertY(1, from = "nfc", to = "user"), expression(bold("a")), cex = 9/par("ps")/par("cex"), pos = 1, xpd = TRUE)

dev.off()


