fname= 'lenapng.png';
[im,map] = imread(fname);
%find number of rows and columns in the image
[N,M]=size(im);


% percentage of noise (salt & pepper)  to add into the input image 
noisep =90 /100; 
nim=imnoise(im,'salt & pepper',noisep);

% initialize denoised image matrix with zeros elements
dim=zeros(M,N);
o=1;
p=1;
k=1;l=1;u=1;h=1;
q=1;j=1;

% set maximum median filter window size
wsmax=9; 
f=1;

if(noisep<=0.95)
    wsmax  = 9;
else
    wsmax=13;
end

for m=1 : M
    
  for n=1 : N  

    % set minimum median filter window size
    ws =3; 
    
    
    if(m==1 && n==1)
        prev = 0;
    end
   % while ( ws <= wsmax )
     
      %  neighbouring subscripts of centre pixel           
     hws = floor(ws/2);
     [J,I]=meshgrid(n-hws:n+hws ,m-hws:m+hws);
     I=I(:); J=J(:);          

      % exclude subscripts out of border of the image 
      if ( m<=hws || n<=hws || m>=M-hws || n>=N-hws)        
            s =(I>=1 & I<=M);
            I=I(s); J=J(s);      
            s =(J>=1 & J<=M);
            I=I(s); J=J(s);       
      end      

     %  converts neighbouring subscripts index  
      ind = sub2ind([M,N],I,J);          
       
     %  minimum of neighbouring pixels  
      %S1 = min ( nim(ind)  ) ;
     %  median of neighbouring pixels  
      %S2 =  median ( nim(ind)  );
     %  maximum of neighbouring pixels  
      %S3 =  max( nim(ind) );
      
      
      
     [matt, mm,meanmatlab]  = matlab(nim(ind)) ;
      
      
      if(nim(m,n)>0&&nim(m,n)<255)
          dim(m,n) = nim(m,n);
          f=f+1; 
         
         
       elseif ( mm>=ws )
           
           dim(m,n) = matt;
           u=u+1;
           
           
           
           
         else  
           % increment  median filter window size by 2 
           
           if(ws<wsmax )
               
               
               
               while(ws<wsmax)
                    
                    hws = floor(ws/2);
                     [J,I]=meshgrid(n-hws:n+hws ,m-hws:m+hws);
                     I=I(:); J=J(:);          

                      % exclude subscripts out of border of the image 
                      if ( m<=hws || n<=hws || m>=M-hws || n>=N-hws)        
                            s =(I>=1 & I<=M);
                            I=I(s); J=J(s);      
                            s =(J>=1 & J<=M);
                            I=I(s); J=J(s);       
                      end      

                     %  converts neighbouring subscripts index  
                     ind = sub2ind([M,N],I,J);
                     
                     [matt, mm,meanmatlab]  = matlab(nim(ind)) ;
                     if(ws<wsmax &&mm>=ws)
                       dim(m,n) = matt;
                       h=h+1;
                       break;
                     end
                     ws =ws+2;
                     
                     
               end
           
               
           end
      end
                    
                        
                   
               
               
                if(ws==wsmax)
                    
              
                          hws = floor(ws/2);
                     [J,I]=meshgrid(n-hws:n+hws ,m-hws:m+hws);
                     I=I(:); J=J(:);          

                      % exclude subscripts out of border of the image 
                      if ( m<=hws || n<=hws || m>=M-hws || n>=N-hws)        
                            s =(I>=1 & I<=M);
                            I=I(s); J=J(s);      
                            s =(J>=1 & J<=M);
                            I=I(s); J=J(s);       
                      end      

                     %  converts neighbouring subscripts index  
                     ind = sub2ind([M,N],I,J);
                     
                     [matt, mm,meanmatlab]  = matlab(nim(ind)) ;
               ll = length(nim(ind));
               arr1 = nim(ind);
             
                end
           
               
              if(ws == wsmax & mm<ws && mm~=0)
               dim(m,n) = meanmatlab;
              
               k=k+1;
               
             
             
                   
                   
                   
                   
                       
                       
               
               
               
               
              
           
               
               
                   
              elseif(ws==wsmax & (arr1==0))
               dim(m,n) = 255;
              
               l=l+1;
               
           
                elseif(ws==wsmax & (arr1==255))
               dim(m,n) = 0;
               
               j=j+1;
               
           
                 elseif( ws==wsmax & (arr1==0 |arr1==255))
               dim(m,n) = mean(nim(ind)) ;
               o=o+1;
               
                else
                  dim(m,n)=matt;
                  q=q+1;
               
               
           
           
            
            
            
            
            
               
               
                   end
  
       
       
       
             
      end
   end


 function [medmatlab,countt,meanmatlab]  =  matlab(arr)
    
    % countt = 0;
    % countt1 = 0;
%      countt2 = 0;
%      countt3 = 0;
     mat = [];
     
     mat =  arr(arr>0 & arr<255);
     countt =  length(mat);
    
%    for v = 1:length(arr)
%      if(arr(v)>0 && arr(v)<255)
%        countt = countt+1;
%        mat(r) = arr(v);
%        r=r+1;
%      end 
%      if(arr(v)==0 || arr(v)==255)
%          countt1 = countt1+1;
%      end
% %      if(arr(v)==0)
% %          countt2 = countt2+1;
% %      end
% %      if(arr(v)==255)
% %          countt3 = countt3+1;
% %      end
%      
%    end
    
    
   
   
     medmatlab  =median(mat);
     meanmatlab  =mean(mat);
     
     
      
%      if(countt2==length(arr))
%          mean2  = 255;
%      elseif(countt3 ==length(arr))
%          mean3 = 0;
%      else
%          mean1  = mean(arr);
%      end    
     
  
     %medmatlab  = 1000;
   
   
   end