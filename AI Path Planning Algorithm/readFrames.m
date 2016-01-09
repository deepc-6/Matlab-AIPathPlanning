clear all;
clc;

% Create a detector object
faceDetector = vision.CascadeObjectDetector; 

boxColor = [[0,255,0]; [255,0,255]; [255,0,255]; [0,255,255]; [255,255,0]; ];

readerobj = mmreader('MOV01875.AVI', 'tag', 'myreader1');
 vidFrames = read(readerobj);
 numFrames = get(readerobj, 'numberOfFrames');
%  detector = buildDetector();

 'processing frames'
 for k = 1 :numFrames
     mov(k).cdata =vidFrames(:,:,:,k);
     mov(k).colormap = [];
     try
%         [bbox bbimg faces bbfaces]=detectFaceParts(detector,vidFrames(:,:,:,k),2);
%         size(img)
%         mov(k).cdata =bbimg;
%          subplot(1,2,1);imshow(bbimg);
%          subplot(1,2,2);imshow(vidFrames(:,:,:,k));
        I=vidFrames(:,:,:,k);
        bbox = step(faceDetector, I); 
        sz=size(bbox);
    
        % Draw boxes around detected faces and display results 
        if sz(1)>1
            for i=1:sz(1)
                % Create a shape inserter object to draw bounding boxes around detections
                shapeInserter = vision.ShapeInserter('BorderColor','Custom','CustomBorderColor',boxColor(i,:)); 
                I = step(shapeInserter, I, int32(bbox(i,:)));
            end
        else
            % Create a shape inserter object to draw bounding boxes around detections
            shapeInserter = vision.ShapeInserter('BorderColor','Custom','CustomBorderColor',[255 0 255]); 
            I = step(shapeInserter, I, int32(bbox));
        end
%         imwrite(I,'1A.jpg');
        mov(k).cdata =I;
     catch err
     end
     percent=(k*100)/numFrames
 end
hf = figure;
set(hf, 'position', [150 150 readerobj.Width readerobj.Height])
movie(hf, mov, 1, readerobj.FrameRate);