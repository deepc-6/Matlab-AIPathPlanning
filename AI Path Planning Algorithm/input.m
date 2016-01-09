function [ s,e ] = input( map )
% input function takes input start and end location in a given map image
% s and e are 1d matrix containing x and y coordinte of start and end point
imshow(map);
% taking input start point
[x1,y1]=ginput(1);
x1=int32(x1);
y1=int32(y1);
% while(min(min(map(y1-5:y1+5,x1-5:x1+5)))==0)
%     [x1,y1]=ginput(1);
%     x1=int32(x1);
%     y1=int32(y1);
%     min(min(map(y1-5:y1+5,x1-5:x1+5)))
% end
draw_rect(x1,y1,'g');

% taking input end point
[x2,y2]=ginput(1);
x2=int32(x2);
y2=int32(y2);
% while(min(min(map(y2-5:y2+5,x2-5:x2+5)))==0)
%     [x2,y2]=ginput(1);
%     x2=int32(x2);
%     y2=int32(y2);
% end
draw_rect(x2,y2,'r');
s=[x1,y1];
e=[x2,y2];
end

