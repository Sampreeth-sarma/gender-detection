function g=eye_to_eye(IFaces,bboxes)
 for i = 1:size(bboxes,1)
  
     J= imcrop(IFaces,bboxes(i,:));
     
    eye=vision.CascadeObjectDetector('RightEye');
   eye.MergeThreshold=0;
    while(1)
    eyeMat=step(eye,J);
    if size(eyeMat,1)>2
        eye.MergeThreshold=eye.MergeThreshold+3;
    end
    if size(eyeMat,1)<=2
        break;
    end
    end
    Disp=insertObjectAnnotation(J,'rectangle',eyeMat,'left eye');
%     figure,imshow(Disp)
%     figure,imshow(im2bw(Disp))
    for j=1:2
        bw=im2bw(Disp);
         x(j)=floor(eyeMat(j,1)+1/2*(eyeMat(j,3)));
         y(j)=floor(eyeMat(j,2)+1/2*(eyeMat(j,4)));
        
    
    end
    rex=(x(1)+x(2))/2;
    rey=(y(1)+y(2))/2;
    x1=rex;
    x2=rex;
    figure, imshow(J);
         hold on;
         plot(rex,rey,'k.','MarkerSize',10);
        while 1%to 
            if (sum(impixel(bw,x1,rey))/3)==0
                break;
            else
                x1=x1-1;
            end       
        end  
        while 1%to 
            if (sum(impixel(bw,x2,rey))/3)==0
                break;
            else
                x2=x2+1;
            end       
        end  
%          disp(x1);
%          disp(x2);
%          disp(rey);
         diff=x2-x1;
%           
       figure,imshow(J);
       hold on;
        plot(x1,rey,'g.','MarkerSize',8);
        plot(x2,rey,'r.','MarkerSize',8);
        
%         imtool(im2bw(J));  
        
 
   if diff>30
       g(i)=1;
   end
   if diff==0
       g(i)=-1;
   end
   if diff<30
       g(i)=0;
   end
 end
end
