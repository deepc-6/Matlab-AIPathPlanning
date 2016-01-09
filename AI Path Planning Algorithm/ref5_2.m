clear all;
clc;
img1=imread('images\x2.png');
[r c d]=size(img1);
if d>1
    img=rgb2gray(img1);
else
    img=img1;
end


% img=imadjust(img,[0.0;1.0],[0.0;1.0],5);
thresh=graythresh(img);
map=im2bw(img,thresh);
map=uint8(map*255);

%creating boundry wall in the image
map(1,:)=0;
map(end,:)=0;
map(:,1)=0;
map(:,end)=0;

% [s,e]=input(map);
s=[391 177]; e=[61 123];

travelled(1,1)=s(1);
travelled(1,2)=s(2);
map(s(2),s(1))=100;
dir=[0 0];

top=1;
counter=0;
prev_s(1)=s(1);
prev_s(2)=s(2);
imshow(map);
h1=draw_rect(s(1),s(2),'g');
h2=draw_rect(e(1),e(2),'r');
cost(1)=0;
tme(1)=0;
while(s(1)~=e(1) || s(2)~=e(2))
    t1=tic;
    [s dir cost(end+1)]=algo_ref5(travelled,s,e,map,dir,counter,cost(end));
    tme(end+1)=toc(t1)*1000;
%     if(s(1)==prev_s(1) && s(2)==prev_s(2))
    if(s(1)>=prev_s(1)-5 && s(1)<=prev_s(1)+5 && s(2)>=prev_s(2)-5 && s(2)<=prev_s(2)+5)
        counter=counter+1;
    else
        counter=0;
        prev_s(1)=s(1);
        prev_s(2)=s(2);
    end
%     imshow(map);
%     draw_rect(s(1),s(2),'g');
%     draw_rect(e(1),e(2),'r');
    set(h1(1),'Position',[s(1)-2,s(2)-2,4,4]);
    set(h1(2),'Position',[s(1)-15,s(2)-15,30,30]);
    
    map(s(2),s(1))=100;
    top=top+1;
    travelled(top,1)=s(1);
    travelled(top,2)=s(2);
    
    pause(0.0001);
end
total_cost=cost(end)
avg_time=mean(tme)