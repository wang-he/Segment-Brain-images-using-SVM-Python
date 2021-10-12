function slice_image_vis(filename)  %建立一个可视的图像分割函数
fp=fopen(filename);
temp=fread(fp, 181 * 217 * 181);
image=reshape(temp, 181 * 217, 181);  
for i=1:181
     images = image(:, i);
     images = reshape(images, 181, 217);
     mark_data=images;
     B=size(mark_data)
     %通过渲染进行可视
     %将第0、1、2、3、类标签所在的坐标点拿出来，其余置0
     for m=1:181
        for n=1:217
           if (mark_data(m,n)==1)
              mark(m,n)=100;
           elseif (mark_data(m,n)==2)
              mark(m,n)=200;
           elseif (mark_data(m,n)==3)
              mark(m,n)=255;           
           else
              mark(m,n)=0;
           end
        end
     end
     A=size(mark)
    % mark = reshape(mark, 181, 217);
     mark1=imrotate(mark, 90); 
     C=size(mark1)
%      imshow(uint8(mark));
     imwrite(uint8(mark1),['slice\labvis\',num2str(i),'.png'])
end

end