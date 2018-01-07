function c=nosma(IFaces,bboxes)
len=1;
ln=1;
male=0;
 female=0;
   for i = 1:size(bboxes,1)
       J= imcrop(IFaces,bboxes(i,:));
       area(len)=bboxes(i,3)*bboxes(i,4);
       % disp(area(len));
       NoseDetect = vision.CascadeObjectDetector('Nose','MergeThreshold',16);
       BB=step(NoseDetect,J);
       MouthDetect = vision.CascadeObjectDetector('Mouth','MergeThreshold',16);
       BK=step(MouthDetect,J);
        while(1)
            BB=step(NoseDetect,J);
            if size(BB,1)>1
                NoseDetect.MergeThreshold=NoseDetect.MergeThreshold+3;
            end
            if size(BB,1)<2
                break;
            end
        end
        if size(BB,1)>0
         if area(len)<=10000
             BB(1,4)=13;
         end
         if area(len)>10000 && area(len)< 16000
             BB(1,4)=17; 
         end
         if area(len)>16000 && area(len)< 22000
             BB(1,4)=20; 
         end
         if area(len)>22000 && area(len)< 45000
             BB(1,4)=22; 
         end
         if area(len)>45000 && area(len)< 60000
             BB(1,4)=35; 
         end
         if area(len)>60000 && area(len)< 90000
             BB(1,4)=40; 
         end
         if area(len)>90000 && area(len)< 130000
             BB(1,4)=50; 
         end
         if area(len)>130000 && area(len)< 200000
             BB(1,4)=55; 
         end
         if area(len)>200000 && area(len)< 260000
             BB(1,4)=60; 
         end
         if area(len)>260000
             BB(1,4)=70; 
         end
%          figure,
%          imshow(J); 
%          hold on
%          rectangle('Position',BB(1,:),'LineWidth',0.5,'LineStyle','-','EdgeColor','b');
%         
%          len=len+1;
        
        
         area2(ln)=bboxes(i,3)*bboxes(i,4);
          while(1)
            BK=step(MouthDetect,J);
            if size(BK,1)>1
                MouthDetect.MergeThreshold=MouthDetect.MergeThreshold+3;
            end
            if size(BK,1)<2
                break;
            end
          end
        if size(BK,1)>0
         if area2(ln)<100000
                 BK(1,2)=BK(1,2)+5; 
          end
           
         if area2(ln)>100000
             BK(1,2)=BK(1,2)+18; 
         end
        figure,
         imshow(J); hold on
         rectangle('Position',BK(1,:),'LineWidth',0.5,'LineStyle','-','EdgeColor','b');
         ln=ln+1;
          rectangle('Position',BB(1,:),'LineWidth',0.5,'LineStyle','-','EdgeColor','b'); 
         len=len+1;
         x=BB(1,1);
        n=BB(1,2)+BB(1,4);
         m=BK(1,2);
         x1=m-n;
        s=int2str(x1);
        if(x>0)
            A(i)=x1;
        else
            A(i)=0;
        end
%         figure;
% 
%  imshow(J);

% hText = text(x+5,n+2,s,'Color',[1 0 0],'FontSize',20);
         
        end
        else
            A(i)=0;
        end
       
   end
    for i = 1:size(bboxes,1)
       J= imcrop(IFaces,bboxes(i,:));
       area(i)=bboxes(i,3)*bboxes(i,4);
    end
     for i= 1:numel(A)
%     disp(area(i));   
%     disp(k(i));
   if area(i)<10000
       if A(i)>6 
            male=male+1;
            c(i)=1;
           
       else
            female=female+1;
             c(i)=0;
            
       end
   end
   if area(i)>=10000 && area(i)<40000
       if A(i)>=14 
            male=male+1;
             c(i)=1;
            
       else
            female=female+1;
             c(i)=0;
            
       end
   end
   if area(i)>=40000
       if A(i)>32
          male=male+1;
             c(i)=1;
             
       else
           female=female+1;
             c(i)=0;
             
       end
   end
     end
end