clear

fname= 'lenapng.png';
[im,map] = imread(fname);
    
[N,M]=size(im);

globarray = [];
y=1;
t=1;
k=1;
o =1;
as =1;
u=1;

noisep =95/100; 
nim=imnoise(im,'salt & pepper',noisep);


dim=zeros(M,N);
ws =11;


wsmax=5;
zz = [];

for m=1 : M
  
  for n=1 : N  

    
     
      if(m==1 && n==1)
          prev = 0;
      end    
      %zz(u) = nim(m,n)
      [min3,med3,max3]  =window(3,m,n,M,N,nim);
      [min5,med5,max5]  =window(5,m,n,M,N,nim);
      
      
      if(nim(m,n)>0 && nim(m,n)<255)
          dim(m,n) = nim(m,n);
          
          
          
       
      elseif ( min3<med3 && med3<max3 && min3>0 && min5<255 )
           
                  
                    dim(m,n) = med3;
                    u= u+1;         
           
                   
          
           
           
       elseif ( min5<med5 && med5<max5 && min5<0 && max5<255 )  
                  
            
           
               %if ( nim(m,n)>min5 && nim(m,n)<max5 ) 
                    % dim(m,n) = nim(m,n);                
              % else
                    dim(m,n) = med5;
                    t= t+1;
                    
                 % medmatlab2 = window2(ws,m,n,M,N,nim);
                    
               %end
           
              
      else
         if(noisep<=0.90)
             ws=7;
         else
             ws=11;
         end
         
              
           [medmatlab,medmatlab1] = window1(ws,m,n,M,N,nim);
           %medmatlab2 = window2(ws,m,n,M,N,nim);
           if(medmatlab~= 1000)
              % disp(medmatlab);
               %globarray(y) = medmatlab2;
               y= y+1;
               
               
            
               dim(m,n)= medmatlab;
               
          %elseif(medmatlab2~=1000)
             % dim(m,n)  = medmatlab2;
              % k = k+1;
           else
               
               
               dim(m,n) = prev;
               o = o+1;
           end
           
           
          
           
             
       end
       prev = dim(m,n);
       
    
  end
end
  

 
   function [S1,S2,S3] = window(ws,m,n,M,N,nim)
     
              
         hws = floor(ws/2);
         [J,I]=meshgrid(n-hws:n+hws ,m-hws:m+hws);
         I=I(:); J=J(:);          

          if ( m<=hws || n<=hws || m>=M-hws || n>=N-hws)        
                s =(I>=1 & I<=M);
                I=I(s); J=J(s);      
                s =(J>=1 & J<=M);
                I=I(s); J=J(s);       
          end      

         
          ind = sub2ind([M,N],I,J);          

         
          S1 = min ( nim(ind)  ) ;
          
          S2 =  median ( nim(ind)  );
         
          S3 =  max( nim(ind) );
   end
     
    function [medmatlab,medmatlab1] = window1(ws,m,n,M,N,nim)
     
             
         hws = floor(ws/2);
         [J,I]=meshgrid(n-hws:n+hws ,m-hws:m+hws);
         I=I(:); J=J(:);          

          
          if ( m<=hws || n<=hws || m>=M-hws || n>=N-hws)        
                s =(I>=1 & I<=M);
                I=I(s); J=J(s);      
                s =(J>=1 & J<=M);
                I=I(s); J=J(s);       
          end      

          
          ind = sub2ind([M,N],I,J);          

          
        
         r = 1;
    countt = 0;
    mat = [];  
    arr = nim(ind);
          
     for v = 1:length(nim(ind))
         if(arr(v)>0 && arr(v)<255)
           countt = countt+1;
           mat(r) = arr(v);
           r=r+1;

         end
      end

       if(countt>=1)
             
           if(mod(countt,2)==1)
                 medmatlab  =median(mat);
           else 
               bb = sort(mat);

               medmatlab = bb(countt/2);
           end
     
        
        medmatlab1= 0;

       else
         medmatlab  = 1000;
         medmatlab1 = median(mat);


       end

    end

    function medmatlab = window2(ws,m,n,M,N,nim)
     
                 
         hws = floor(ws/2);
         [J,I]=meshgrid(n-hws:n+hws ,m-hws:m+hws);
         I=I(:); J=J(:);          

         
          if ( m<=hws || n<=hws || m>=M-hws || n>=N-hws)        
                s =(I>=1 & I<=M);
                I=I(s); J=J(s);      
                s =(J>=1 & J<=M);
                I=I(s); J=J(s);       
          end      

         
          ind = sub2ind([M,N],I,J);          

         
        
           r = 1;
    countt = 0;
    mat = [];  
    arr = nim(ind);
          
   for v = 1:length(arr)
     if(arr(v)>0 && arr(v)<255)
       countt = countt+1;
       mat(r) = arr(v);
       r=r+1;
        
     end
    end
   
   if(countt>=3)
       if(mod(countt,2)==1)
             medmatlab  =median(mat);
       else 
           bb = sort(mat);
           
           medmatlab = bb(countt/2);
       end
     
   else
     medmatlab  = 1000;
   
   
   end
   

       
      

       end
    
      
