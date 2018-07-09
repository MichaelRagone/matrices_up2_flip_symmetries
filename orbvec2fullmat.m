

% takes in a vector whose elements range from 0, ... , num_orb_reps - 1 and
% converts it to a matrix
% - vector must have m*n elements. represents 1/4 of orig matrix, ignoring
%   center rows/cols
%   - if odd_rows or odd_cols, means the original matrix has 2m+1 or 2n+1
%   rows/cols, just leave -1's inside them.
% - last entry of vec = bottom right of bottom right corner of matrix
%   orb_reps:    [a b c d] = [a b
%                             c d]


function fullmat = orbvec2fullmat(orbvec, m, n, orb_reps, odd_rows, odd_cols)
%odd_rows = 0;
%odd_cols = 1;
%orb_reps = compute_orbit_reps(4);
%m = 2;
%n = 4;
%orbvec = [1 1 1 1 1 1 1 1]; %2*ones(m*n,1);

fullmat = -1*ones(2*m+odd_rows, 2*n+odd_cols);
vec_index = 1;

for i=1:m
    for j=1:n  
        % bottom right corner (c=3)
        fullmat(m+odd_rows+i, n+odd_cols+j) = orb_reps( orbvec(vec_index) , 3);
            
        % top right corner (b=2)
        fullmat(m-(i-1), n+odd_cols+j) = orb_reps( orbvec(vec_index) , 2); 
        
        % top left corner (a=1)
        fullmat(m-(i-1), n-(j-1)) = orb_reps( orbvec(vec_index) , 1);
        
        % bottom left corner (d=4)
        fullmat(m+odd_rows+i, n-(j-1)) = orb_reps( orbvec(vec_index) , 4);
        
        vec_index = vec_index + 1;
    end
end
           
end 
    
            
            
    
    