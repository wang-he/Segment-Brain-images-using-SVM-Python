function slice_label(filename) %标签分组函数
fp=fopen(filename);
temp=fread(fp, 181 * 217 * 181);
image=reshape(temp, 181 * 217, 181);  
for i=1:181
     images = image(:, i);
     images = reshape(images, 181, 217);
     mark_data=images;
     B=size(mark_data)
     
     %将第0、1、2、3类标签所在的坐标点拿出来，其余置0
     for m=1:181
        for n=1:217
           if (mark_data(m,n)==1)||(mark_data(m,n)==2)||(mark_data(m,n)==3)
              mark(m,n)=mark_data(m,n);
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
     imwrite(uint8(mark1),['slice\lab\',num2str(i),'.png'])
end

end