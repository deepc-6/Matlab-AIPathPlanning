clear all;
clc;
img1=imread('images\x2.png');
[r c d]=size(img1);
t1=tic;
if d>1
    img=255-rgb2gray(img1);
else
    img=255-img1;
end
t2=(toc(t1)*121)/(r*c);


img=imadjust(img,[0.0;1.0],[0.0;1.0],10);

subplot(1,1,1); imshow(img);
% [s,e]=input(map);
s=[391 177]; e=[61 123];

top=1;
travelled(1,1)=s(1);
travelled(1,2)=s(2);
% img1(1,s(2)-1:s(2)+1,s(1)-1:s(1)+1)=100;
img(s(2),s(1))=150;

%  Direction numbers
%  ------------------------
%  1  2  3          (x-1,y-1) |  (x,y-1)  |   (x+1,y-1)
%                   -----------------------------------
%  4  5  6 =====>   (x-1,y)   |  (x,y)    |   (x+1,y)
%                   -----------------------------------
%  7  8  9          (x-1,y+1) |  (x,y+1)  |   (x+1,y+1)
%
% slope m = (y2-y1) / (x2-x1);
% theta = tan_inv(m);
direction=[-1,-1; 0,-1; 1,-1; -1,0; 0,0; 1,0; -1,1; 0,1; 1,1];
dir=2;
counter=0;
prev_s(1)=s(1);
prev_s(2)=s(2);

subplot(1,1,1); imshow(img1); title('Travelling Path'); 
h1=draw_rect(s(1),s(2),'g');
h2=draw_rect(e(1),e(2),'r');
tme(1)=0;
cost(1)=0;
while(s(1)~=e(1) || s(2)~=e(2))
    t1=tic;
    [s dir cost(end+1)]=algo_unknown2(travelled,s,e,img,dir,counter, cost(end));
    tme(end+1)=toc(t1)*1000+t2;
    
%     subplot(1,1,1); imshow(img); title('Travelling Path'); 
    if(s(1)>=prev_s(1)-5 && s(1)<=prev_s(1)+5 && s(2)>=prev_s(2)-5 && s(2)<=prev_s(2)+5)
        counter=counter+1;
    else
        counter=0;
        prev_s(1)=s(1);
        prev_s(2)=s(2);
    end
    
    set(h1(1),'Position',[s(1)-2,s(2)-2,4,4]);
    set(h1(2),'Position',[s(1)-15,s(2)-15,30,30]);
%     img(s(2)-1:s(2)+1,s(1)-1:s(1)+1)=100;
    img(s(2),s(1))=150;
    top=top+1;
    travelled(top,1)=s(1);
    travelled(top,2)=s(2);
    
    pause(0.01);
end
total_cost=cost(end)
avg_time=mean(tme)











