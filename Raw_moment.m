function [I] = Raw_moment(X,d) 
    [nrows,ncols,K] = size(X);

	if d >= min(nrows,ncols)
		error('window cant be bigger than the image');
		return
	end

	wind = 2*d+1;
	I = zeros(nrows+wind,ncols+wind,K');
	I(d+1:nrows+d,d+1:ncols+d,:) = X;

	% forming integral image
	I = cumsum(cumsum(I,1),2);
	% raw moment in terms of integral images
	I = I(wind:nrows+wind-1, wind:ncols+wind-1, :)-I(1:nrows, wind:ncols+wind-1, :)-I(wind:nrows+wind-1, 1:ncols, :)+I(1:nrows, 1:ncols, :);
	I = I/(wind*wind);

end