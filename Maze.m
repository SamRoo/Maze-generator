dim = input('Enter a maze size ');
% Creates the grid and sets all of the maze to walls
maze = ones(dim,dim); 

% Selects random starting point  
row = 2;  
col = 2;
maze(row,col) = 0;

% Creates the frontier 
global frontier; 
updateFrontier(maze, row, col); 

% While there is still maze frontier
while size(frontier,2) > 0 

    % Choose an unvisited element from the frontier
    r = randi(size(frontier,2));
    row = frontier(1,r);
    col = frontier(2,r);

    % If the frontier element has been visited remove it and repick
    if (maze(row,col) == 0) 
        frontier(:,r) = []; %the rth column
        continue;
    end

    % Create list of visited cells that the frontier f could connect to
    visited = [];
    % tries used in case new frontier cell is out of bounds
    try if (maze(row-2, col  ) == 0); visited = [visited, [row-2; col  ]];end;catch;end;
    try if (maze(row+2, col  ) == 0); visited = [visited, [row+2; col  ]];end;catch;end;
    try if (maze(row, col - 2) == 0); visited = [visited, [row; col - 2]];end;catch;end;
    try if (maze(row, col + 2) == 0); visited = [visited, [row; col + 2]];end;catch;end;

    % Select random passage      
    r = randi(size(visited,2));
    vrow = visited(1,r);
    vcol = visited(2,r);

    % Adds two new passages and updates figure twice       
    maze((row+vrow)/2, (col+vcol)/2) = 0;
    imshow(maze,'InitialMagnification','fit');
    drawnow;
    maze(row,col) = 0;
    drawnow;

    % Updates the frontier
    frontier(:,r) = [];
    updateFrontier(maze, row, col); 
end
clear

function f = updateFrontier(maze, row, col)
    % tries used in case new frontier cell is out of bounds
    try if (maze(row-2, col  ) == 1); f = [f, [row-2; col  ]];end;catch;end;
    try if (maze(row+2, col  ) == 1); f = [f, [row+2; col  ]];end;catch;end;
    try if (maze(row, col - 2) == 1); f = [f, [row; col - 2]];end;catch;end;
    try if (maze(row, col + 2) == 1); f = [f, [row; col + 2]];end;catch;end;
end