%{
Maze generator
Creates the maze by creating a random spanning tree using a randomised 
version of Prim's algorithm 
Animation of generation causes a significant slowdown
%}

dim = 0;
while dim < 3
    dim = input('Enter a maze size (must be greater than 2): ');
end
maze = zeros(dim,dim);  % the maze walls are 0 values, passages are 1
maze(2,1)     = 1;
row = 2;  col = 2;      % start point
maze(row,col) = 1;
f = [];                 % creates the frontier 
f = updateFrontier(maze, f, row, col); 

while size(f,2) > 0     % while there is still maze frontier
    r = randi(size(f,2));   % choose an unvisited element from the frontier
    row = f(1,r);
    col = f(2,r);
    if (maze(row,col) == 1) % if cell has been visited (duplicate)
        f(:,r) = [];            % removes the it from frontier
        continue;               % skips iteration to choose another cell
    end
    passages = [];          % create list of cells that the frontier could connect to
    try if (maze(row-2, col  ) == 1); passages = [passages, [row-2; col  ]];end;catch;end
    try if (maze(row+2, col  ) == 1); passages = [passages, [row+2; col  ]];end;catch;end
    try if (maze(row, col - 2) == 1); passages = [passages, [row; col - 2]];end;catch;end
    try if (maze(row, col + 2) == 1); passages = [passages, [row; col + 2]];end;catch;end

    randPass = randi(size(passages, 2));     % select random passage      
    vrow = passages(1, randPass);
    vcol = passages(2, randPass);

    maze((row+vrow)/2, (col+vcol)/2) = 1;    % creates intermediate passage 
    imshow(maze,'InitialMagnification','fit');   % comment out for speed up
    maze(row,col) = 1;      % creates passage
    drawnow;                % comment out for speed up

    f(:,r) = [];            % remove the added cell from frontier
    f = updateFrontier(maze, f, row, col); 
end

maze(dim-1,dim) = 1;
imshow(maze,'InitialMagnification','fit'); 
drawnow;

function f = updateFrontier(maze, frontier, row, col)
    f = frontier;
    try if (maze(row-2, col  ) == 0); f = [f, [row-2; col  ]];end;catch;end
    try if (maze(row+2, col  ) == 0); f = [f, [row+2; col  ]];end;catch;end
    try if (maze(row, col - 2) == 0); f = [f, [row; col - 2]];end;catch;end
    try if (maze(row, col + 2) == 0); f = [f, [row; col + 2]];end;catch;end
end