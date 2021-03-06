#save(z, file="data/07-rcpp_comparison.RData")
load("data/07-rcpp_comparison.RData")
source("code/initialise.R")
library(ggplot2)

z$expr = factor(z$expr, levels=c("mean(x)",  "mean_c(x)", "com_mean_r(x)", "mean_r(x)"))
z$expr = factor(z$expr, labels=c("Base",  "Rcpp", "Byte compiled R", "Pure R"))

z$time = z$time/10^6
g = ggplot(z) + 
  geom_violin(aes(expr, time),position=position_dodge(0.9), bg=get_col(3)) + 
  scale_y_continuous(limits=c(10^-3, 10^1), expand=c(0, 0), breaks = 10^(-3:1), 
                     trans="log10", 
                     labels=c(expression(10^-3),expression(10^-2),
                              expression(10^-1),expression(10^0),expression(10^1)))

g1 = g +  labs(title = "Performance Gains with Rcpp", 
           x = NULL, y = "Elapsed Time (secs)",colour = NULL, fill = NULL) + 
  theme(panel.grid.major.y = element_line(colour = "gray90"), 
        panel.grid.minor = element_line(colour = NA), 
        panel.grid.major.x = element_line(colour = NA), 
        plot.title = element_text(size = 12, 
                                  face = "bold", hjust = 1, vjust = 0), 
        panel.background = element_rect(fill = NA), 
        legend.background = element_rect(fill = NA), 
        legend.position = c(0.93, 0.92), 
        axis.ticks.x = element_line(linetype = "blank"),
        axis.ticks.y = element_line(linetype = "blank"))
print(g1)