# Mechano-regulation-by-pit-formation-during-De-adhesion
All codes related to the manuscript

MATLAB code for calculation of PCOV

1.CalculatingPSDwithMaskinparts (main code)
 Input needed: file path where 2048 IRM frames are saved
               No of cells to be analyzed in one frame
               draw cell boudary, background
               Conversion factor
               Frame rate            
2.psdIMcovMaskpixelreadJG1024Long (function file)

______________
MATLAB code for calculation of temporal, spatial fluctuation, tension, active temp, 
cytoplasmic viscosity, Confinement of all FBRs

1.Multifol_findFBRnew (main code)
Input needed: file path where 2048 IRM frames are saved
               No of cells to be analysed
               Draw a rectangular box around a particular cell to be analyzed
               draw cell boudary, nucleus
               Conversion factor
               Imin
               FBR size
               Frame rate
2.fitPSD (function file)

_______________________________
MATLAB code for generating temporal map
wholefieldSDmap (main code)
 Input needed: load IRM images 
                       Imin, conversion factor
                       Put scale value for colour map

________________

MATLAB code for Tension Mapping Piexel wise

1.tensionmappingsinglefile (main code)
 Input needed: load background pcov file "allpsd3_back_1.mat" and cell file "allpsd3_cell_1.mat" in this format. These files are generated from "CalculatingPSDwithMaskinparts" code for PCOV analysis
2.psdsimfunc6 (function file)
3.calculateR2 (function file)



FBR Size :M=12;N=12;
Frame rate:=20
pixel size=72 nm


________________
MATLAB code for Tension Mapping FBR wise
plotTenmapfromFBRanalysis (main code)
Input needed: Load fbrTen generated from "Multifol_findFBRnew.mat"
                       fbr size
                       scale bar for colour map
___________________________
MATLAB coder for excess area
excess_area (main code)
Input needed : load 'BAAAna001-01Cell_01" file generated from "Multifol_findFBRnew"
               Conversion factor
               Imin
               path where the 2048 IRM images are kept
               pixel size
               take values from "mean_frames_filtered_image" mat file

_______________________________
MATLAB coder for  area fraction for whole cell
areafraction_whole cell (main code)
ReadImageJROI ( to read image J roi)
Input needed : load the image, load cell boundary saved as ".roi"
                        put threshold value

_______________________________
MATLAB coder for  area fraction of same rois follwed
sameroisfollow (main code)
Input needed : No of rois to be followed , 
                         load the images, 
                         No of frames to be followed, 
                         Put threshold value

_______________________________
MATLAB coder for  colocalization analysis of  same rois follwed
coloc_analysis (folder)
Input needed : No of rois to be followed  - add as index of run, 
                         load the image, 
                         No of frames to be followed, 
                         

______________________________
 MATLAB coder for force calculation from optical trap
trap_all_files (main code for detecting bead position)
ReadImageJROI (function file to read Image J rois on the bead)
CircleFitByPratt (Function file for fitting bead boundary to a circle for center detection)
Input needed : Path of the image , Path of the mask 
plot_trap ( Main code for plotting the position of bead and force on the bead with time)
 Input needed : ".txt" file generated from trap_all_files.mat

_______________________________
MATLAB coder for  distribution plot of FBR wise data
cellwisedistributionplot (main code)
Input needed : load ".csv" file where fbrwise data are saved
                       No of sets
                       No of condition

_______________________________
MATLAB coder for  no of peak analysis
peaksfromprofiles (main code)
Input needed : load line scan intensity value in ".mat" as "A"  generated from the line scans under the membrane
                       Plot npm for no of tubules /um


_______________________________
MATLAB coder for  spread area change
deadhesion_spreadarea_changed (main code)
Input needed : load values of spread area 

_______________________________
MATLAB coder for lme analysis
ReformatData_lme_deadhesion (main code)
Input needed : give the file path
                      load data in ".csv" 
                       No of sets
                       No of condition
                       take the values of "aoutm"

_______________________________
MATLAB coder for plotting temporal data
tf_deadhesion (main code)
Input needed:  give file path
                        load data in ".csv" 
                       No of sets
                       No of condition
