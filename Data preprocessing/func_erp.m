function [out] = func_erp(dat)
out = prep_resample(dat, 100, {'Nr', '0'});
dat_selectedTrials = prep_selectTrials(out, {'Index', [1:100]});
out = prep_filter(dat_selectedTrials, {'frequency', [0.5 40];'fs',100});
out = prep_segmentation(out, {'interval', [-200 800]});
out = prep_baseline(out, {'Time',[-200 0]});
out = prep_selectTime(out, {'Time',[0 800]});
out = prep_selectChannels(out, {'Name',{'POz', 'FC1', 'FC2', 'C1', 'Cz', 'C2', 'CP1', 'CPz', 'CP2', 'PO3', 'PO4'}});
out = func_featureExtraction(out,{'feature','erpmean';'nMeans',10});
out.x = reshape(permute(out.x, [1, 3, 2]), [10*11, size(dat_selectedTrials.y_logic,2)]);
end
