% This reads 13 surface markers of Marrow1_Basal1 sample from fcs files and saves them in MATLAB format.

CD_columns_num = [6 11 13 14 15 16 17 19 25 26 31 33 40];
pref = 'FCS/Marrow1_01_Basal1_Marrow1_Basal1_';
labels_cell_types = {'CD11b- Monocyte','CD11bhi Monocyte','CD11bmid Monocyte','CMP','GMP','HSC',...
  'Immature B','Mature CD4+ T','Mature CD8+ T','Mature CD38lo B','Mature CD38mid B','MEP','MPP',...
  'Naive CD4+ T','Naive CD8+ T','NK','Plasma cell','Plasmacytoid DC','Pre-B I','Pre-B II'};
suff = '.fcs';
cell = []; cell_labels=[];
for i=1:length(labels_cell_types)
  [fcsdat, fcshdr, fcsdatscaled, fcsdatcomp] = fca_readfcs([pref labels_cell_types{i} suff]);
  cell = [cell; fcsdat(:,CD_columns_num)];
  cell_labels = [cell_labels; i*ones(size(fcsdat,1),1)];
end

for j=1:length(fcshdr.par)
  columns{j} = fcshdr.par(j).name2;
end

surface_markers = columns(CD_columns_num);

%% Output: 
%  - surface_markers (1x13): cell array of 13 surface markers
%  - cell_labels (103757x1): array of cell type indeces
%  - cell (103757x13): the values for 13 markers for each point in the
%    dataset
%  - labels_cell_types(1x20): 20 types od cells in the dataset
save('bone_marrow','surface_markers','cell_labels cell','labels_cell_types');
