# Stoxx Europe 600 Composition
stock_lst <- read_csv("./inputs/sxxp.csv")

stoxxComp <- stock_lst %>% 
  group_by(sector) %>% 
  tally() %>% 
  ggplot(aes(x = reorder(sector, -n), 
             y = n)) +
  geom_bar(aes(fill = sector), 
           stat  = 'identity', 
           alpha = .7, 
           width = .8) +
  geom_text(aes(label = paste0(n)), 
            hjust = -.25, 
            size  = 3) +
  scale_fill_brewer(palette = "Set3") +
  coord_flip() +
  theme_classic() +
  ggtitle("Stoxx Europe 600 Composition") +
  theme(plot.title = element_text(hjust = .5)) +
  theme(axis.title.x = element_blank(),
        axis.ticks.x = element_blank()) +
  theme(axis.title.y = element_blank(),
        axis.ticks.y = element_blank()) +
  theme(legend.position = "none")

ggsave("./outputs/stoxxComp.png")