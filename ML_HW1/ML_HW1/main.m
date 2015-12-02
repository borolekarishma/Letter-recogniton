fileName = 'letter.data';
D = importdata(fileName);
nTrain = 15000;
nTest = 5000;

trainX = D.data(1:15000, 1:16); %First 15000 data set for training data 
trainY = D.textdata(1:15000, 1); %First 15000 labels for training data
testX = D.data(15001:20000, 1:16); %Last 5000 data set for testing data
testY = cell(5000,0); 
testY = [testY D.textdata(15001:20000, 1)]; %output label for last 5000 testing data


fprintf('\n****K-NN algorithm:****');
for s = [100, 1000, 2000, 5000, 10000, 15000] %for loop for each subsample
    fprintf('\n\nOutput using %d subsamples:',s);
    for k = [1,3,5,7,9]                         %for loop for k-nn
        
         time = cputime;
         [subsampleX index] = datasample(trainX, s);	%sample the training data in s subsamples 
         subsampleY = trainY(index);
         testk =  testknn(subsampleX, subsampleY, testX, k); %call testknn function 
         time = cputime-time;				%calculate the time required to run k-nn algorithm
         if(k==1 && s==100)
            fprintf('\nConfusion matrix for 1-NN using 100 samples:');
            Confusion_matrix = confusionmat(testY(:,1), testk(:,1))
         end
         acc = (sum(strcmp(testY(:,1), testk))/5000)*100; %calculate accuracy for each testY vector
         fprintf('\n\nAccuracy for %d-NN algorithm = %f',k,acc);
         fprintf('\nTime required for %d-NN algorithm = %f',k,time);
         testY = [testY testk];
    end
    
end
fprintf('\n\n****Condensed 1-NN:****');
for s = [100, 1000, 2000, 5000, 10000, 15000] %for loop for each subsample
    
    [subsampleX index] = datasample(trainX, s);		%sample the training data in s subsamples 
    subsampleY = trainY(index);
    idx = condensedata(subsampleX, subsampleY);		%call the condensedata function on the subsampled data set
    index = index(1,idx);
    subsampleX = trainX(index,:);					%sample the training data with condensed data set
    subsampleY = trainY(index,:);
    condensed_data = length(idx);
    fprintf('\n\nUsing %d subsample:',s);
    for k = [1,3,5,7,9]    %for loop for k-nn
        time = cputime;
        %call the testknn function on the condensed data set
        testk =  testknn(subsampleX, subsampleY, testX, k); 
        time = cputime-time;				%calculate the time required to run k-nn algorithm
        acc = (sum(strcmp(testY(:,1), testk))/5000)*100; %calculate accuracy for each testY vector
        fprintf('\n\nAccuracy for %d-nn algorithm  = %f',k,acc);
        fprintf('\nTime required for %d-nn algorithm = %f',k,time);
    end
end
