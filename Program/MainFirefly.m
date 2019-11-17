% KELOMPOK 8
%   OLEH : 
% Rangga Dwi Alamsyah (1301164030)
% Simiao Salvador da Gama (1301163617)

clc; 
clear; 
close all; 

%% Problem Definition

nVar= 2;                 % Number of Decision Variables

VarSize=[1 nVar];       % Decision Variables Matrix Size

xMin= -100;             % Decision Variables Lower Bound
xMax= 100;             % Decision Variables Upper Bound

%% Firefly Algorithm Parameters 

MaxIt= 250;         % Maximum Number of Iterations

npop= 24;            % Number of Fireflies (Swarm Size)

gamma=1;            % Light Absorption Coefficient

beta0=2;            % Attraction Coefficient Base Value

alpha=0.2;          % Mutation Coefficient

alpha_damp=0.98;    % Mutation Coefficient Damping Ratio

delta=0.05*(xMax-xMin);     % Uniform Mutation Range

scale = (xMax - xMin);
%% Initialization

% Empty Firefly Structure
firefly.Position=[]; 
firefly.Cost=[];

% Cost Function
func1=@(x) Function1(x);        
func2=@(x) Function2(x);

% Initialize Best Solution Ever Found
[pop1, BestSol1] = initialFireFly(npop, xMin, xMax, VarSize,func1);
[pop2, BestSol2] = initialFireFly(npop, xMin, xMax, VarSize,func2);


%% Firefly Algorithm Main Loop

for it=1:MaxIt
    
    % Firefly move to other firefly which is brighter than him
    [BestSol1, newpop1] = fireflyMove(npop, pop1, scale, beta0, alpha, gamma, delta, xMin, xMax, VarSize, func1, BestSol1);
    [BestSol2, newpop2] = fireflyMove(npop, pop2, scale, beta0, alpha, gamma, delta, xMin, xMax, VarSize, func2, BestSol2);

    % Merge, Pop , Truncate , Store Function 1
    pop1 =[pop1; newpop1'];  
    % Sort
    [~, SortOrder1]=sort([pop1.Cost]);
    pop1=pop1(SortOrder1);
    % Truncate
    pop1= pop1(1:npop);
    % Store Best Cost Ever Found
    BestCost1(it)=BestSol1.Cost;
    minFunction1 = BestCost1(it);
    xBest1 = BestSol1.Position;
 
    
    % Merge, Pop , Truncate , Store Function 2
    pop2=[pop2; newpop2'];  %#ok
    % Sort
    [~, SortOrder2]=sort([pop2.Cost]);
    pop2=pop2(SortOrder2);
    % Truncate
    pop2=pop2(1:npop);
    % Store Best Cost Ever Found
    BestCost2(it)=BestSol2.Cost;
    minFunction2 = BestCost2(it);
    xBest2 = BestSol2.Position;
 
   
    % Show Iteration Information
    disp(['Iterasi ' num2str(it) ': Best Cost Function 1= ' num2str(BestCost1(it))]);
    disp(['Iterasi ' num2str(it) ': Best Cost Function 2= ' num2str(BestCost2(it))]);
    
    % Damp Mutation Coefficient
    alpha = alpha*alpha_damp;   
    figure(1);
    %plot(BestCost1,'LineWidth',2); 
    semilogy(BestCost1,'LineWidth',2); 
    xlabel('Iterasi');
    ylabel('Nilai Minimum Terbaik');
    title('Fungsi Pertama');
    pause(0.005);

    figure(2);
    %plot(BestCost2,'LineWidth',2);
    semilogy(BestCost2,'LineWidth',2);
    xlabel('Iterasi');
    ylabel('Nilai Minimum Terbaik');
    title('Fungsi Kedua');
    pause(0.005);

end

disp('=====================================================')
fprintf('Nilai Minimum Fungsi Pertama =  %d\n',minFunction1);
% fprintf('Individu Firefly terbaik berada di lokasi =  %d\n',xBest1);
fprintf('Solusi Terbaik X1 Fungsi Pertama =  %d\n',xBest1(1));
fprintf('Solusi Terbaik X2 Fungsi Pertama =  %d\n',xBest1(2)); 

disp('=====================================================')
fprintf('Nilai Minimum Fungsi Kedua =  %d\n',minFunction2);
% fprintf('Individu Firefly terbaik berada di lokasi =  %d\n',xBest2);
fprintf('Solusi Terbaik X1 Fungsi Kedua =  %d\n',xBest2(1));
fprintf('Solusi Terbaik X2 Fungsi Kedua =  %d\n',xBest2(2));

% Results

