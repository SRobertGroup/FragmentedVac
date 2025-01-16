


# Works for 2D mesh 
# Adrien Heymans, September 2024
# extract deformed mesh under csv with paraview macro

# Fragmented Vacuol
library(sf)

setwd("~/GitHub/SRobertGroup/FragmentedVac/")
source("./src/function/io_function.R")

# Radius of the different vacuol disc
r_hvac = c(2.8)
r_fvac = c(0.75,0.76, 0.79, 0.82,0.99,0.99,0.99, 1.09,1.13)

Force = 1
area_contact_hvac = 2*pi*r_hvac 
area_contact_fvac = 2*pi*r_fvac 
alpha = sum(area_contact_fvac)/area_contact_hvac
print(alpha)
message("The overall force apply due to turgor pressure in the fragmented vacuol configuration is :", round(alpha,3)," time greater than in the fuzed case")

Equal_force = 0.075*area_contact_hvac


P1 = Force/area_contact_hvac
P2 = (Force*alpha)/sum(area_contact_fvac)


initial_area = 6.4^2
path = "./data/out/csv/"
fls = list.files(path)

fls = fls[grepl("_all", fls)]
fls = fls[grepl("Pressure", fls)]
DATA = NULL
for(fl in fls){
  config = str_sub(fl, 1,4)
  type = str_sub(fl, 6,10)
  df = read.csv(paste0(path, fl))
  if(config == "fvac"){
    a = 5
  }else{a = 3}
  dat = df%>%transmute(x = round(Points.0, 8), y = round(Points.1,8))

  poly = try(alp_polygon(dat, a, str_polygon = T), silent = T)
  while(class(poly)[1] == "try-error"){
    poly = try(alp_polygon(dat%>%
                             mutate(x = jitter(x, factor = 1e-5), y = jitter(y, factor = 1e-5)), a, str_polygon = T), silent = T)
  }
  area <- as.numeric(st_area(st_as_sfc(poly)))
  diff = area -initial_area
  rel_growth = diff/initial_area
  P = parse_number(fl)
  if(type == "Force"){
    P = P*0.336977
  }
  DATA = rbind(DATA, tibble(config = config, type = type, area = area, diff = diff, rel_growth = rel_growth, P = P))
}


write.csv(DATA%>%filter(rel_growth != -1), "./data/out/csv/results.csv")
  
DATA%>%filter(rel_growth != -1) %>% 
  ggplot(aes(P, rel_growth*100, colour = config))+
  geom_line(size = 1)+
  geom_point(size = 2)+theme_classic()+
  ylab("Relative growth [%]")+xlab("Vacuolar turgor pressure [MPa]")

ggsave("./data/out/rel_growth.svg")

# df %>%ggplot()+
#   geom_line(aes(Force, rel_growth*100, colour = config))+
#   geom_point(aes(Force, rel_growth*100, colour = config))+theme_classic()+
#   geom_vline(xintercept = 0.075*area_contact_hvac, linetype = 2)+
#   ylab("relative growth [%]")+xlab("Sum of internal force apply on the tonoplast [µN]")


surf = read.csv("./data/out/csv/celltonoplast_surface.csv")
cell = read.csv("./data/out/csv/cell_surface.csv")
cell_wall = read.csv("./data/out/csv/cellwall_surface.csv")
cell_inter = read.csv("./data/out/csv/cellinterface_surface.csv")
surf_cell = ((cell$Area-cell$Area[4])/cell$Area[4])*100
surface = surf%>%
  dplyr::group_by(Label)%>%
  dplyr::summarise(sum_surf = sum(Area), .groups = "drop")%>%
  mutate(cell_area = rev(cell$Area)[-1],
         symplast = cell_area - cell_wall$Area[1]-sum(cell_inter$Area)-sum_surf,
         cell = rev(surf_cell)[-1],
         rel_tono_surf = 100*(sum_surf-pi*2.8^2)/(pi*2.8^2))
