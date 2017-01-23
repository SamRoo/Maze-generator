%{
Maze generator -Sam Roo
Creates a spanning tree using a randomised version of Prim's algorithm 
Animation of generation causes a significant slowdown but looks fancy
%}

dim = 0;
while dim < 3
    dim = input('Enter a maze size (must be greater than 2): ');
end
if mod(dim, 2) == 0
    dim = dim + 1;
end
maze = zeros(dim, dim); % the maze walls are 0 values, passages are 1
row = 2;     % start point
col = 2; 
maze(2, 1) = 1;
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
    v = []; % create list of visited cells that maze(row,col)can connect to
    if (row-2 > 1)   && (maze(row-2, col) == 1); v = [v, [row-2; col]]; end
    if (row+2 < dim) && (maze(row+2, col) == 1); v = [v, [row+2; col]]; end
    if (col-2 > 1)   && (maze(row, col-2) == 1); v = [v, [row; col-2]]; end
    if (col+2 < dim) && (maze(row, col+2) == 1); v = [v, [row; col+2]]; end

    randPass = randi(size(v, 2));      
    vrow = v(1, randPass);  % selects a random visited cell from v
    vcol = v(2, randPass);  
                            % adds cell inbetween frontier cell and visited
    maze((row+vrow)/2, (col+vcol)/2) = 1;     
    imshow(maze,'InitialMagnification','fit'); % comment out for speed up
    maze(row,col) = 1;      % turns frontier cell into a passage
    drawnow; % comment out for speed up

    f(:,r) = [];            % remove the added cell from frontier
    f = updateFrontier(maze, f, row, col); 
end
maze(dim-1,dim) = 1;
imshow(maze,'InitialMagnification','fit'); 
drawnow;

function f = updateFrontier(maze, frontier, row, col)
    f = frontier;
    dim = size(maze,1);
    if (row-2 > 1)   && (maze(row-2, col) == 0); f = [f, [row-2; col]]; end
    if (row+2 < dim) && (maze(row+2, col) == 0); f = [f, [row+2; col]]; end
    if (col-2 > 1)   && (maze(row, col-2) == 0); f = [f, [row; col-2]]; end
    if (col+2 < dim) && (maze(row, col+2) == 0); f = [f, [row; col+2]]; end
end