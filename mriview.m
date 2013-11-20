function mriview(p,x,y,z)
close all;

ix=1;
pmax=max(max(max(p)));
pmin=min(min(min(p)));

[YY,ZZ]=meshgrid(y,z);
[~,Ey,Ez]=gradient(p);

f1=figure;
set(f1,'Toolbar','figure');

%contour(y,z,squeeze(p(ix,:,:)),80);
%hold on;
%quiver(YY,ZZ,squeeze(Ez(ix,:,:)),squeeze(Ey(ix,:,:)),2);
%hold off; 

surf(y,z,squeeze(p(ix,:,:)),'EdgeColor','none');
zlim([pmin pmax]);
caxis([pmin pmax]);
shading interp;
title({'2-D Laplace''s equation';['{\it x position} = ',num2str(x(ix))]});
xlabel('Spatial co-ordinate (y) \rightarrow');
ylabel('{\leftarrow} Spatial co-ordinate (z)');
zlabel('Solution profile (P) \rightarrow');
[az,el] = view;

s1=uicontrol('Style','slider','Units','normalized','TooltipString','x',...
    'HandleVisibility','off','Min',0,'Max',1,'Value',0,...
    'Position',[0 0 0.025 1],'SliderStep',[1/100,1/10]);
addlistener(s1,'Value','PreSet',@movez);

    function movez(hObj,event)
        ix=round(get(s1, 'Value')*(length(x)-1))+1;
        
        [az,el] = view;
        surf(y,z,squeeze(p(ix,:,:)),'EdgeColor','none');
        zlim([pmin pmax]);
        caxis([pmin pmax]);
        shading interp;
        title({'2-D Laplace''s equation';['{\it x position} = ',num2str(x(ix))]});
        xlabel('Spatial co-ordinate (y) \rightarrow');
        ylabel('{\leftarrow} Spatial co-ordinate (z)');
        zlabel('Solution profile (P) \rightarrow');
        view(az,el);
        
%         contour(y,z,squeeze(p(ix,:,:)),80);
%         hold on;
%         quiver(YY,ZZ,squeeze(Ez(ix,:,:)),squeeze(Ey(ix,:,:)),2);
%         hold off;  
        
    end
end
