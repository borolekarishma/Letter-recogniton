function [ condensedIdx ] = condensedata( trainX, trainY )
% Condense 1NN algorithm
%   Detailed explanation goes here
index1 = [];
newIndex =[];

%get indices of the points that are not outliers 
for i = 1: length(trainX)
    tempX = trainX(i,:);    %check all the data elements one by one from the original data set
    dist = pdist2(trainX,tempX, 'euclidean'); %calculate euclidean distance
    
    [SortData Sortidx] = sort(dist); %sort the distance to find the nearest neighbors    
    
    if(strcmp(trainY(Sortidx(2)), trainY(i,1))) %compare the element with nearest neighbor
       index1 = [index1 i];
    end
end



%update the original data set removing the outliers
 UpdatedX = trainX(index1,:);
 UpdatedY = trainY(index1,:);

    n = randperm(length(UpdatedX));	%reandomly pick element from the updated training set
    newtrainX = UpdatedX(n(1), :);
    newtrainY = UpdatedY(n(1),1);
    newIndex = index1(n(1));
    for i = 2:length(n)
        x = n(i);
        tempX = trainX(x,:);    %check all the data elements in new one by one from the original data set
        tempY = trainY(x,1);
        if(length(newtrainX) == 1 )
            if(strcmp(newtrainY,tempY)==0)
                newIndex = [newIndex index1(x)];
                newtrainX = UpdatedX(newIndex,:);
                newtrainY = UpdatedY(newIndex,:);
            end       
        else
            dist = pdist2(newtrainX,tempX, 'euclidean'); %calculate euclidean distance
            [SortData Sortidx] = sort(dist); %sort the distance to find the nearest neighbors        

             if((strcmp(newtrainY(Sortidx(1)), tempY))==0) %compare the element with nearest neighbor
                newIndex = [newIndex index1(x)];	%add the index of the current data element if the label of it is not same as label of nearest neighbor
             end
        end
          
    end
    
  
condensedIdx = newIndex;	%return the vector of indices of new condensed data elements
end

