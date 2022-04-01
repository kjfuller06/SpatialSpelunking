
# sorry folks, I struggled here so don't mind the mess

library(rgee)
library(reticulate)
earthengine_python <- Sys.getenv("EARTHENGINE_PYTHON", unset = NA)
Sys.setenv(RETICULATE_PYTHON = earthengine_python)
reticulate::py_config()
ee_install(py_env = "rgee")

library(rgee)
#ee_reattach() # reattach ee as a reserve word
# Initialize just Earth Engine
ee_Initialize() 
ee_Initialize(user = '@gmail.com') # Use the argument email is not mandatory, but it's helpful to change of EE user.
# Initialize Earth Engine and GD
ee_Initialize(user = '@gmail.com', drive = TRUE)
# Initialize Earth Engine and GCS
ee_Initialize(user = '@gmail.com', gcs = TRUE)
# Initialize Earth Engine, GD and GCS
ee_Initialize(user = '@gmail.com', drive = TRUE, gcs = TRUE)

library(rgee)
ee_Initialize()

srtm <- ee$Image("USGS/SRTMGL1_003")
viz <- list(
  max = 4000,
  min = 0,
  palette = c("#000000","#5AAD5A","#A9AD84","#FFFFFF")
)

Map$addLayer(
  eeObject = srtm,
  visParams =  viz,
  name = 'SRTM'
  # legend = TRUE
)


