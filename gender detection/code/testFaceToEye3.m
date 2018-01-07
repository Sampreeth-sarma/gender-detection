function gender=testFaceToEye3(IFaces,bboxes)
len1=1;len=0;gender=[];
   for i = 1:size(bboxes,1)
    len=len+1;c=1;
     J= imcrop(IFaces,bboxes(i,:));
     area=bboxes(i,3)*bboxes(i,4);
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
    for j=1:size(eyeMat,1)
% %         eyeMat(j,1)=eyeMat(j,1)-15;
%         eyeMat(j,2)=eyeMat(j,2)-20;
%          eyeMat(j,3)=eyeMat(j,3)-5;
%          eyeMat(j,4)=eyeMat(j,4)-15;
        if area<10000
           eyeMat(j,2)=eyeMat(j,2)-3;
        end
        if area >10000 &&area <20000
           eyeMat(j,2)=eyeMat(j,2)-5;
        end
        if area >20000 && area<25000
            eyeMat(j,2)=eyeMat(j,2)-8;
        end
        if area >25000 && area<50000
            eyeMat(j,2)=eyeMat(j,2)-15;
        end
        if area >50000 && area <100000
            eyeMat(j,2)=eyeMat(j,2)-20;
        end
        if area >100000 && area<150000
            eyeMat(j,2)=eyeMat(j,2)-25;
        end
        if area>150000 && area<200000
            eyeMat(j,2)=eyeMat(j,2)-30;
        end
        if area>200000
            eyeMat(j,2)=eyeMat(j,2)-35;
        end
        
        
   
    Disp=insertObjectAnnotation(J,'rectangle',eyeMat,'left eye');
%     figure,imshow(Disp);
    
    x=eyeMat(j,1)+eyeMat(j,3)/2;
    xTemp=x;
    y=eyeMat(j,2);
    xEnd=x+eyeMat(j,3);
    yEnd=y+eyeMat(j,4);
    while 1
        if y==yEnd
            break;
        end
        rgb=impixel(Disp,x,y);
        systemCommand = ['C:\Python27\python.exe C:\Users\Sravanthi\PycharmProjects\untitled\closestColor.py ',num2str(rgb(1)),' ',num2str(rgb(2)),' ' ,num2str(rgb(3))];
        system(systemCommand);
        fileID = fopen('C:\Users\Sravanthi\Desktop\data2.txt','r');
        formatSpec = '%s';
        A = fscanf(fileID,formatSpec);
        fclose(fileID);
        if A=='1'
%             figure, imshow(Disp);
%         hold on;
%         plot(x,y,'r.','MarkerSize',20); 
            break;
        end
            y=y+1;
     end
          
%         bw=im2bw(J);
%         figure, imshow(bw);
%         y1=y;
%         while 1
%             if (sum(impixel(bw,x,y1))/3)==1
%               break;
%             else
%                 y1=y1+1;
%             end
%         end
       
%          
%         plot(x,y1,'r.','MarkerSize',10); 
    y1=y;
    while 1
        rgb=impixel(Disp,x,y1);
      systemCommand = ['C:\Python27\python.exe C:\Users\Sravanthi\PycharmProjects\untitled\closestColor.py ',num2str(rgb(1)),' ',num2str(rgb(2)),' ' ,num2str(rgb(3))];
        system(systemCommand);
        fileID = fopen('C:\Users\Sravanthi\Desktop\data2.txt','r');
        formatSpec = '%s';
        A = fscanf(fileID,formatSpec);
        fclose(fileID);
        if A=='1'
%             figure, imshow(Disp);
%         hold on;
%         plot(x,y,'r.','MarkerSize',20); 
            y1=y1+1;
        else
            break;
        end
    end
      
        arr(len,c)=x;c=c+1;
        arr(len,c)=y;c=c+1;
        arr(len,c)=y1;c=c+1;
        
    end
    figure, imshow(Disp);
        hold on;
        plot(arr(len,1),arr(len,2),'r.','MarkerSize',10);
        plot(arr(len,1),arr(len,3),'r.','MarkerSize',10);
        plot(arr(len,4),arr(len,5),'r.','MarkerSize',10);
        plot(arr(len,4),arr(len,6),'r.','MarkerSize',10);
        
        
%         ar1(2)=area;
%         ar1(3)=arr(len,3)-arr(len,2);
%         ar1(4)=arr(len,6)-arr(len,5);
%         disp(ar1);
%         disp('*********2.jpg**********')
%         disp(area)
%         disp(arr(len,3)-arr(len,2))
            dist1=arr(len,3)-arr(len,2);
            dist2=arr(len,6)-arr(len,5);
            if area<=12000
            if dist1<=3 || dist2<=3
               gender(len1)=0;
            else
                gender(len1)=1;
            end
            end
            if area>12000&&area<20000
            if dist1<=4 || dist2<=4
               gender(len1)=0;
            else
                
                gender(len1)=1;
            end
            end
            if area>20000&&area<40000
            if dist1<=5 || dist2<=5
               gender(len1)=0;
            else
                gender(len1)=1;
            end
            end
            if area>40000&&area<100000
            if dist1<=10 || dist2<=10
               gender(len1)=0;
            else
               gender(len1)=1;
            end
            end
            if area>100000
            if dist1<=11 || dist2<=11
               gender(len1)=0;
            else
                gender(len1)=1;
            end
            end
            
            
%         disp(arr(len,6)-arr(len,5))
        len1=len1+1;
   end 
%   gender(:)
end
%      end
%  end

        
    
    
    
    
    
    
    
    
    
