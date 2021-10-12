A=imread('output/114.jpg')
mark_data=A
for m=1:217
    for n=1:181
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
imwrite(uint8(mark),['output\vis\','114.jpg'])
