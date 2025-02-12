[![DOI](https://zenodo.org/badge/916551539.svg)](https://doi.org/10.5281/zenodo.14674290)

# Finite Element Modeling (FEM) of a Single Cell with Fragmented or Fused Vacuole

Rowen Betz<sup>1 </sup>, Wylie Tiernan<sup>1 </sup>, Kurtis Shipman<sup>1 </sup>, Veronica Graciela Castro<sup>1 </sup>, Roya Campos<sup>1 </sup>, Adrien Heymans<sup>2</sup>, Olivia Hazelwood<sup>3 </sup>, Arif Ashraf<sup>3 </sup>, Stephanie Roberts<sup>2</sup>, Cecilia Rodriguez-Furlan<sup>1* </sup>

<sub>1. School of Biological Sciences, Washington State University, Pullman, WA 99164, USA. ​</sub>

<sub>2. Umeå Plant Science Center, Department of Forest Genetics and Plant Physiology, 90187, Umeå, Sweden</sub>

<sub>3. University of British Columbia, Canada </sub> 

## 1. About

This repository contains a Finite Element Model (FEM) of a single biological cell with either a fragmented or fused vacuole. The FEM framework uses the [bvpy](https://gitlab.inria.fr/mosaic/bvpy/-/tree/dev_gmsh?ref_type=heads) library, and the mesh generation was performed with [GMSH](https://gmsh.info/).

## 2. Install

You can download the content of the repository using for instance the `git` command line tool

```bash
git clone https://github.com/SRobertGroup/FragmentedVac.git
cd FragmentedVac
```

#### Requirements

- Python 3.9
- FEniCS 2019.1.0
- GMSH 4.11
- Bvpy-develop
- Paraview 5.11.1
- R 4.3.1

### From mamba/conda

>[!NOTE] 
> We recommend to use [Mamba](https://mamba.readthedocs.io/en/latest/installation/mamba-installation.html) to create a virtual environment and run the FEM script in it ([Anaconda](https://www.anaconda.com/download) works also)
>
> For more information on how to set-up conda, please check the [conda user guide](https://conda.io/projects/conda/en/latest/user-guide/install)

```{bash}
mamba env create -f conda/fracvac_env.yaml
mamba activate fracvac_env
```

## 3. Usage and Repository content

FEM analysis of a single biological cell with either a fragmented or fused vacuole.

## Mesh Details

The cell geometry is a square with rounded corners, where:
- **Length (l):** 6 µm
- **Corner radius (r_corner):** 1 µm
- **Cell wall thickness:** 2 µm

The vacuole occupies the same area in both models:
- **Area of vacuole:** π * (2.8 µm)²

There are two different configurations for the vacuole:
1. **Fused vacuole:** A single disc representing the vacuole.
2. **Fragmented vacuole:** Nine smaller discs that together occupy the same total area as the fused vacuole.

## Citation

Cite the preprint:
> Oliver Betz, Wylie Tiernan, Kurtis Shipman, Graciela Veronica Castro, Roya Campos, Adrien Heymans, Olivia Hazelwood, Arif Ashraf, Stéphanie Robert, Cecilia Rodriguez-Furlan, **2025**. *Regulation of vacuole fusion, a pivotal mechanism mitigating salt-induced inhibition of root cell growth*. PREPRINT (Version 1) Research Square. doi:[https://doi.org/10.21203/rs.3.rs-5861118/v1](https://doi.org/10.21203/rs.3.rs-5861118/v1)
