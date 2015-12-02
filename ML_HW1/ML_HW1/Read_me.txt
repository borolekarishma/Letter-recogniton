****Algorithm****:


1. Take the first 150000 elements as training data and remaining 5000 as testing data
2. Repeat for k=1,3,5,7,9
	i. Randomly subsample the training data in samples of 100,1000,2000,5000,10000,150000
	ii. Repeat for each subsample
		a. Call the testknn function on the subsample
		b. Compute the time required to run the testknn algorithm
		c. Calculate the accuracy for the subsample
		d. Print the time and accuracy
3. Randomly subsample the training data in samples of 100,1000,2000,5000,10000,150000
4. Repeat for each subsample
	i. Call the condensedata function on subsample
	ii. Sample the training data with condensed data set
	iii. Repeat for k =1,3,5,7,9
		a. Call the testknn function on the subsample
		b. Compute the time required to run the testknn algorithm
		c. Calculate the accuracy for the subsample
		d. Print the time and accuracy
5. End

Testknn function:

1. Calculate euclidean distance of each testdata with each training data
2. For each test data
	a. Sort the distance to find the nearest neighbors
	b. Find the nearest k neighbors
	c. Take the element that is repeated maximum number of times
	d. Put that label in the temporary array
3. Return the temporary array of labels

Condensedata Function:

1. For each element in training set 
	i. Check with all the elements in training set
	ii. calculate euclidean distance
	iii. sort the distance to find the nearest neighbors  
	iv. If nearest neighbor has same label
		a. store the index of the data element
2. Update the original data set removing the outliers using the index vector created
3. Randomly pick a point from updated training set 
4. Add the point to new Training set
5. Repeat for each element in updated training set
	i. Check if the data element has same label as nearest neighbor
	ii. if false
		a. add the index of data element to a newindex vector
6.Return the newindex vector

	
****Confusion matrix****:

Confusion matrix is applied to thmplee 1-nn algorithm for 100 sas


****Experiments****:

The algorithm first runs on subsamples(100,1000,2000,5000,10000,150000) 
--for each subsample it runs the k-nn(k=1,3,5,7,9) algorithm.

Next it runs the condensed algorithm on subsamples(100,1000,2000,5000,10000,150000) 
--for each runs k-nn(k=1,3,5,7,9) algorithm.

The accuracy increases with the increase in number training samples
Running time also increases with the number of training samples.

	