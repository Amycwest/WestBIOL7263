##acuity view##

#load packages
library("AcuityView")
library("magrittr")
library("fftwtools")
library("imager")

#Notes
#MRA=1/CPD
#eyeresolution is in MRA
#distance and realwidth are in meters
#all photos taken by me
#CPD info from Martin, G. R. (2017). The sensory ecology of birds. Oxford University Press

#List of animals and their CPD
#Western barn owl  4.0
#House Sparrow 4.8
#Carolina chickadee 5
#Sacred Kingfisher 26
#Rook 29.5



#Western Barn Owl

#calculate MRA
1/4

#import image
snake <- load.image("assignments/Acuity/images/owl_sees_snake.JPG")

#resize images
dim(snake)
snake<-resize(img, 512, 512)
dim(snake)

AcuityView(photo=snake, distance = 1, realWidth = 1, eyeResolutionX = .25, 
           eyeResolutionY = NULL, plot = TRUE, output = "assignments/Acuity/Owl_sees_snake_1meter.jpg")

AcuityView(photo=snake, distance = 2, realWidth = 1, eyeResolutionX = .25, 
           eyeResolutionY = NULL, plot = TRUE, output = "assignments/Acuity/Owl_sees_snake_2meter.jpg")

AcuityView(photo=snake, distance = 3, realWidth = 1, eyeResolutionX = .25, 
           eyeResolutionY = NULL, plot = TRUE, output = "assignments/Acuity/Owl_sees_snake_3meter.jpg")

AcuityView(photo=snake, distance = 50, realWidth = 1, eyeResolutionX = .25, 
           eyeResolutionY = NULL, plot = TRUE, output = "assignments/Acuity/Owl_sees_snake_50meter.jpg")

#House Sparrow

#calculate MRA
1/4.8

#import image
train <- load.image("assignments/Acuity/images/HOSP_train.JPG")

#resize images
dim(train)
train<-resize(train, 512, 512)
dim(train)

AcuityView(photo=train, distance = 1, realWidth = 8, eyeResolutionX = .21, 
           eyeResolutionY = NULL, plot = TRUE, output = "assignments/Acuity/Sparrow_sees_train_1meter.jpg")

AcuityView(photo=train, distance = 2, realWidth = 8, eyeResolutionX = .21, 
           eyeResolutionY = NULL, plot = TRUE, output = "assignments/Acuity/Sparrow_sees_train_2meter.jpg")

AcuityView(photo=train, distance = 3, realWidth = 8, eyeResolutionX = .21, 
           eyeResolutionY = NULL, plot = TRUE, output = "assignments/Acuity/Sparrow_sees_train_3meter.jpg")

AcuityView(photo=train, distance = 50, realWidth = 8, eyeResolutionX = .21, 
           eyeResolutionY = NULL, plot = TRUE, output = "assignments/Acuity/Sparrow_sees_train_50meter.jpg")


#Carolina Chickadee sees my birdfeeder

#calculate MRA
1/5

#import image
my_birdfeeder<-load.image("assignments/Acuity/images/Bird_feeder.jpg")

#resize image
dim(my_birdfeeder)
my_birdfeeder<-resize(my_birdfeeder, 512, 512)
dim(my_birdfeeder)

#generate images
AcuityView(photo=my_birdfeeder, distance = 1, realWidth = .3, eyeResolutionX = .2, 
           eyeResolutionY = NULL, plot = TRUE, output = "assignments/Acuity/CACH_sees_myfeeder_1meter.jpg")

AcuityView(photo=my_birdfeeder, distance = 2, realWidth =.3, eyeResolutionX = .2, 
           eyeResolutionY = NULL, plot = TRUE, output = "assignments/Acuity/CACH_sees_myfeeder_2meter.jpg")

AcuityView(photo=my_birdfeeder, distance = 3, realWidth =.3, eyeResolutionX = .2, 
           eyeResolutionY = NULL, plot = TRUE, output = "assignments/Acuity/CACH_sees_myfeeder_3meter.jpg")

AcuityView(photo=my_birdfeeder, distance = 50, realWidth = .3, eyeResolutionX = .2, 
           eyeResolutionY = NULL, plot = TRUE, output = "assignments/Acuity/CACH_sees_myfeeder_50meter.jpg")


#Sacred Kingfisher

#calculate MRA
1/26 #.038

#import image
fish<-load.image("assignments/Acuity/images/Kingfisher_sees_fish.JPG")

#resize image
dim(fish)
fish<-resize(fish, 512, 512)
dim(fish)

#generate images
AcuityView(photo=fish, distance = 1, realWidth = .75, eyeResolutionX = .038, 
           eyeResolutionY = NULL, plot = TRUE, output = "assignments/Acuity/Kingfisher_sees_fish_1meter.jpg")

AcuityView(photo=fish, distance = 2, realWidth = .75, eyeResolutionX = .038, 
           eyeResolutionY = NULL, plot = TRUE, output = "assignments/Acuity/Kingfisher_sees_fish_2meter.jpg")

AcuityView(photo=fish, distance = 3, realWidth = .75, eyeResolutionX = .038, 
           eyeResolutionY = NULL, plot = TRUE, output = "assignments/Acuity/Kingfisher_sees_fish_3meter.jpg")

AcuityView(photo=fish, distance = 50, realWidth = .75, eyeResolutionX = .038, 
           eyeResolutionY = NULL, plot = TRUE, output = "assignments/Acuity/Kingfisher_sees_fish_50meter.jpg")

#Rook

#calculate MRA
1/29.5

#import image
black_bird_in_sky<-load.image("assignments/Acuity/images/rook_see_vulture.JPG")
#it's actually a vulture, but the sentiment is there

#resize image
dim(black_bird_in_sky)
black_bird_in_sky<-resize(black_bird_in_sky, 512, 512)
dim(black_bird_in_sky)

#generate images
AcuityView(photo=black_bird_in_sky, distance = 1, realWidth = 12, eyeResolutionX = .033, 
           eyeResolutionY = NULL, plot = TRUE, output = "assignments/Acuity/Rook_sees_a_peer_1meter.jpg")

AcuityView(photo=black_bird_in_sky, distance = 2, realWidth = 12, eyeResolutionX = .033, 
           eyeResolutionY = NULL, plot = TRUE, output = "assignments/Acuity/Rook_sees_a_peer_2meter.jpg")

AcuityView(photo=black_bird_in_sky, distance = 3, realWidth = 12, eyeResolutionX = .033, 
           eyeResolutionY = NULL, plot = TRUE, output = "assignments/Acuity/Rook_sees_a_peer_3meter.jpg")

AcuityView(photo=black_bird_in_sky, distance = 50, realWidth = 12, eyeResolutionX = .038, 
           eyeResolutionY = NULL, plot = TRUE, output = "assignments/Acuity/Rook_sees_a_peer_50meter.jpg")

