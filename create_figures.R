library(dplyr) 
library(tidyr)
library(xtable)
library(ggplot2)
library(sf)
library(rnaturalearth)
library(rnaturalearthdata)
library(USAboundaries)
library(ggspatial)

# create output directory
dir.create("figures")

# LATEX TABLE crown taxonIDs, scientific and common names, and counts 

rgb_taxonID_counts <- data.frame(taxonID = c("ACPE", 
                                            "ACRU",
                                            "ACSA3",
                                            "AMLA",
                                            "BETUL",
                                            "CAGL8",
                                            "CATO6",
                                            "FAGR",
                                            "GOLA",
                                            "LITU",
                                            "LYLU3",
                                            "MAGNO",
                                            "NYBI",
                                            "NYSY",
                                            "OXYDE",
                                            "PIEL",
                                            "PINUS",
                                            "PIPA2",
                                            "PITA",
                                            "PRSE2",
                                            "QUAL",
                                            "QUCO2",
                                            "QUERC",
                                            "QUGE2",
                                            "QUHE2",
                                            "QULA2",
                                            "QULA3",
                                            "QUMO4",
                                            "QURU",
                                            "ROPS",
                                            "TSCA"),
                                scientificName = c("Acer rubrum L.",
                                                   "Acer pensylvanicum L.",
                                                   "Acer saccharum Marshall",
                                                   "Amelanchier laevis Wiegand",
                                                   "Betula sp.",
                                                   "Carya glabra (Mill.) Sweet",
                                                   "Carya tomentosa (Lam.) Nutt.",
                                                   "Fagus grandifolia Ehrh.",
                                                   "Gordonia lasianthus (L.) Ellis",
                                                   "Liriodendron tulipifera L.",
                                                   "Lyonia lucida (Lam.) K. Koch",
                                                   "Magnolia sp.",
                                                   "Nyssa biflora Walter",
                                                   "Nyssa sylvatica Marshall",
                                                   "Oxydendrum sp.",
                                                   "Pinus elliottii Engelm.",
                                                   "Pinus sp.",
                                                   "Pinus palustris Mill.",
                                                   "Pinus taeda L.",
                                                   "Prunus serotina Ehrh.",
                                                   "Quercus alba L.",
                                                   "Quercus coccinea Münchh.",
                                                   "Quercus sp.",
                                                   "Quercus geminata Small",
                                                   "Quercus hemisphaerica W. Bartram ex Willd.",
                                                   "Quercus laevis Walter",
                                                   "Quercus laurifolia Michx.",
                                                   "Quercus montana Willd.",
                                                   "Quercus rubra L.",
                                                   "Robinia pseudoacacia L.",
                                                   "Tsuga canadensis (L.) Carrière"),
                                commonName = c("red maple",
                                               "striped maple",
                                               "sugar maple",
                                               "Allegheny serviceberry",
                                               "birch",
                                               "pignut hickory",
                                               "mockernut hickory",
                                               "American beech",
                                               "loblolly bay",
                                               "tuliptree",
                                               "fetterbush lyonia",
                                               "magnolia",
                                               "swamp tupelo",
                                               "blackgum",
                                               "sourwood",
                                               "slash pine",
                                               "pine",
                                               "longleaf pine",
                                               "loblolly pine",
                                               "black cherry",
                                               "white oak",
                                               "scarlet oak",
                                               "oak",
                                               "sand live oak",
                                               "Darlington oak",
                                               "turkey oak",
                                               "laurel oak",
                                               "chestnut oak",
                                               "northern red oak",
                                               "black locust",
                                               "eastern hemlock"),
                                nCrowns = c(5, 
                                            104,
                                            1,
                                            38,
                                            6,
                                            3,
                                            1,
                                            3,
                                            1,
                                            16,
                                            1,
                                            12,
                                            1,
                                            33,
                                            9,
                                            4,
                                            6,
                                            237,
                                            3,
                                            6,
                                            86,
                                            39,
                                            1,
                                            15,
                                            3,
                                            59,
                                            1,
                                            10,
                                            138,
                                            2,
                                            2)) %>% 
  tidyr::separate(scientificName, into = c('genus', 'species'), sep = ' ', 
                  extra = 'drop', remove = FALSE) %>% 
  # add a column combining genus and species 
  dplyr::mutate(genusSpecies = paste(genus,species))

  
# create table with latex code 
species_table <- xtable(rgb_taxonID_counts %>%
         select(taxonID, genusSpecies, commonName, nCrowns) %>% 
           arrange(desc(nCrowns)),
       digits = c(0))

# rename columns
names(species_table) = c("Taxon ID", "Scientific Name", "Common name", "Count")

