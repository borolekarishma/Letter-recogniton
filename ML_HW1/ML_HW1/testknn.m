function [ testY ] = testknn( trainX, trainY, testX, k )
%k-Nearest neighbor algorithm
%   Detailed explanation goes here
tY = cell(5000,1);
temp = cell(k,1);

%calculate euclidean distance of each testdata with each training data
dist = pdist2(trainX,testX, 'euclidean');

for i = 1:5000  %for each test data 
    [SortData Sortidx] = sort(dist(:,i)); %sort the distance to find the nearest neighbors 

    for j = 1:k     %find the nearest k neighbors
      temp(j,1) = trainY(Sortidx(j));
    end
  
   
   unique_label = unique(temp); %find unique elements from k nearest neighbors
   freq = zeros(length(unique_label), 1);
   
   %find the # times the elements are repeated
   for l = 1:length(unique_label)
        freq(l) = length(find(strcmp(unique_label{l}, temp)));
   end
   [~,temp1] = max(freq); %take the element that is repeated maximum # of times
   tY(i,1) = unique_label(temp1);   %put that label in tY for ith test set
end
testY = tY;
end

