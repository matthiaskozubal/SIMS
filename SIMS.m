%% SIMS
% 2012.08
% Maciej Kozubal
clear all
tic();

%% Split data in a single file into many two-column-files - repeat for every file with "?" extension
%header...?
addpath('d:\Dropbox\PROGRAMS\MATLAB\SIMS\')
cd('d:\Dropbox\PROGRAMS\MATLAB\SIMS\')
RBSfiles = dir('*.RBS'); % list
for i=1:length(RBSfiles)
	handy(:,:) = dlmread(RBSfiles(i).name, '', 15, 0); % read i-th file from 16th line
	handy(:,1) = []; % delete 1st (original counting) column
	handy(:,5) = []; % delete 6th (original counting) column
	RBSdata(:,1) = [1:4*length(handy)]';
	RBSdata(:,2) = reshape(handy',1,[])';
	RBSname = strrep(RBSfiles(i).name, '.RBS', '.txt');
	save(RBSname, 'RBSdata',  '-ascii');	
	clear handy RBSdata
end%for
%%
toc()
%*******END*********