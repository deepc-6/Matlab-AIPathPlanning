function [s dir costt]=algo_ref5(travelled,s,e,map,dir,counter,costt)
% It is a deciding algorithm where the robot is to move next
% It is a modified version of A*
% It implements A* algorithm for path finding using 8 neighbours
% travelled is a 2d array of x and y coordinates that hav already been
% covered by the robot
t_size=size(travelled);
map_size=size(map);
x=s(1);
y=s(2);
% 9 boxex in the region
check=[x y-1; x-1 y; x+1 y; x y+1];
direc=[0 -1; -1 0; 1 0; 0 1];
cost(1:4)=0;
for i=1:4
    x=check(i,1);
    y=check(i,2);
    px(1:2)=0;
    mini=255;
    % extracting pixels in range of directions defined according to direc
    for j=1:2
        xx=x+(j-1)*direc(i,1);
        yy=y+(j-1)*direc(i,2);
        px(i,j)=map(yy,xx);
    end
    mini=min(px(i,:));
%     if(map(y,x)==255)
    if(mini~=0 && counter<=6)% && (dir(1)==direc(i,1) || dir(2)==direc(i,2)) )
        flag=0;
        %searching for current x y alradey travelled
        for j=1:t_size(1);
            if(travelled(j,1)==x && travelled(j,2)==y)
                flag=1;
                break;
            end
        end
        if(flag==1) % box already travelled
%             cost(i)=(map_size(1)*map_size(2))^2;
            cost(i)=(abs(e(1)-x)^2+abs(e(2)-y)^2+100^2);
        else % box not travelled yet
            cost(i)=(abs(e(1)-x)^2+abs(e(2)-y)^2);
        end
    elseif(mini~=0 && counter>6 )
        flag=0;
        %searching for current x y alradey travelled
        for j=1:t_size(1);
            if(travelled(j,1)==x && travelled(j,2)==y)
                flag=1;
                break;
            end
        end
        if(flag==1) % box already travelled
            cost(i)=(map_size(1)*map_size(2))^2;
        else % box not travelled yet
            cost(i)=(abs(e(1)-x)^2+abs(e(2)-y)^2);
        end
    else
        cost(i)=(map_size(1)*map_size(2))^2;
    end
end
% cost(5)=max(cost);
m=min(cost);
[mini pos]=find(cost==m);
pos_size=size(pos);
if(pos_size(2)==1)
    s(1)=check(pos,1);
    s(2)=check(pos,2);
    dir(1)=direc(pos,1);
    dir(2)=direc(pos,2);
    costt=costt+cost(pos);
%     p0=pos;
else
    for i=1:pos_size(2)
        if(pos(i)~=5)
            s(1)=check(pos(i),1);
            s(2)=check(pos(i),2);
            dir(1)=direc(pos(i),1);
            dir(2)=direc(pos(i),2);
            costt=costt+cost(pos(i));
%             p1=pos(i);
            break;
        end
    end
end

end

