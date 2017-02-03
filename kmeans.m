function [assignment,centers] = kmeans(X,k, centers = 0, maxIter = 20000)
  if(centers == 0)
    centerRows = randperm(size(X)(1));
    centers = X(centerRows(1:k),:);
  endif
  #centers
  numOfRows = length(X(:,1));
  numOfFeatures = length(X(1,:));
  assignment = ones(1,numOfRows);
  i=0;
  for iter = 1:maxIter
     clusterTotals = zeros(k,numOfFeatures);
     clusterSizes = zeros(k,1);
     for rowIx = 1:numOfRows
      minDist = realmax;
      assignTo = 0;
      for centerIx = 1:k
        #X(rowIx,:)
        #Scenters(centerIx,:)
        dist = sqrt(sum((X(rowIx,:)-centers(centerIx,:)).^2));
        if dist<minDist
          minDist = dist;
          assignTo = centerIx;
        endif
      endfor
      assignment(rowIx) = assignTo;
      clusterTotals(assignTo,:) += X(rowIx,:);
      clusterSizes(assignTo)++;
     endfor
     newCenters = zeros(k,numOfFeatures);
     for centerIx = 1:k
      newCenters(centerIx,:) = clusterTotals(centerIx,:)/clusterSizes(centerIx);
     endfor
     dif = sqrt(sum((newCenters-centers).^2))
     if dif<eps
      break;
     endif
     centers = newCenters;
     i++;
  endfor
  assignment= assignment';
  i
 endfunction