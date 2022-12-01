#bird phylogeny

library(phytools)
library(geiger)
library(diversitree)
library(mapplots)

phylo1<-"((Caudata, Anura), Gymnophiona);"

birdphylo<-"(Ostriches,((Flamingos,Grebes), Pigeons, Hoatzin, (Potoos,(Nightjars,(Swifts, Hummingbirds)))));"
birds<-read.tree(text = birdphylo)
bird_tree<-plotTree(birds, ftype="reg", edge.color = ("blue"),label.offset=.2)

?plotTree























