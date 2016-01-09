function [ s,dir,cost ] = algo_unknown2( travelled,s,e,img,dir,counter,cost)

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
    opp_dir=[-direction(dir,1) -direction(dir,2)];
    
    fn(1:9)=0;
    gray(1:9)=0;
    
    % calculating value for theta1
    cur=s;
    nxt=[s(1)+direction(dir,1) s(2)+direction(dir,2)];
    m=(nxt(2)-cur(2))/(nxt(1)-cur(1));
    theta1=atand(double(m));

    %calcultion of all 9 directions (including current position)
    for i=1:9
        % checking if path already travelled
        nxt=[s(1)+direction(i,1) s(2)+direction(i,2)];
        gray_sum=(img(nxt(2)-1:nxt(2)+1,nxt(1)-1:nxt(1)+1))/9;
        if(gray_sum==100)
            % there is always 1 unit of movement so hn=1
            gn=1;
            
            % heuristic function hn is euclidian distance
            hn=((nxt(1)-e(1))^2+(nxt(2)-e(2))^2+100^2);
            hn=sqrt(double(hn));
            
            % calculating cost function
            fn(i)=gn+hn;
            continue;
        end
        
        % calculating total cost function for point i
        if i~=5% && (direction(i,1)~=opp_dir(1) || direction(i,2)~=opp_dir(2))
            % calculating value for theta2
            cur=s;
            nxt=[s(1)+direction(i,1) s(2)+direction(i,2)];
            m=(nxt(2)-cur(2))/(nxt(1)-cur(1));
            theta2=atand(double(m));
            
            %calculaating rotation cost
            theta=abs(theta2+theta1);
            
            % there is always 1 unit of movement so hn=1
            gn=1;
            
            % heuristic function hn is euclidian distance
            if(img(nxt(2),nxt(1))<100)
                hn=((nxt(1)-e(1))^2+(nxt(2)-e(2))^2);
            else
                hn=((nxt(1)-e(1))^2+(nxt(2)-e(2))^2+100^2);
            end
%             hn=sqrt(double(hn));
            
            % calculating cost function
            fn(i)=int64(gn+hn);
            
            % gray values
            gray(i)=mean(mean(img(nxt(2)-1:nxt(2)+1,nxt(1)-1:nxt(1)+1)));
%             gray(i)=mean(mean(img(nxt(2):direction(i,2):nxt(2)+direction(i,2)*5, nxt(1):direction(i,1):nxt(1)+direction(i,1)*5)));
        else
            nxt=s;
%             i=i
            
            % there is always 1 unit of movement so hn=1
            gn=1;
            
            % heuristic function hn is euclidian distance
            hn=((nxt(1)-e(1))^2+(nxt(2)-e(2))^2+255^2);
            
            % calculating cost function
            fn(i)=int64(gn+hn);
            
            % gray values
            gray(i)=mean(mean(img(nxt(2)-1:nxt(2)+1,nxt(1)-1:nxt(1)+1)));
%             gray(i)=mean(mean(img(nxt(2):direction(i,2):nxt(2)+direction(i,2)*5, nxt(1):direction(i,1):nxt(1)+direction(i,1)*5)));
        end
    end
    
    % finding pixel with lowest cost and gray values
    if counter<20
        r(1:9)=0;
        for i=1:9
%             if(gray(i)<100)
                r(i)=int64(gray(i)*fn(i));
%             else
%                 r(i)=int64(gray(i)*fn(i));
%             end
        end
        r(5)=max(r);
%         r=r
        [m pos]=find(r==min(r));
        if(size(pos,2)>1)
            pos=pos(1);
        end
    %     pos=pos
        dir=pos;
        gray=gray;
    else
        pos=10-dir;
%         pos=int32(rand()*8)+1;
%         nxt=[s(1)+direction(pos,1) s(2)+direction(pos,2)];
%         while(img(nxt(2),nxt(1))>100)
%             pos=int32(rand()*8)+1;
%             nxt=[s(1)+direction(pos,1) s(2)+direction(pos,2)];
%         end
        dir=pos;
    end
    s=[s(1)+direction(dir,1) s(2)+direction(dir,2)];
    cost=cost+sqrt(fn(dir));
end



    
    
    
    
    
    
    
    
    