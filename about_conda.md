# Setting up VS Code:
    cltr + shft + P and search for: Run Selected Text in Terminal, and set the shortcut accordingly

# Installing Conda without sudo access

    mkdir tools && cd $_
    wget https://repo.anaconda.com/archive/Anaconda3-2024.06-1-Linux-x86_64.sh
    chmod +x Anaconda*.sh
    bash Anaconda3-*.sh -b -p ~/anaconda3 # running installer
    ~/anaconda3/bin/conda init # adding to PATH
    source ~/.bashrc # restarting source to apply changes
    conda --version # verifying installation

# Creating a new dedicated conda env for specific r packages:
    conda env list
    conda create -n r_env r-base=4.2.2 -y
    conda activate r_env
    R
    installed.packages() # shows packages available with R base

    # Let's see all packages available via Conda

    conda activate r_env


## [Read more from here](https://docs.anaconda.com/working-with-conda/packages/using-r-language/)

# Installing required packages one by one:

## raster:

    conda install -c conda-forge r-raster -y
    R
    library(raster)
    quit()

## spocc (create new env due to version conflicting):

    conda install bioconda::r-spocc -y
    r
    library(spocc)
    quit()

## 
```
    R
    
    install.packages("spThin", dependencies = TRUE)
    
    install.packages(c("dismo", "sf", "ENMeval", "wallace", "Matrix", "htmlwidgets",
    "ade4", "ecospat", "leaflet", "tools", "fs", "dplyr", "humboldt", "stats", "ggplot2")) 
