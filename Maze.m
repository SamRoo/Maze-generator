function Maze(dimension)
    
    global dim;
    dim = dimension;
    
    % Creates the grid and sets all of the maze to walls
    global a; 
    a = ones(dim,dim); 
    
    % Selects random starting point  
    row = 2; %randi(dim); 
    col = 2; %randi(dim);
    a(row,col) = 0;
    
    % Creates the frontier 
    global frontier; 
    frontier = [];
    updateFrontier(row, col); 
    
    % While there is still a frontier
    while size(frontier,2) > 0 
        % Choose an unvisited element from the frontier
        r = randi(size(frontier,2));
        row = frontier(1,r);
        col = frontier(2,r);
        
        % If the frontier element has been visited remove it and repick
        if a(row,col) == 0 
            frontier(:,r) = [];
            continue;
        end
        
        % Create list of nearest passages
        passages = [];
        if (row - 2 > 0) && (a(row - 2, col) == 0)
            passages = [passages, [row - 2; col]];
        end
        if (row + 2 <= dim) && (a(row + 2, col) == 0)
            passages = [passages, [row + 2; col]];
        end
        if (col - 2 > 0) && (a(row, col - 2) == 0)
            passages = [passages, [row; col - 2]];
        end
        if ((col + 2 <= dim) && (a(row, col + 2) == 0))
            passages = [passages, [row; col + 2]];
        end
        
        % Select random passage      
        r = randi(size(passages,2));
        prow = passages(1,r);
        pcol = passages(2,r);
        
        % Adds two new passages and updates figure twice
        if col > pcol
            x = pcol + 1;
            y = prow;
        elseif col < pcol
            x = pcol - 1;
            y = prow;
        elseif row > prow
            x = pcol;
            y = prow + 1;
        else
            x = pcol;
            y = prow - 1;
        end
        a(y, x) = 0;
        imshow(a,'InitialMagnification','fit');
        drawnow;
        a(row,col) = 0;
        
        drawnow;
        
        % Updates the frontier
        frontier(:,r) = [];
        updateFrontier(row, col); 
    end
end


function updateFrontier(row, col)
    global a;
    global dim;
    global frontier;
    if (row - 2 > 0) && (a(row - 2, col) == 1)
        frontier = [frontier, [row - 2; col]];
    end
    if (row + 2 < dim) && (a(row + 2, col) == 1)
        frontier = [frontier, [row + 2; col]];
    end
    if (col - 2 > 0) && (a(row, col - 2) == 1)
        frontier = [frontier, [row; col - 2]];
    end
    if ((col + 2 < dim) && (a(row, col + 2) == 1))
        frontier = [frontier, [row; col + 2]];
    end
end