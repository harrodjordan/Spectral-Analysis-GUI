figure;

% gridlines ---------------------------
g_y=[.85, 9.85]; % user defined grid Y [start:spaces:end]
g_y= 0:2:10000; % user defined grid X [start:spaces:end]
for i=1:length(g_y)
   plot([g_x(1) g_x(end)],[g_y(i) g_y(i)],'black:',...
       'LineWidth', 1.5) %x grid lines
   hold on    
end