# Kate's script <3
## https://github.com/r-spatial/rgee/

# libraries ####
# rm(list=ls()) # ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
# dev.off()     # ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
# cat("\f")     # ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~
# 
# library(raster)
# library(sf)
# library(rgee)
# library(scales)
# library(tmap)
# library(mapedit)
library(tidyverse)
# ee_check()
# ee_check_python()
# ee_check_credentials()
# ee_check_python_packages()
# ee_Initialize(drive = T, gcs = T)
ee_install_upgrade()

nc <- st_read(system.file("shape/nc.shp", package = "sf"), quiet = TRUE)

terraclimate <- ee$ImageCollection("IDAHO_EPSCOR/TERRACLIMATE") %>%
  ee$ImageCollection$filterDate("2001-01-01", "2002-01-01") %>%
  ee$ImageCollection$map(function(x) x$select("pr")) %>% # Select only precipitation bands
  ee$ImageCollection$toBands() %>% # from imagecollection to image
  ee$Image$rename(sprintf("PP_%02d",1:12)) # rename the bands of an image

ee_nc_rain <- ee_extract(x = terraclimate, y = nc["NAME"], sf = FALSE)

ee_nc_rain = ee_nc_rain %>% 
  pivot_longer(-NAME, names_to = "month", values_to = "pr") %>%
  mutate(month, month=gsub("PP_", "", month))
