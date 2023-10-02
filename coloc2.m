clear
% load('25ctrl_coloc.mat')
% load('50clathrin+AP2_control_TIRFcoloc.mat')
load('70ctrl_coloc28.mat')
CONcolocAAp2 = colocAAp2;
CONcolocCL=colocCL; 
CONcolocAAp2s = colocAAp2s;
CONcolocCLs=colocCLs; 
% CONtotAAp2=totAAp2;CONtotCl=totCl;CONAFCl=AFCl;CONAFap2=AFap2;
%%
% CONcolocAAp2s = colocAAp2s;
% CONcolocCLs=colocCLs;
clearvars -except CONcolocAAp2 CONcolocCL CONcolocAAp2s CONcolocCLs CONtotAAp2 CONtotCl CONAFCl CONAFap2
% clearvars -except CONcolocAAp2 CONcolocCL 

% load('65trp_coloc.mat')
% load('56clathrin+AP2_trypsin_TIRFcoloc.mat')

load('75tryp_coloc28.mat')
TRYPcolocAAp2 = colocAAp2;
TRYPcolocCL=colocCL;
% TRYPtotAAp2=totAAp2;
% TRYPtotCl=totCl;TRYPAFCl=AFCl;TRYPAFap2=AFap2;
TRYPcolocAAp2s = colocAAp2s;
TRYPcolocCLs=colocCLs;
% clearvars -except CONcolocAAp2 CONcolocCL TRYPcolocAAp2 TRYPcolocCL CONcolocAAp2s CONcolocCLs TRYPcolocAAp2s TRYPcolocCLs
clearvars -except CONcolocAAp2 CONcolocCL TRYPcolocAAp2 TRYPcolocCL TRYPcolocAAp2s TRYPcolocCLs TRYPtotAAp2 TRYPtotCl TRYPAFCl TRYPAFap2 CONcolocAAp2s CONcolocCLs CONtotAAp2 CONtotCl CONAFCl CONAFap2

%%
clc
ranksum(CONcolocCL(CONcolocCL>0),TRYPcolocCL(TRYPcolocCL>0))
mean(TRYPcolocCL(TRYPcolocCL>0))/mean(CONcolocCL(CONcolocCL>0))
ranksum(CONcolocAAp2(CONcolocAAp2>0),TRYPcolocAAp2(TRYPcolocAAp2>0))
mean(TRYPcolocAAp2(TRYPcolocAAp2>0))/mean(CONcolocAAp2(CONcolocAAp2>0))

%%
ranksum(CONcolocCL(CONcolocCL>0),TRYPcolocCL(TRYPcolocCL>0))
mean(TRYPcolocCL(TRYPcolocCL>0))/mean(CONcolocCL(CONcolocCL>0))
ranksum(CONcolocAAp2(CONcolocAAp2>0),TRYPcolocAAp2(TRYPcolocAAp2>0))
mean(TRYPcolocAAp2(TRYPcolocAAp2>0))/mean(CONcolocAAp2(CONcolocAAp2>0))

%%
clc
ranksum(CONcolocCLs(CONcolocCLs>0),TRYPcolocCLs(TRYPcolocCLs>0))
mean(TRYPcolocCLs(TRYPcolocCLs>0))/mean(CONcolocCLs(CONcolocCLs>0))
ranksum(CONcolocAAp2s(CONcolocAAp2s>0),TRYPcolocAAp2s(TRYPcolocAAp2s>0))
mean(TRYPcolocAAp2s(TRYPcolocAAp2s>0))/mean(CONcolocAAp2s(CONcolocAAp2s>0))