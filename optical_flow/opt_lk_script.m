figure();
imshow(fr2);
hold on;
% draw the velocity vectors
quiver(X_deci, Y_deci, u_deci,v_deci, 'y')