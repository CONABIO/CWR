#Codigo para bajar ocurrencias y mapearlas
library(spocc)
Capspp <- c('Capsicum annuum glabriusculum', 'Capsicum frutescens', 'Capsicum lanceolatum', 'Capsicum rhomboideum')
dat<-occ(query = Capspp, from = 'gbif', has_coords = TRUE, limit = 50)
occ2df(dat)
map_leaflet(dat)

#Otra forma de bajar ocurrencias usando dismo y maptools, adaptado de: http://www.molecularecologist.com/2016/03/using-r-to-mine-species-data/
library(dismo)
library(maptools)
Capann<-gbif("Capsicum", "annuum", geo=T, removeZeros=T, args='continent=NORTH_AMERICA') #retrieve all occurrences of Capsicum annuum from North America, from Canada to Panama
Capann_xy<-subset(Capann, lat !=0 & lon !=0) #retain only the georeferenced records. This can also be done by including geo=T in the previous command
coordinates(Capann_xy) = c("lon", "lat") #Set coordinates to a Spatial data frame
data(wrld_simpl)
plot(wrld_simpl,xlim=c(-100,0), ylim=c(-20,40), axes=TRUE, col='light green', las=1) #plot points on a world map
points(Capann_xy, col='orange', pch=20, cex=0.75) 
pdf(file = "Capann2.pdf")
jpeg(filename = "Capann2.jpeg")

#Write data to csv
write.csv(Capann_xy,'Capann.csv', row.names = FALSE)
#Write data to txt
write.table(Capann_xy,"Capann.txt", sep = "\t")

