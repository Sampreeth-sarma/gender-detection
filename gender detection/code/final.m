faceDetector = vision.CascadeObjectDetector;
 faceDetector.MergeThreshold=10;
 count0=0;
 count1=0;
 fem=0;
 mal=0;

I = imread('E:\pics\3.jpg');
bboxes = step(faceDetector, I);
    IFaces = insertObjectAnnotation(I, 'rectangle', bboxes, 'Face');
     figure, imshow(IFaces), title('Detected faces');
%     for i = 1:size(bboxes,1)
%        J= imcrop(IFaces,bboxes(i,:));
%        area(i)=bboxes(i,3)*bboxes(i,4);
%     end
    k=nosma(IFaces,bboxes);
    e=testFaceToEye3(IFaces,bboxes); 
    t=eye_to_eye(IFaces,bboxes);
   
%   for i = 1:size(bboxes,1)
%        J= imcrop(IFaces,bboxes(i,:));
%        if k(i)==0
%             figure,
%          imshow(J);
%          hText = text(10,40,'F','Color',[1 0 0],'FontSize',60);
%        else
%            figure,
%          imshow(J);
%          hText = text(10,40,'M','Color',[1 0 0],'FontSize',60);
%        end
%   end
%   
%   
%    for i = 1:size(bboxes,1)
%        J= imcrop(IFaces,bboxes(i,:));
%        if e(i)==0
%             figure,
%          imshow(J);
%          hText = text(10,40,'F','Color',[0 0 1],'FontSize',60);
%        else
%            figure,
%          imshow(J);
%          hText = text(10,40,'M','Color',[0 0 1],'FontSize',60);
%        end
%    end
  
for i=1:size(bboxes,1)
    if k(i)==0
        count0=count0+1;
    else
        count1=count1+1;
    end
    if e(i)==0
        count0=count0+1;
    else
        count1=count1+1;
    end
    if t(i)==0
        count0=count0+1;
    end
    if t(i)==1
        count1=count1+1;
    end
    if t(i)==-1
        m(i)=k(i);
    else
        if count0>count1
            m(i)=0;
        else
            m(i)=1;
        end
    end
end

    
    
    
   for i = 1:size(bboxes,1)
       J= imcrop(IFaces,bboxes(i,:));
       if m(i)==0
            figure,
         imshow(J);
         hText = text(10,40,'F','Color',[1 0 0],'FontSize',40);
       else
           figure,
         imshow(J);
         hText = text(10,40,'M','Color',[0 1 0],'FontSize',40);
       end
   end
   for i=1:size(bboxes,1)
      if m(i)==0
          fem=fem+1;
      else
          mal=mal+1;
      end
   end
  disp('Number of males are :');
  disp(mal)
  disp('Number of females are:');
  disp(fem);
  fem;
  ml=int2str(mal);
  fl=int2str(fem);
  s1='Number of males are   ';
  s2='  Number of females are';
  str1=strcat(s1,{' '},ml);
  str2=strcat(s2,{' '},fl);
  str=strcat(str1,' and ',str2);
  
  figure,
  imshow(I);
   hText = text(1,8,str,'Color',[1 0 0],'FontSize',15);
  
   