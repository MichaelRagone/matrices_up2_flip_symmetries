% compute bank of orbit representatives
%    - Each matrix can flip around either axis (perm group of size 4)
%    - Compute every possible matrix then kill off symmetries
% [ a  b   = [a b c d]
%   d  c ]    
%  colors: named 0, ..., colors-1
function orbit_reps = compute_orbit_reps(colors)

% my group
% (if you want to add rotations, write them here and add them to the while loop 
flip_vert = [0 0 0 1; 
             0 0 1 0; 
             0 1 0 0; 
             1 0 0 0];

flip_horiz= [0 1 0 0;
             1 0 0 0;
             0 0 0 1;
             0 0 1 0];

flip_both = flip_vert*flip_horiz;


% just counting in base color
orbit_reps = zeros(colors^4, 4);
for i=0:colors^4-1
    str = dec2base(i, colors);
    if length(str) == 1
    	orbit_reps(i+1,:) = [0 0 0 str2num(str(1))];
    elseif length(str) == 2
        orbit_reps(i+1,:) = [0 0 str2num(str(1)) str2num(str(2))];
    elseif length(str) == 3
        orbit_reps(i+1,:) = [0 str2num(str(1)) str2num(str(2)) str2num(str(3))];                
    elseif length(str) == 4
        orbit_reps(i+1,:) = [str2num(str(1)) str2num(str(2)) str2num(str(3)) str2num(str(4))];         
    end
end

% now to kill off other orbit members, leaving only orbit reps
% trivially, id perm is already taken care of
i = 1;
while i < length(orbit_reps(:, 1))
  
    % vertical flip
    row = all(bsxfun(@eq, orbit_reps, orbit_reps(i,:)*flip_vert), 2);
    row(1:i,:) = 0; % don't want to mess with previous/current stuff
    orbit_reps(row,:) = [];
 
    % horizontal flip
    row = all(bsxfun(@eq, orbit_reps, orbit_reps(i,:)*flip_horiz), 2);
    row(1:i,:) = 0;
    orbit_reps(row,:) = [];   
   
    % double flip
    row = all(bsxfun(@eq, orbit_reps, orbit_reps(i,:)*flip_both), 2);
    row(1:i,:) = 0;
    orbit_reps(row,:) = [];
    
    i = i+1;
end 
    

end
    
    
    
    
    
    
    


