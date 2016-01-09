function [h]=draw_rect( x,y,color )
% It draws rectangular body for robot
% The outer rectangle depicts its viewing area

h(1)=rectangle('Position', [x-2,y-2,4,4],'EdgeColor',color,'FaceColor',color,'LineWidth',1);
if(color=='g')
    h(2)=rectangle('Position', [x-15,y-15,30,30],'EdgeColor','b','LineWidth',1);
end

end

