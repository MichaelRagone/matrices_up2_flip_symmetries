% Main Code

% Input: 
%   - desired_num: how many matrices would you like?
%   - colors: entries of these matrices range from 0 to colors-1
%     - note: only supports colors from 2 to 10. If you want to change
%     that, look at compute_orbit_reps.m and compute_orb_cent_reps.m and
%     change from dec2base. I recommend base2base: https://www.mathworks.com/matlabcentral/fileexchange/58850-base2base-nstart-bstart-bend-
%   - in_mat: previous rows x cols matrix generated.
%     - note: the trick for this enumeration is a total ordering. If you
%     want to start later in the enumeration, input a different matrix.
% Output: 
%   - out_mat: rows x cols x desired num matrix 

desired_num = 500;
colors = 2;
rows = 6;
cols = 3;
in_mat = zeros(rows,cols); %can be started at any valid matrix, just make sure rows and cols match

% given that we only care about horizontal and vertical flips,
% we can choose corners on "rectangles" in the matrix independently.
% So all we need to do is create a bank of orbit representatives for the
% rectangle flip permutation group for an arbitrary rectangle, then iterate
% through every set of rectangles and exhaust the orbit reps


orb_reps = compute_orbit_reps(colors);
num_orb_reps = length(orb_reps(:,1));

row_end = floor(rows/2);
col_end = floor(cols/2);

out_mat = -1*ones(rows, cols, desired_num);

% it's easier to keep track of 1/4 (bottom right) of the matrix and count
% up with that as a vector.

% center lines are fixed by symmetries, treat separately
% counting starting from bottom right.
%  - Once a whole quarter of the matrix has every element = num_orb_reps -
%    1, then update the center lines. In this way we can better
%    compartmentalize.

if (mod(rows, 2) == 0) && (mod(cols,2) == 0)
    
    orbvec = fullmat2orbvec(in_mat, orb_reps);
    
    for i=1:desired_num
        
        j = 1;
        odometer_flag = 1;
       
        % increment by counting in base num_orb_reps, like an odometer
        while odometer_flag == 1
            if orbvec(j) == num_orb_reps
                orbvec(j) = 1;
                j = j + 1;
            else 
                orbvec(j) = orbvec(j) + 1;
                odometer_flag = 0;
            end
        end
            
        % now store this wonderful new matrix. Easy here because even rows and cols             
        out_mat(:,:,i) = orbvec2fullmat(orbvec, row_end, col_end, orb_reps, 0, 0);
    
    end
    
    
end


if (mod(rows, 2) == 1) && (mod(cols,2) == 0)
    
    orb_cent_reps = compute_orb_cent_reps(colors);
    
    orbvec = fullmat2orbvec(in_mat, orb_reps);
    max_orbvec = length(orb_reps(:,1)) * ones(length(orbvec), 1); % speedier to precompute
    
    % even number of columns, so length(cent_row) is even
    cent_row = in_mat(row_end+1,:);
    orb_cent_vec = centvec2orbcentvec(cent_row, orb_cent_reps);

    for i=1:desired_num
        
        j = 1;
        odometer_flag = 1;
       
        % increment by counting in base num_orb_reps, like an odometer
        % first the orbvec, then the center
        if orbvec == max_orbvec
            orbvec = ones(length(orbvec), 1);
            while odometer_flag == 1
                if orb_cent_vec(j) == length(orb_cent_reps(:,1))  % note that the center stores orbcentreps, not orbreps
                    orb_cent_vec(j) = 1;
                    j = j + 1;
                else 
                    orb_cent_vec(j) = orb_cent_vec(j) + 1;
                    odometer_flag = 0;
                end
             end  
        % updating orbvec
        else 
            while odometer_flag == 1
                if orbvec(j) == num_orb_reps
                    orbvec(j) = 1;
                    j = j + 1;
                else 
                    orbvec(j) = orbvec(j) + 1;
                    odometer_flag = 0;
                end
            end
        end
        
        % stitch the matrix back together and save           
        out_mat(:,:,i) = orbvec2fullmat(orbvec, row_end, col_end, orb_reps, 1, 0);
        out_mat(row_end+1,:,i) = orbcentvec2centvec(orb_cent_vec, orb_cent_reps, 0);
    
    end
    
end


