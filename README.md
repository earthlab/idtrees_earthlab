# IDTReeS competition - EarthLab team

Code for the *Jeepers Treepers* team consisting of Earth Lab folks, participating in the Integrating Data science with Trees and Remote Sensing (IDTreeS) 2020 plant classification challenge [https://idtrees.org/competition/](https://idtrees.org/competition/). 

### Data

The IDTReeS competition organizers provided us with field-based and airborne remote sensing data collected by the National Ecological Observatory Network (NEON) along with individual tree crown polygons, available here: 

> Graves, Sarah, & Marconi, Sergio. (2020). IDTReeS 2020 Competition 
> Data (Version 4) [Data set]. Zenodo. http://doi.org/10.5281/zenodo.3934932

We chose to tackle task #2, classification of individual tree crowns' taxonomic identity. 
We utilized three of the four available remote sensing data types in our method: 
* Red, Green, Blue (RGB) images
* Hyperspectral reflectance data
* Lidar point cloud

### Code 

Our workflow includes the following major computational steps: 

Processing step | File or source | Coding language 
---- | --------------- | -------------
(1) Resnet CNN to generate a probability for each taxon class from the RGB images | IDTReeS_RGB.ipynb | Python
(2) Extract hyperspectral data at each tree crown centroid | https://github.com/earthlab/neonhs | R
(3) Generate pseudowaveforms within each tree polygon using lidar point cloud data | lidar_data_processing.ipynb | Python
(4) Fusion network classifier using all remote sensing features | idtrees-tabular.ipynb | Python
(5) Create additional figures for manuscript | create_figures.R | R
