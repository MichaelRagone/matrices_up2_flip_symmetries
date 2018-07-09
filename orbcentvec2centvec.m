

% similar to orbvec2fullmat, but simpler since just a vector
% if odd, leave the middlemost piece alone

function cent_vec = orbcentvec2centvec(orb_cent_vec, orb_cent_reps, odd)

%orb_cent_vec = [1 2 5 7 3];
%odd = 1;
%orb_cent_reps = compute_orb_cent_reps(4);
 
    n = 2*length(orb_cent_vec)+odd;
    cent_vec = -1*ones( n, 1 );
    
    for i=1:length(orb_cent_vec)
 
        cent_vec(i) = orb_cent_reps( orb_cent_vec(i), 1); 
        cent_vec(n-(i-1)) = orb_cent_reps( orb_cent_vec(i), 2);
        
    end
    
 end


