library(ggplot2)
library(tidyverse)
#library(patchwork)

# Make color palette
clrs <- c(rep("#C52F24",3),
          rep("#1513C6",4),
          rep("#FDF851",3),
          "#7AB3BA",
          "#000000",
          rep("#FFFFFF",5))

# Create a dataframe with random rectangles
xa <- sample(0:4,15,replace=T)
ya <- sample(0:4,15,replace=T)

df <- data.frame(xmin=xa, ymin=ya)
df <- df %>% 
  rowwise() %>% 
  mutate(xmax = sample(0:(4-xmin+1),1)) %>% 
  mutate(ymax = sample(0:(4-ymin+1),1)) %>% 
  mutate(color = sample(clrs, 1))

# Plot the Mondrian-like canvas
ggplot(df) +
  geom_rect(aes(xmin=0, xmax=5, ymin=0, ymax=5, fill="white"), color="black", size=2) +
  geom_rect(aes(xmin = xmin, xmax = xmax, ymin = ymin, ymax = ymax, fill=color), color="black", size=2) +
  scale_fill_identity() + scale_color_identity() + 
  xlim(0,5) + ylim(0,5) + 
  coord_flip() +
  theme_void() +
  theme(legend.position = "none")