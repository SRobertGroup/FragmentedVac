

# IO function for analysis of xdmf files with stress and strain tensor

# Works for 2D mesh 
# Adrien Heymans, September 2024
# 



library(tidyverse)
library(data.table)


# Function to construct the 2x2 tensor matrix
df_to_tensor <- function(df_row) {
  sigma_xx <- df_row[5]
  sigma_xy <- df_row[2]
  sigma_yx <- df_row[4]
  sigma_yy <- df_row[1]
  
  # Since the tensor is symmetric, we average the off-diagonal components
  sigma_xy <- (sigma_xy + sigma_yx) / 2
  
  # Construct the 2x2 tensor matrix
  tensor_matrix <- matrix(c(
    sigma_xx, sigma_xy,
    sigma_xy, sigma_yy
  ), nrow = 2, ncol = 2, byrow = TRUE)
  
  return(tensor_matrix)
}

# Function to compute amplitude (Frobenius norm divided by sqrt of dimension)
amplitude <- function(tensor) {
  dim <- nrow(tensor)
  return(norm(tensor, type = "F") / sqrt(dim))
}

# Function to compute the spherical (isotropic) part of the tensor
sph <- function(tensor) {
  dim <- nrow(tensor)
  return((sum(diag(tensor)) / dim) * diag(dim))
}

# Function to compute the deviatoric (non-isotropic) part of the tensor
dev <- function(tensor) {
  return(tensor - sph(tensor))
}

# Function to compute anisotropy (ratio of deviatoric to spherical amplitude)
anisotropy <- function(tensor) {
  return(amplitude(dev(tensor)) / amplitude(sph(tensor)))
}

stress_strain <- function(data){
  
  
  data$stress_magnitude <- apply(data%>%select(starts_with("Stress")), 1, function(row) {
    tensor <- df_to_tensor(row)
    amplitude(tensor)
  })
  
  data$strain_magnitude <- apply(data%>%select(starts_with("Strain")), 1, function(row) {
    tensor <- df_to_tensor(row)
    amplitude(tensor)
  })
  
  data$stress_anisotropy <- apply(data%>%select(starts_with("Stress")), 1, function(row) {
    tensor <- df_to_tensor(row)
    anisotropy(tensor)
  })
  
  data$strain_anisotropy <- apply(data%>%select(starts_with("Strain")), 1, function(row) {
    tensor <- df_to_tensor(row)
    anisotropy(tensor)
  })
  return(data)
}

# Function to compute principal stresses and their orientation
principal_stress <- function(tensor) {
  eig <- eigen(matrix(unlist(tensor), ncol = 2))
  
  # Principal stresses (eigenvalues)
  principal_stresses <- eig$values
  
  # Principal directions (eigenvectors)
  principal_directions <- eig$vectors
  
  angle <- atan2(principal_directions[2, 1], principal_directions[1, 1])
  
  return(list(stresses = principal_stresses, angle = angle))
}


direction_stress <- function(data){
  
  data$stress_Eigenval1 <- apply(data%>%select(starts_with("Stress")), 1, function(row) {
    tensor <- df_to_tensor(row)
    principal <- principal_stress(tensor)
    as.numeric(principal$stresses[1])
  })
  
  data$stress_Eigenval2 <- apply(data%>%select(starts_with("Stress")), 1, function(row) {
    tensor <- df_to_tensor(row)
    principal <- principal_stress(tensor)
    as.numeric(principal$stresses[2])
  })
  
  data$angle <- apply(data%>%select(starts_with("Stress")), 1, function(row) {
    tensor <- df_to_tensor(row)
    principal <- principal_stress(tensor)
    as.numeric(principal$angle[1])
  })

  return(data)
}


alp_polygon <- function(dat, a = 100, str_polygon = T){
  # Get the alphahull shape and convert it to dataframe
  my.ashape = alphahull::ashape(x= dat$x, y = dat$y, alpha = a)
  # converted to sf polygons
  a <- data.frame(my.ashape$edges)[,c( 'x1', 'y1', 'x2', 'y2')]
  l <- sf::st_linestring(matrix(as.numeric(a[1,]), ncol=2, byrow = T))
  for(i in 2:nrow(a)){
    l <- c(l, sf::st_linestring(matrix(as.numeric(a[i,]), ncol=2, byrow = T)))
  }
  alphapoly <- sf::st_sf(geom = st_sfc(l), crs = 2056) %>% st_polygonize() %>% st_collection_extract()
  pol = as.data.frame(matrix(unlist(alphapoly$geom[[1]]),ncol = 2))
  colnames(pol) = c("x", "y")
  
  if(str_polygon){
    return(alphapoly)
  }else{
    return(pol)
  }
}


