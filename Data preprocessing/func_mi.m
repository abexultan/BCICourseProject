function out = func_mi(dat)
out = prep_resample(dat, 100, {'Nr', '0'}); % modified
out = prep_filter(out, {'frequency', [8 30];'fs',100});
out = prep_segmentation(out, {'interval', [750 3500]});
[out, CSP_W] = func_csp(out,{'nPatterns', [4]});
out = func_featureExtraction(out, {'feature', 'logvar'});
end

