import os
from paraview.simple import *

# Disable automatic camera reset on 'Show'
paraview.simple._DisableFirstRenderCameraReset()

input_folder = "./FragmentedVac/data/out/"
# Path to output CSV files folder 
output_folder = "./FragmentedVac/data/out/csv/"
# Define center and radius for selection

# Iterate over XDMF files in input folder
for file_name in os.listdir(input_folder):
    if file_name.endswith(".xdmf"):
        print(file_name)
        
        # Load XDMF file
        file = os.path.join(input_folder, file_name)
        xdmf_file = Xdmf3ReaderS(registrationName=file_name[:-5], FileName=file)
        print('loading')
        xdmf_file.PointArrays = ['Displacement Vector', 'Strain', 'Stress']
        print('loading completed')
        
        # Apply WarpByVector to deform the mesh
        warpByVector = WarpByVector(registrationName='WarpByVector', Input=xdmf_file)
        warpByVector.Vectors = ['POINTS', 'Displacement Vector']

        out_name = output_folder+file_name[:-5]+'_all.csv'
        # save data
        SaveData(out_name, proxy=warpByVector, PointDataArrays=['Stress'])
        print('saved')