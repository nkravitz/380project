% Solving the 2-D Laplace's equation by the Finite Difference
...Method 
% Numerical scheme used is a second order central difference in space
...(5-point difference)
close all
%%
%Specifying parameters
nx=60;                           %Number of steps in space(x)
ny=60;                           %Number of steps in space(y)
nz=60;                           %Number of steps in space(z)
niter=10000;                     %Number of iterations 
dx=4/(nx-1);                     %Width of space step(x)
dy=4/(ny-1);                     %Width of space step(y)
dz=4/(nz-1);                     %Width of space step(z)
x=-2:dx:2;                        %Range of x(0,2) and specifying the grid points
y=-2:dy:2;                        %Range of y(0,2) and specifying the grid points
z=-2:dz:2;

rx=0.5;
rz=0.5;
A=15;

[X,Y,Z]=meshgrid(x,y,z);
R=sqrt(X.^2+Y.^2+Z.^2);
Fo=find(round(R*A)==2*A);

Go=find(round(R*A)==A);



%%
%Initial Conditions
p=zeros(nx,ny,nz);                  %Preallocating p
pn=zeros(nx,ny,nz);                 %Preallocating pn

%%
%Explicit iterative scheme with C.D in space (5-point difference)
j=2:nx-1;
i=2:ny-1;
k=2:nz-1;
for it=1:niter
    pn=p;
    p(i,j,k)=((dx^2*(pn(i+1,j,k)+pn(i-1,j,k)))+(dy^2*(pn(i,j+1,k)+...
        pn(i,j-1,k)))+(dz^2*(pn(i,j,k+1)+pn(i,j,k-1))))/(2*(dx^2+dy^2+dz^2));
    
%     %Boundary conditions
%     p(Fo)= 1;
%     p(Go)= -1;


% Square resistor with partial contacts
%     p(:,1,:)=p(:,2,:);
%     p(:,ny,:)=p(:,ny-1,:);
%     p(1,:,:)=p(2,:,:);                   
%     p(nx,:,:)=p(nx-1,:,:);
%     p(:,:,1)=p(:,:,2);                   
%     p(:,:,nz)=p(:,:,nz-1);
% 
%     p(ceil((0.5-rx/2)*nx):ceil((0.5+rx/2)*nx),1 ,...
%       ceil((0.5-rz/2)*nz):ceil((0.5+rz/2)*nz))=-1;
%     p(ceil((0.5-rx/2)*nx):ceil((0.5+rx/2)*nx),ny,...
%       ceil((0.5-rz/2)*nz):ceil((0.5+rz/2)*nz))= 1;
p(:,:,length(z)/2+1)=p(:,:,length(z)/2)+1*dx/2;
p(:,:,length(z)/2-1)=p(:,:,length(z)/2)+1*dx/2;

    
end

%%
%Plotting the solution
mriview(p,x,y,z);