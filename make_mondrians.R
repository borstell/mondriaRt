library(ggplot2)
library(patchwork)
library(gganimate)

## Read from Python generated rasters

x_raster_size <- 5
y_raster_size <- 15

single <- ggplot(read.csv(paste0("./canvas/mondrian_canvas_20200426-213712.csv"))) +
  geom_rect(aes(xmin=0, xmax=x_raster_size, ymin=0, ymax=y_raster_size, fill="white"), color="black", size=2) +
  geom_rect(aes(xmin = x1, xmax = x2+1, ymin = y1, ymax = y2+1, fill=color), color="black", size=2) +
  scale_fill_identity() + scale_color_identity() + 
  xlim(0,x_raster_size) + ylim(0,y_raster_size) + 
  coord_flip() +
  #coord_fixed() + 
  theme_void() +
  theme(legend.position = "none")
single + annotate("text", x = 2, y=3.5, label= "mondriaRt", size=16)
ggsave("./images/mondriaRt.png", dpi = 1200, width = 280, height = 84, units = "mm")


x_raster_size <- 5
y_raster_size <- 5

ggplot(read.csv(paste0("./canvas/mondrian_canvas_9.csv"))) +
  geom_rect(aes(xmin=0, xmax=x_raster_size, ymin=0, ymax=y_raster_size, fill="white"), color="black", size=2) +
  geom_rect(aes(xmin = x1, xmax = x2+1, ymin = y1, ymax = y2+1, fill=color), color="black", size=2) +
  scale_fill_identity() + scale_color_identity() + 
  xlim(0,x_raster_size) + ylim(0,y_raster_size) + 
  #coord_flip() +
  coord_fixed() + 
  theme_void() +
  theme(legend.position = "none")
ggsave(paste0("./images/mondrian_tiny_", format(Sys.time(),"%Y-%m-%d_%H%M%S"),".png"), dpi = 1200, width = 8, height = 8, units = "in")


# If multiple files

num <- 12 # number of rasters to read
raster_size <- 5

plot_list = list()

for (n in 1:num){
  p <-  ggplot(read.csv(paste0("./canvas/mondrian_canvas_",n,".csv"))) +
    geom_rect(aes(xmin=0, xmax=raster_size, ymin=0, ymax=raster_size, fill="white"), color="black", size=2) +
    geom_rect(aes(xmin = x1, xmax = x2+1, ymin = y1, ymax = y2+1, fill=color), color="black", size=2) +
    scale_fill_identity() + scale_color_identity() + 
    xlim(0,raster_size) + ylim(0,raster_size) + 
    #coord_flip() +
    coord_fixed() + 
    theme_void() +
    theme(legend.position = "none")
  plot_list[[n]] <-  p
}

threebythree <- 
  (plot_list[[1]] | plot_list[[2]] | plot_list[[3]]) /
(plot_list[[4]] | plot_list[[5]] | plot_list[[6]]) /
(plot_list[[7]] | plot_list[[8]] | plot_list[[9]])
ggsave(paste0("./images/mondrian_3x3_", format(Sys.time(),"%Y-%m-%d_%H%M%S"),".png"), dpi = 1200)

threebyfour <- 
  (plot_list[[1]] | plot_list[[2]] | plot_list[[3]]) /
  (plot_list[[4]] | plot_list[[5]] | plot_list[[6]]) /
  (plot_list[[7]] | plot_list[[8]] | plot_list[[9]]) /
  (plot_list[[10]] | plot_list[[11]] | plot_list[[12]])
ggsave(paste0("./images/mondrian_3x4_", format(Sys.time(),"%Y-%m-%d_%H%M%S"),".png"), dpi = 1200)


## gganimate GIFs

ani <- ggplot(read.csv(paste0("./canvas/merged.csv"))) +
  geom_rect(aes(xmin=0, xmax=raster_size, ymin=0, ymax=raster_size, fill="white"), color="black", size=2) +
  geom_rect(aes(xmin = x1, xmax = x2+1, ymin = y1, ymax = y2+1, fill=color), color="black", size=2) +
  scale_fill_identity() + scale_color_identity() + 
  xlim(0,raster_size) + ylim(0,raster_size) + 
  #coord_flip() +
  coord_fixed() + 
  theme_void() +
  theme(legend.position = "none") +
  transition_states(
  canvas,
  transition_length = 5,
  state_length = 1) +
  enter_fade() + 
  exit_shrink() +
  ease_aes('sine-in-out')

animate(ani, nframes = 200, renderer = gifski_renderer("mondrian.gif"), end_pause = 1, rewind = FALSE)

# ggplot(mondrian_canvas) +
#   geom_rect(aes(xmin=0, xmax=20, ymin=0, ymax=20, fill="white"), color="black", size=3) +
#   geom_rect(aes(xmin = x1, xmax = x2+1, ymin = y1, ymax = y2+1, fill=color), color="black", size=3) +
#   scale_fill_identity() + scale_color_identity() + 
#   xlim(0,20) + ylim(0,20) + coord_flip() + coord_fixed() + 
#   theme_void() +
#   theme(legend.position = "none")
# 
# 
# ## Mondrian stuff
# 
# r <- "#C52F24"  
# b <- "#1513C6"
# y <- "#FDF851"
# w <- "#000000"
# b <- "#FFFFFF"
# t <- "#7AB3BA"
# 
# cols <- c(r,b,y,t,w,r,b,y,w,w,b)
# 
# x1 <- sample(1:16, 30, replace=TRUE)
# x2 <- sample(8:20, 30, replace=TRUE)
# y1 <- sample(1:16, 30, replace=TRUE)
# y2 <- sample(8:20, 30, replace=TRUE)
# f <- sample(cols, 30, replace=TRUE)
# df <- data.frame(x1,x2,y1,y2,f)
# 
# xmin <- 1
# xmax <- 20
# ymin <- 1
# ymax <- 20
# x <- c()
# y <- c()
# 
# ggplot(df) +
#   geom_rect(aes(xmin=1, xmax=20, ymin=1, ymax=20, fill="white"), color="black", size=3) +
#   geom_rect(aes(xmin = x1, xmax = x2, ymin = y1, ymax = y2, fill=f), color="black", size=3) +
#   scale_fill_identity() + scale_color_identity() + 
#   xlim(0,20) + ylim(0,20) + coord_fixed() +
#   theme_void() +
#   theme(legend.position = "none")
# 
# ## With lines only
# xlines <- c(1,20)
# ylines <- c(1,20)
# for (n in sample(2:20, sample(3:12, replace = F), replace = F)) {
#   xlines <- c(xlines, n)
# }
# for (n in sample(2:20, sample(3:12, replace = F), replace = F)) {
#   ylines <- c(ylines, n)
# }
# xlens <- c()
# for (x in xlines) {
#   xlens <- c(xlens, )
# }
# 
# ggplot() +
#   geom_rect(aes(xmin=1, xmax=20, ymin=1, ymax=20, fill="white"), color="black", size=3) +
#   geom_hline(aes(yintercept = xlines), size=1, ) +
#   geom_vline(aes(xintercept = ylines), size=1) +
#   scale_fill_identity() + scale_color_identity() + 
#   xlim(1,20) + ylim(1,20) + coord_fixed() +
#   theme_void() +
#   theme(legend.position = "none")
# 
# 
