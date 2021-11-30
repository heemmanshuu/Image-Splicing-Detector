function sigmas = logic(im)
    

    filter_size = 4;
    block_radius = 8;
    
    chans = Transformer(im, filter_size);
    
    % equation 6 starts
    
    % raw moment arrays
    
    u1 = Raw_moment(chans,block_radius);
    u2 = Raw_moment(chans.^2,block_radius);
    u3 = Raw_moment(chans.^3,block_radius);
    u4 = Raw_moment(chans.^4,block_radius);
    
    % sigma_k and K_k for each pixel per channel
    sigmaksq = u2 - u1.^2;
    kks = (u4 - 4*u3.*u1 + 6*u2.*u1.^2 - 3*u1.^4)./(u2.^2 - 2*u2.*u1.^2 + u1.^4)-3; 
    kks = max(0,kks);  % added to remove error (K_k should be +ve)
    
    % equation 6 ends
    
    % equation 4 starts
    a = mean(sqrt(kks),3);
    b = mean(1./sigmaksq,3);
    c = mean(1./sigmaksq.^2,3);
    d = mean(sqrt(kks)./sigmaksq,3);
    
    kurt = (a.*c - b.*d)./(c-b.*b);
    sigmas = (1 - a./kurt)./b; 
    
    idx = kurt<a;
    sigmas(idx) = 1./b(idx);
    idx = sigmas<0;
    sigmas(idx) = 1./b(idx);
    
    


