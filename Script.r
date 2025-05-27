library(tidyverse)

Nukuhou_Disc <- read.csv("Nukuhou_Discharge_Storms_2023.csv")

str(Nukuhou_Disc)

#the timestamp in the csv is currently a character.  We need to change this to a timestamp.
Nukuhou_Disc <-Nukuhou_Disc %>% mutate(Time = parse_date_time(Time, orders = c("%d/%m/%Y %H:%M","%d/%m/%Y"),tz="etc/GMT+12")) 

Nukuhou_Disc %>% 
  ggplot(aes(x=Time,y=Value))+
  geom_path()+
  theme_bw()


library(padr)


Nukuhou_Disc_Pad <- Nukuhou_Disc %>% pad()

Nukuhou_Disc_Pad %>% 
  ggplot(aes(x=Time,y=Value))+
  geom_path()+
  theme_bw()

library(zoo)

Nukuhou_Disc_Pad <- Nukuhou_Disc_Pad %>% 
  mutate(Value_Spline = na.spline(Value)) %>% 
  mutate(Value_Linear = na.approx(Value))

Nukuhou_Disc_Pad %>% 
  ggplot() +
  geom_path(aes(x = Time, y = Value_Spline, color = "Spline")) +
  geom_path(aes(x = Time, y = Value_Linear, color = "Linear")) +
  geom_path(aes(x = Time, y = Value, color = "Original")) +
  scale_color_manual(name = "Legend", 
                     values = c("Spline" = "blue", "Linear" = "red", "Original" = "black")) +
  theme_bw()

Nukuhou_Disc_Pad %>% 
  select(Site, LocationName, Time, Value_Spline) %>% 
 # thicken(by = 'Time', interval = 'hour',colname = 'Hour_Stamp') %>% 
  thicken(by = 'Time', interval = 'day', colname = 'Day_Stamp') %>% 
  group_by(Day_Stamp) %>% 
  summarise(Value = mean(Value_Spline,na.rm=T)) %>% 
  ggplot()+
  geom_path(aes(x=Day_Stamp,y=Value))+
  theme_bw()

Nukuhou_Disc_Pad %>% 
  select(Site, LocationName, Time, Value_Spline) %>% 
  thicken(by = 'Time', interval = 'hour',colname = 'Hour_Stamp') %>% 
  #thicken(by = 'Time', interval = 'day', colname = 'Day_Stamp') %>% 
  group_by(Hour_Stamp) %>% 
  summarise(Value = mean(Value_Spline,na.rm=T)) %>% 
  ggplot()+
  geom_path(aes(x=Hour_Stamp,y=Value))+
  theme_bw()


  