# print table as latex code in console 
print(species_table, include.rownames=FALSE)


# HISTOGRAM of species counts ---------------------------------------

rgb_taxonID_counts %>%
ggplot(aes(x=reorder(taxonID, desc(taxonID)), y=nCrowns)) +
  geom_bar(stat="identity", fill = "slategray4") +
  # add label with count to each bar
  geom_text(aes(label=nCrowns), hjust=-0.25) + 
  theme_minimal() + 
  labs(x = "Taxon code"
       ,y = "Number of individuals"
       ) + 
  coord_flip() + 
  theme(axis.text=element_text(size=12),
        axis.title=element_text(size=14)) + 
  # set x limits a bit higher to avoid cutting off label for long bar
  ylim(0, max(rgb_taxonID_counts$nCrowns) + 20)

# save to image file 
ggsave(filename = "figures/taxonID_histogram.pdf")



# HISTOGRAM of species counts ---------------------------------------
# MINIMAL labels, meant for putting next to table in latex
rgb_taxonID_counts %>%
  ggplot(aes(x=reorder(taxonID, desc(taxonID)), y=nCrowns)) +
  geom_bar(stat="identity", fill = "slategray4") +
  # add label with count to each bar
  #geom_text(aes(label=nCrowns), hjust=-0.25) + 
  theme_minimal() + 
  labs(x = ""
       ,y=""
       #,x = "Taxon code"
       #,y = "Number of individuals"
  ) + 
  coord_flip() + 
  theme(axis.text=element_text(size=12),
        axis.title=element_text(size=14)) + 
  # set x limits a bit higher to avoid cutting off label for long bar
  ylim(0, max(rgb_taxonID_counts$nCrowns) + 20)

# save to image file 
ggsave(filename = "figures/taxonID_histogram_simple.pdf", width=3)




# STUDY AREA map  ---------------------------------------------------

# NEON site locations
# downloaded from: https://www.neonscience.org/data/about-data/spatial-data-maps
neon_sites <- sf::st_read("data/NEON_Field_Sites_v17.shp")
neon_domains <- sf::st_read("data/NEON_Domains.shp")

# filter for the 3 sites of interest 
sites_of_interest <- neon_sites[neon_sites$siteName %in% c("Talladega National Forest",
                                                         "Ordway-Swisher Biological Station",
                                                         "Mountain Lake Biological Station"),]

# filter NEON domains of interest
domains_of_interest <- neon_domains[neon_domains$DomainID == 7 | 
                                    # 7 Appalachians / Cumberland Plateau
                                    neon_domains$DomainID == 8 | 
                                    # 8 Ozarks Complex
                                    neon_domains$DomainID == 2 | 
                                    # 2 Mid Atlantic
                                    neon_domains$DomainID == 3 |
                                    # 3 Southeast
                                    neon_domains$DomainID == 1 | 
                                      # 1 Northeast
                                    neon_domains$DomainID == 6, ]
                                    # 6 Prairie Peninsula
                                    
                                    
                                    



# get country data for the entire world 
world <- ne_countries(scale = "medium", returnclass = "sf")

# get states data (admin level 1 in USA)
states <- USAboundaries::us_states()

# make a map with a scale bar and north arrow using the ggspatial package 
ggplot() +
  # add world map boundaries
  #geom_sf(data = world) +
  # add state boundaries
  geom_sf(data = states, fill="grey", color="gray60", alpha=0.5) + 
  # add NEON domain boundaries 
  geom_sf(data = domains_of_interest, aes(fill = factor(DomainName)), 
          alpha = 0.7, color = "gray40") + 
  scale_fill_brewer(palette = "BuGn") + 
  # add the NEON sites of interest point locations
  geom_sf(data = sites_of_interest, color = "black", size = 2) +
  # add scale bar
  annotation_scale(location = "bl", width_hint = 0.5) +
  # add north arrow
  annotation_north_arrow(location = "br", which_north = "true", 
                         pad_x = unit(0.15, "in"), pad_y = unit(0.25, "in"),
                         style = north_arrow_fancy_orienteering) +
  # label the NEON sites of interest
  geom_sf_text(data = sites_of_interest, aes(label = siteID), colour = "black",
               # nudge the text away from each point
               nudge_x = c(-0.5, -1, 0.5),
               nudge_y = c(0.5, -0.25, 0.5)) + 
  # zoom in! set the x and y limits for the map
  coord_sf(xlim = c(-89, -77), ylim = c(28, 38)) + 
  # label x,y axes
  labs(x = "Longitude", y = "Latitude", fill = "NEON Domain") + 
  theme_bw() 


ggsave(filename = "figures/study_area_map.pdf")
