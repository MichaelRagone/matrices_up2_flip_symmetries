

% similar to compute_orbit_reps, but easier since only flip symmetries
% computes a bank of vectors such that no two are the same under flip


function orb_cent_reps = compute_orb_cent_reps(colors)

% just counting in base color
orb_cent_reps = zeros(colors^2, 2);
for i=0:colors^2-1
    str = dec2base(i, colors);
    if length(str) == 1
    	orb_cent_reps(i+1,:) = [0 str2num(str(1))];
    elseif length(str) == 2
        orb_cent_reps(i+1,:) = [str2num(str(1)) str2num(str(2))];       
    end
end

% now to kill off other orbit members, leaving only orbit reps
% yes I know the orbits are only of size 2, but I already had code
% trivially, id perm is already taken care of
i = 1;
while i < length(orb_cent_reps(:, 1))
  
    row = all(bsxfun(@eq, orb_cent_reps, fliplr(orb_cent_reps(i,:))), 2);
    row(1:i,:) = 0; % don't want to mess with previous/current stuff
    orb_cent_reps(row,:) = [];
    
    i = i+1;
end 
    

end
