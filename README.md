<img src="https://raw.githubusercontent.com/borstell/mondriaRt/master/mondriaRt.png" width="1400">

# mondriaRt
Make Mondria(a)n-style artwork with Python and R/ggplot2

# Step 1: Create rasters
This is done with the Python scripts `make_mondrians.py` and `mondrian.py`. The former calls the latter but enables iterated generation of rasters.

With `make_mondrians.py`, enter the number of paintings and tiles you want and if you want a random starting point (headstart=1) or start from coordinates `(0, 0)` (headstart=0 is default). For example:
```
python3 make_mondrians.py 9 5 5 1
```
... gives 9 paintings, each as a 5x5 grid, and a random starting point.
	
# Step 2: Read and plot rasters
This is done with the R script `make_mondrians.R` which makes use of [`ggplot2`](https://ggplot2.tidyverse.org) for plotting. Some examples of how to read and plot rasters are found inside the script.

# Step 3: Enjoy your artworks!
You can create and plot individual canvases...

![](https://raw.githubusercontent.com/borstell/mondriaRt/master/mondrian_tiny.png)

... or use [`patchwork`](https://patchwork.data-imaginist.com/index.html) to stitch several of them together!

![](https://raw.githubusercontent.com/borstell/mondriaRt/master/mondrian_3x3.png)
