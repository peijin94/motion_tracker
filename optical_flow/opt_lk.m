function [flow_y,flow_x,flow_size]=opt_lk...
    (image_a,image_b,windowsize,diffsize,desample_size)

if nargin==2
    windowsize=5;
    %size of the slide window of the field to
    %solve LK equation    make sure this variable is odd
    diffsize=2;
    %differential step length
    %make sure this number is even!!!
    desample_size=10;
    %for faster calculation
    %calculate LK optical flow for only some of the points

    else if nargin==3
            diffsize = 2;
            desample_size = 10;
              else if nargin == 4
                    desample_size = 10;
                  end
        end
end

size_im=size(image_a);
flow_size_frame=round(size_im([1,2])-diffsize);
margin_size=round(diffsize/2);


diff_x=double(image_a(diffsize+1:size_im(1),margin_size+1:size_im(2)-margin_size))...
    -double(image_a(1:size_im(1)-diffsize,margin_size+1:size_im(2)-margin_size));

diff_y=-double(image_a(margin_size+1:size_im(1)-margin_size,diffsize+1:size_im(2)))...
    +double(image_a(margin_size+1:size_im(1)-margin_size,1:size_im(2)-diffsize));

diff_t=double(image_b(margin_size+1:size_im(1)-margin_size,...
    margin_size+1:size_im(2)-margin_size))...
    -double(image_a(margin_size+1:size_im(1)-margin_size,...
    margin_size+1:size_im(2)-margin_size));

flow_size = round((flow_size_frame-(windowsize-1)/2)/desample_size);
flow_x=zeros(flow_size);
flow_y=zeros(flow_size);

%disp(size(flow_x));  %for debug
pile_mat_x=zeros([size(flow_x),windowsize^2]);
pile_mat_y=zeros([size(flow_x),windowsize^2]);
pile_mat_t=zeros([size(flow_x),windowsize^2]);


%pile up I_x and I_y as a big martrix for futher calculate
for pile_up_1=1:windowsize
    %disp(size(pile_mat)); %for debug
    for pile_up_2=1:windowsize
        t_ind=pile_up_1*(windowsize-1)+pile_up_2;
        pile_mat_x(:,:,t_ind)=diff_x(...
            pile_up_1:desample_size:(flow_size(1)*desample_size),...
            pile_up_2:desample_size:(flow_size(2)*desample_size));
        pile_mat_y(:,:,t_ind)=diff_y(...
            pile_up_1:desample_size:(flow_size(1)*desample_size),...
            pile_up_2:desample_size:(flow_size(2)*desample_size));
        pile_mat_t(:,:,t_ind)=diff_t(...
            pile_up_1:desample_size:(flow_size(1)*desample_size),...
            pile_up_2:desample_size:(flow_size(2)*desample_size));

    end
end

%build up the parameter for guassian elimination

a11=sum(pile_mat_x.^2,3);
a12=sum(pile_mat_x.*pile_mat_y,3);
a22=sum(pile_mat_y.^2,3);

b1=-sum(pile_mat_x.*pile_mat_t,3);
b2=-sum(pile_mat_y.*pile_mat_t,3);

%find the index sutible for calculating the guassian
calc_index = (b1~=0 & b2~=0 & a11~=0 & a12~=0 & a22~=0);

flow_y(calc_index)=(b2(calc_index)-b1(calc_index).*a12(calc_index)./a11(calc_index))...
    ./(a22(calc_index)-a12(calc_index).*a12(calc_index)./a11(calc_index));
flow_x(calc_index)=(b1(calc_index)-flow_y(calc_index).*a12(calc_index))./a11(calc_index);

flow_x(~(abs(flow_x)<1.5))=0;
flow_y(~(abs(flow_y)<1.5))=0;

%imshow(uint8((flow_x.^2+flow_y.^2)/max(max(flow_x))*250))
%hist(flow_x(flow_x~=0),80)
mean(mean(flow_x));
mean(mean(flow_y));
% y=(flow_size(1):-1:1);
% x=(1:flow_size(1));
% [xx,yy]=meshgrid(x,y);
% quiver(xx,yy,flow_y,flow_x);

    %length(calc_index)     %for debug
    %disp(size(pile_mat_x)) %for debug
    %disp(flow_size)        %for debug
end