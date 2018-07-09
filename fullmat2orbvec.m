

% converts a fullmat to an orbvec, which represents 1/4 of the original
% matrix
%  - not counting center rows/cols, which it throws out

function orbvec = fullmat2orbvec(fullmat, orb_reps)
%    orb_reps = compute_orbit_reps(5);
%    prev_orbvec = [0 0 0 0 0 0];
%    fullmat = orbvec2fullmat(prev_orbvec, 2, 3, orb_reps, 0, 1);
    
    
    % throw out the center col, if present
    if mod( length(fullmat(1,:)) , 2 ) == 1
        fullmat( :, floor(length(fullmat(1,:))/2) + 1) = [];
    end   
    % throw out the center row, if present   
    if mod( length(fullmat(:,1)) , 2 ) == 1
        fullmat( floor(length(fullmat(:,1))/2) + 1, : ) = [];
    end      
    
    m = length(fullmat(:,1))/2;
    n = length(fullmat(1,:))/2;
    
    orbvec = -1*ones(m*n, 1);
    vec_index = 1;
    
    for i=1:m
        for j=1:n
        
            % classify which orbit it is
            % [ a b c d ] = [a b 
            %                d c]
            %          a                                b                   c                   d        
            rep = [fullmat(m-(i-1), n-(j-1)), fullmat(m-(i-1), n+j), fullmat(m+i, n+j), fullmat(m+i, n-(j-1))];
            [C, ia, ib] = intersect(rep, orb_reps, 'rows');
            orbvec(vec_index) = ib;
            vec_index = vec_index + 1;
        end
    end
    

end 

