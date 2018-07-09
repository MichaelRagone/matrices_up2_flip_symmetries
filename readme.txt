
Author: Michael Ragone, 2018. University of Arizona
Email: micragone (at) gmail (dot) com
Main script: generate_matrices.m
Purpose: 
    A fun little project I did for my abstract algebra course (Dr. Klaus
    Lux) and later applied to my final project in Digital Communications
    (Dr. Ivan Djordjevic). Thanks to Dr. Bane Vasic for the idea.
    
    Creates desired_num rows x cols matrices with elements ranging from
    0,...,colors-1 such that no two matrices are identical under:
     - horizontal flip
     - vertical flip
     - horizontal + vertical flip (which is the same as vert+horiz flip)

    Effectively just counts up from prev_mat, skipping matrices that are
    already covered previously
     - note that these matrices are ordered--so if you plug in a high enough
       number, it will skip symmetries of those previous, even though it
       didn't generate them
   
    Later discovered that this idea has already been investigated in
    greater generality. Check out this cool paper by Nicolas Borie:
    https://hal.inria.fr/hal-01229658/document 

If you want a write-up, see Part 1 of my final project:
https://docs.google.com/document/d/12ysJBfYfIYfHD7FdlKfyhNS9s9WYlpjken4VI_MjyXs/edit?usp=sharing
This software was inspired by a class of codes called Quasi-Cyclic 
Low-Density Parity Check (QC-LDPC) codes, which have some very nice properties.
Part 2 was more just playing around to see if this algorithm could be useful
for enumerating QC-LDPC codes--while I knew that many of the matrices generated
would not be full-rank, I was curious if they could be made into useful codes 
all the same. I don't think they can, so I would skip Part 2 if I were you.
