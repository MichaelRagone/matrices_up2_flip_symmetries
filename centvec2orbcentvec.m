

% similar to fullmat2orbvec, but simpler since just a vector
% if odd, throw away the middlemost piece

function orb_cent_vec = centvec2orbcentvec(centvec, orb_cent_reps)
    %orb_cent_reps = compute_orb_cent_reps(5);
    %prev_orbcentvec = [1 10];
    %centvec = orbcentvec2centvec(prev_orbcentvec, orb_cent_reps, 1);
    
    
    % throw out the center element, if present
    if mod( length(centvec) , 2 ) == 1
        centvec( floor(length(centvec)/2) + 1 ) = [];
    end       
    
    n = length(centvec);
    
    orb_cent_vec = -1*ones(n/2, 1);
    
    for i=1:(n/2)

        % classify which orbit it is   
        rep = [centvec(i) centvec(n-(i-1))];
        [C, ia, ib] = intersect(rep, orb_cent_reps, 'rows');
        orb_cent_vec(i) = ib;
    end
    
end 