if (mod(rows, 2) == 0) && (mod(cols,2) == 1)

    orb_cent_reps = compute_orb_cent_reps(colors);
    
    orbvec = fullmat2orbvec(in_mat, orb_reps);
    max_orbvec = length(orb_reps(:,1)) * ones(length(orbvec), 1); % speedier to precompute
    
    % even number of rows, so length(cent_col) is even
    cent_col = in_mat(:,col_end+1);
    orb_cent_vec = centvec2orbcentvec(cent_col, orb_cent_reps);

    for i=1:desired_num
        
        j = 1;
        odometer_flag = 1;
       
        % increment by counting in base num_orb_reps, like an odometer
        % first the orbvec, then the center
        if orbvec == max_orbvec
            orbvec = ones(length(orbvec), 1);
            while odometer_flag == 1
                if orb_cent_vec(j) == length(orb_cent_reps(:,1))  % note that the center stores orbcentreps, not orbreps
                    orb_cent_vec(j) = 1;
                    j = j + 1;
                else 
                    orb_cent_vec(j) = orb_cent_vec(j) + 1;
                    odometer_flag = 0;
                end
             end  
        % updating orbvec
        else 
            while odometer_flag == 1
                if orbvec(j) == num_orb_reps
                    orbvec(j) = 1;
                    j = j + 1;
                else 
                    orbvec(j) = orbvec(j) + 1;
                    odometer_flag = 0;
                end
            end
        end
        
        % stitch the matrix back together and save           
        out_mat(:,:,i) = orbvec2fullmat(orbvec, row_end, col_end, orb_reps, 0, 1);
        out_mat(:,col_end+1,i) = orbcentvec2centvec(orb_cent_vec, orb_cent_reps, 0);
    
    end
    
end


if (mod(rows, 2) == 1) && (mod(cols,2) == 1)
    
    orb_cent_reps = compute_orb_cent_reps(colors);
      
    cent_row = in_mat(row_end+1,:); 
    cent_col = in_mat(:,col_end+1);
    cent_elt = cent_row(col_end+1); % treat center element on own
    orb_cent_row = centvec2orbcentvec(cent_row, orb_cent_reps);
    orb_cent_col = centvec2orbcentvec(cent_col, orb_cent_reps);
    
    max_orb_cent_row = length(orb_cent_reps(:,1)) * ones(1, length(orb_cent_row)); % speedier to precompute
    max_orb_cent_col = length(orb_cent_reps(:,1)) * ones(length(orb_cent_row), 1);

    
    orbvec = fullmat2orbvec(in_mat, orb_reps);
    max_orbvec = length(orb_reps(:,1)) * ones(length(orbvec), 1); % speedier to precompute

    for i=1:desired_num
        
        j = 1;
        odometer_flag = 1;
       
        % increment by counting in base num_orb_reps, like an odometer
        % first the orbvec, then center row, then center col, then center elt 
        if orbvec == max_orbvec
            orbvec = ones(length(orbvec), 1);
            
            % fill rows after orbvec
            if orb_cent_row == max_orb_cent_row
                orb_cent_row = ones(1, length(orb_cent_row));   
                
                % cols                
                if orb_cent_col == max_orb_cent_col
                    orb_cent_col = ones(length(orb_cent_col), 1);

                    % center
                    if cent_elt >= colors %wow that's a lot
                        error('Desired num is greater than number of possible matrices: terminating.');
                    else
                        cent_elt = cent_elt + 1;
                    end
                else 
                    while odometer_flag == 1
                        if orb_cent_col(j) == length(orb_cent_reps(:,1)) 
                            orb_cent_col(j) = 1;
                            j = j + 1;
                        else
                            orb_cent_col(j) = orb_cent_col(j) + 1;
                            odometer_flag = 0;
                        end
                    end 
                end
                
            else
                while odometer_flag == 1
                    if orb_cent_row(j) == length(orb_cent_reps(:,1))
                        orb_cent_row(j) = 1;
                        j = j + 1;
                    else 
                        orb_cent_row(j) = orb_cent_row(j) + 1;
                        odometer_flag = 0;
                    end
                end
            end    
        % updating orbvec
        else 
            while odometer_flag == 1
                if orbvec(j) == num_orb_reps
                    orbvec(j) = 1;
                    j = j + 1;
                else 
                    orbvec(j) = orbvec(j) + 1;
                    odometer_flag = 0;
                end
            end
        end

        % stitch the matrix back together and save. Put center elt on last        
        out_mat(:,:,i) = orbvec2fullmat(orbvec, row_end, col_end, orb_reps, 1, 1);
        out_mat(:,col_end+1,i) = orbcentvec2centvec(orb_cent_col, orb_cent_reps, 1);
        out_mat(row_end+1,:,i) = orbcentvec2centvec(orb_cent_row, orb_cent_reps, 1)';
        out_mat(row_end+1, col_end+1, i) = cent_elt;
        
    
    end
    
end

 
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    


