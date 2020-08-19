library(dplyr) 
library(tidyr)
library(xtable)

# TABLE crown taxonIDs, scientific and common names, and counts 

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

# create table with taxonID, genus and species, count 
rgb_taxonID_counts %>%
  select(taxonID, genusSpecies, commonName, nCrowns)
  kable() %>%
  kable_styling()
  
# create table with latex code 
species_table <- xtable(rgb_taxonID_counts %>%
         select(taxonID, genusSpecies, commonName, nCrowns),
       digits = c(0))

# rename columns
names(species_table) = c("Taxon ID", "Scientific Name", "Common name", "Number")

# print table as latex code in console 
print(species_table, include.rownames=FALSE)


# HISTOGRAM of species counts -------


