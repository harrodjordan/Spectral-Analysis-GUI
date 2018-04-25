for i = 1:length(matfile_prop)
    structure = struct('data', matfile_prop{i, 1}, 'trial_info', matfile_prop{i, 3});
    save(strcat('PROP_', strtok(matfile_prop{i, 2}, '.')), 'structure')
end