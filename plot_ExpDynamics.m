

p1=figure;
axes('Parent',p1,'Position',[0.15 0.13 0.75 0.70],'LineWidth',2,'FontSize',16);
set(gcf,'color','w');
set(gcf,'position',[1 600 800 600]);
loglog(dyn.fev,dyn.f,'b','LineWidth',1);
    hold on;
    ylabel('population size \lambda');
    xlabel('function evaluations');
    xlim([min(dyn.fev) max(dyn.fev)])  
    ylim([0.9*min(dyn.f) 1.1*max(dyn.f)])
    grid on;
    title([input.fname ' b_i=i^' num2str(input.exp) ', N=' num2str(input.n) ', L=' num2str(input.L) ', \sigma_\epsilon=' num2str(input.noise_strength)])
    
    
p2=figure;
axes('Parent',p2,'Position',[0.15 0.13 0.75 0.70],'LineWidth',2,'FontSize',16);
set(gcf,'color','w');
set(gcf,'position',[1 600 800 600]);   
loglog(dyn.fev,dyn.sigma,'b','LineWidth',1);
    hold on;
    ylabel('mutation strength \sigma');
    xlabel('function evaluations');
    xlim([min(dyn.fev) max(dyn.fev)])  
    ylim([0.9*min(dyn.sigma) 1.1*max(dyn.sigma)])
    grid on;
    title([input.fname ' b_i=i^' num2str(input.exp) ', N=' num2str(input.n) ', L=' num2str(input.L) ', \sigma_\epsilon=' num2str(input.noise_strength)])
    
    
p3=figure;
axes('Parent',p3,'Position',[0.15 0.13 0.75 0.70],'LineWidth',2,'FontSize',16);
set(gcf,'color','w');
set(gcf,'position',[1 600 800 600]);  
loglog(dyn.fev,dyn.lambda,'b','LineWidth',1);
    hold on;
    ylabel('population size \lambda');
    xlabel('function evaluations');
    xlim([min(dyn.fev) max(dyn.fev)])
    ylim([0.9*min(dyn.lambda) 1.1*max(dyn.lambda)])
    grid on;
    title([input.fname ' b_i=i^' num2str(input.exp) ', N=' num2str(input.n) ', L=' num2str(input.L) ', \sigma_\epsilon=' num2str(input.noise_strength)])
    
    
p3=figure;
axes('Parent',p3,'Position',[0.15 0.13 0.75 0.70],'LineWidth',2,'FontSize',16);
set(gcf,'color','w');
set(gcf,'position',[1 600 800 600]);  
loglog(dyn.fev,dyn.condC,'b','LineWidth',1);
    hold on;
    ylabel('condition number of C');
    xlabel('function evaluations');
    xlim([min(dyn.fev) max(dyn.fev)])
    ylim([0.9*min(dyn.condC) 1.1*max(dyn.condC)])
    grid on;
    title([input.fname ' b_i=i^' num2str(input.exp) ', N=' num2str(input.n) ', L=' num2str(input.L) ', \sigma_\epsilon=' num2str(input.noise_strength)])
