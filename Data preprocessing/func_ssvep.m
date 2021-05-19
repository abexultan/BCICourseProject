function [out] = func_ssvep(Tra_data)
params = {'time', 4;...
'freq' , 60./[5, 7, 9, 11];...
'fs' , 100;...
'band' ,[0.5 40];...
'channel_index', [23:32]; ...
'time_interval' ,[0 4000]; ...
'marker',  {'1','up';'2', 'left';'3', 'right';'4', 'down'}; ...
};
in = opt_cellToStruct(params);
Tra_data = prep_resample(Tra_data, 100, {'Nr', '0'});
Tra_data = prep_filter(Tra_data, {'frequency', in.band; 'fs', in.fs});
Tra_data = prep_segmentation(Tra_data, {'interval', in.time_interval});
s_Dat_tr = Tra_data.x(:, :, in.channel_index); % ** 


for i = 1:size(s_Dat_tr,2)
    res_cca = ssvep_cca_analysis(squeeze(s_Dat_tr(:,i,:)),{'marker',in.marker;'freq', in.freq;'fs', in.fs;'time',in.time});
    r(i,:) = res_cca;
end

out.x = permute(r,[2 1]);
out.y = Tra_data.y_logic;
end