clear all
close all
sourcedatapath='C:\Users\Torfi Sigurdsson\Dropbox\Work\Manuscripts\22q11 Corollary Discharge Paper\Nature Communications\Final Submission\';
%% Create subplots for Supplementary Figure 1
figure(1);clf;
set(gcf,'windowstyle','normal','units','centimeters','pos',[37 17 14 8]);
ax1=axes('units','centimeters','position',[2 2 6 4]);
ax2=axes('units','centimeters','position',[10 2 3 4]);
wtcolor=[96 96 96]./ 255;  
delcolor = [0 216 74]./ 255; 
set(gcf,'Name','Supplementary Figure 1')
%% Supplementary Figure 1A
data=xlsread([sourcedatapath,'SourceData'],'SupFig1A');
set(gcf,'currentaxes',ax1);
ErrorPlot(1:6,data(data(:,1)==0,2:7),1,'bar',wtcolor);
ErrorPlot(1:6,data(data(:,1)==1,2:7),1,'bar',delcolor);
FormatFigure('Session #',[1:6],'# of lever presses',[0:250:1000],8,8,.02,1); 
set(gca,'xlim',[0.5 6.5])
legend({'Wild-type','{\it Df(16)A}^{+/-}'},'Location','SouthEast'); legend('boxoff')

%% Supplementary Figure 1B
data=xlsread([sourcedatapath,'SourceData'],'SupFig1B');
set(gcf,'currentaxes',ax2);
plotSpread({data(:,1),data(:,2)},...
    'distributionMarkers',{'o','o'},'distributionColors',{wtcolor; delcolor},'xNames',{'Wild-type','{\it Df(16)A}^{+/-}'})

plot([0.85,1.15],mean(data(:,1))*ones(1,2),'color','k','linewidth',2);
plot([1.85,2.15],mean(data(:,2))*ones(1,2),'color','k','linewidth',2);

set(gca,'xticklabelrotation',45,'ylim',[1 1200])
ylabel('# of lever presses')


%% Plot Figure C-D
figure(2);clf;set(gcf,'units','centimeters','position',[16, 5, 21.59,15])
ax(1)=axes('units','centimeters','position',[2,3.8,4,2]*.9);
ax(2)=axes('units','centimeters','position',[8,3.8,4,2]*.9);
set(gcf,'name','Figure1C-D')
colors=colormap('lines');

for n = 1:2
    switch n
        case 1
            data=xlsread([sourcedatapath,'SourceData'],'Fig1C');
        case 2
            data=xlsread([sourcedatapath,'SourceData'],'Fig1D');
    end

    set(gcf,'currentaxes',ax(n));
    plot(data(:,1),data(:,2),'linewidth',2);hold on
    plot(data(:,1),data(:,3),'linewidth',2);hold on

    if(n==1);FormatFigure('Time (ms)',-100:100:200,'Firing rate (Hz)',0:20:60,8,8,.02,1);
        ylims=ylim;
        text(60,ylims(2)*.9,'Random','fontsize',8,'color',colors(1,:),'fontweight','bold')
        text(60,ylims(2)*.75,'Self-generated','fontsize',8,'color',colors(2,:),'fontweight','bold')
    else;FormatFigure('Time (ms)',-100:100:200,' ',0:20:60,8,8,.02,1);end

end

%% Create subplots for Figure 1E-H

figure(3);clf;set(gcf,'units','centimeters','position',[30, 11, 21.59,15])
ax(1)=axes('units','centimeters','position',[11,7.5,3,3]*.9);%x position originally 2
ax(2)=axes('units','centimeters','position',[15.5,7.5,3,3]*.9);%x position originally 8
ax(3)=axes('units','centimeters','position',[2,2.25,3,3.5]*.9);
ax(4)=axes('units','centimeters','position',[6.5,2.25,1.75,3.5]*.9);
ax(5)=axes('units','centimeters','position',[9,2.25,1.75,3.5]*.9);

wtcolor=[96 96 96]./ 255;  
delcolor = [0 216 74]./ 255; 

%Set general axis properties:
fsize=8;
tlength=.02;
lwidth=1;
scatterplot_xticks=0:20:60;

set(ax,'Fontsize',fsize,'fontweight','normal','linewidth',lwidth,'box','off','tickdir','out','ticklength',[tlength tlength],'YTickmode','auto')
set(gcf,'Name','Figure 1E-H')

%% Figure 1E
set(gcf,'currentaxes',ax(1));cla
data=xlsread([sourcedatapath,'SourceData'],'Fig1E');
plot(data(:,1),data(:,2),'ko','markersize',3);hold on
axisticks=scatterplot_xticks;
% disp([num2str(sum(random*spikeFactor>max(axisticks)|lever*spikeFactor>max(axisticks))), ' data points not visible']);
FormatFigure('Random (Hz)',axisticks,'Self-generated (Hz)',axisticks,fsize,fsize,tlength,lwidth)
h=AddUnityLine;h.Color=[1 0 0];

%% Figure 1F
set(gcf,'currentaxes',ax(2));cla
data=xlsread([sourcedatapath,'SourceData'],'Fig1F');
plot(data(:,1),data(:,2),'ko','markersize',3);hold on
axisticks=scatterplot_xticks;
% disp([num2str(sum(random*spikeFactor>max(axisticks)|lever*spikeFactor>max(axisticks))), ' data points not visible']);
FormatFigure('Random (Hz)',axisticks,'Self-generated (Hz)',axisticks,fsize,fsize,tlength,lwidth)
h=AddUnityLine;h.Color=[1 0 0];

%% Figure 1G
set(gcf,'currentaxes',ax(3));cla
data=xlsread([sourcedatapath,'SourceData'],'Fig1G');
mi=data(isfinite(data(:,1)),1);
mi_del=data(isfinite(data(:,2)),2);
handle=plotSpread({mi,mi_del},'distributionMarkers',{'o','o'},'distributionColors',{wtcolor; delcolor},'xNames',{'Wild-type','{\it Df(16)A}^{+/-}'});
set(gca,'XTickLabelRotation',45)
set(handle{1},'Markersize',3)
set(gca,'xlim',[0.25 2.75])
plot([0.85,1.15],[mean(mi),mean(mi)],'color','k','linewidth',1.75)
plot([1.85,2.15],[mean(mi_del),mean(mi_del)],'color','k','linewidth',1.75)
FormatFigure([],[],'Modulation Index',-1:.5:1,fsize,fsize,tlength,lwidth);
stats=ranksum(mi,mi_del);
h=AddSignificanceLines(1,2,'positive',stats,8,.035,.01);
ylim([-1 1]);axs=gca;axs.Clipping='off';
plot([0.25 2.75],[0 0],'k--')

%% Figure 1H
set(gcf,'currentaxes',ax(4))
data=xlsread([sourcedatapath,'SourceData'],'Fig1H Random');
random=data(isfinite(data(:,1)),1);
random_del=data(isfinite(data(:,2)),2);
[h,stats] = boxplotn(1:2,{random,random_del},'unpaired',[wtcolor;delcolor],0, 'whiskpos', '5-95perc');
FormatFigure([],[],'Firing rate (Hz)',0:10:40,fsize,fsize,tlength,lwidth);
set(gca,'XTick',[1 2],'XTickLabel',{'Wild-type','{\it Df(16)A}^{+/-}'},'XTickLabelRotation',45);
set(gca,'xlim',[0 3])
stats=ranksum(random, random_del);
AddStars(stats);
title('Random','fontsize',8)

set(gcf,'currentaxes',ax(5))
data=xlsread([sourcedatapath,'SourceData'],'Fig1H Lever');
lever=data(isfinite(data(:,1)),1);
lever_del=data(isfinite(data(:,2)),2);
[h,stats] = boxplotn(1:2,{lever,lever_del},'unpaired',[wtcolor;delcolor],0, 'whiskpos', '5-95perc');
FormatFigure([],[],'Firing rate (Hz)',0:10:40,fsize,fsize,tlength,lwidth);
set(gca,'XTick',[1 2],'XTickLabel',{'Wild-type','{\it Df(16)A}^{+/-}'},'XTickLabelRotation',45);
set(gca,'xlim',[0 3])
stats=ranksum(lever, lever_del);
AddSignificanceLines(1,2,'positive',stats,fsize,.035,.02);
title('Self-generated','fontsize',8)

%% Plot Figure 1I-J
figure(4);clf;
set(gcf,'units','centimeters','position',[0.1600   18.4000    6.3805    6.5617])
ax(1)=axes('units','centimeters','position',[1,2.25,1.75,3.5]*.9);
ax(2)=axes('units','centimeters','position',[4.5,2.25,1.75,3.5]*.9);
set(gcf,'Name','Figure 1I-J')

%Wild-types:
set(gcf,'currentaxes',ax(1))
miBin=xlsread([sourcedatapath,'SourceData'],'Fig1I');
[h,p]=boxplotn(1:2,miBin,'paired',wtcolor,0,'whiskpos','5-95perc');
xticklabels({'Early','Late'});ylabel('Modulation index');
set(gca,'fontsize',8,'xtick',[1,2])
if(p.nonparametric<.05)
    h=AddSignificanceLines(1,2,'positive',p.nonparametric(1,2),8,.035,.01);
end
set(gca,'ylim',[-1 1],'xlim',[0 3],'xticklabelrotation',45)
plot([0,3],[0,0],'k--');hold on
ax(1).Clipping='off';

%Df16:
set(gcf,'currentaxes',ax(2));
miBin_del=xlsread([sourcedatapath,'SourceData'],'Fig1J');
[h,p]=boxplotn(1:2,miBin_del,'paired',delcolor,0,'whiskpos','5-95perc');
xticklabels({'Early','Late'});ylabel('Modulation index');
set(gca,'fontsize',8,'xtick',[1,2])
if(p.nonparametric<.05)
    h=AddSignificanceLines(1,2,'positive',p.nonparametric(1,2),8,.035,.01);
end
set(gca,'ylim',[-1 1],'xlim',[0 3],'xticklabelrotation',45);hold on
plot([0,3],[0,0],'k--');
ax(2).Clipping='off';

%% Supplementary Figure 2
figure(5);clf;h1=subplot(2,1,1);
set(gcf,'Name','Supplementary Figure 2')
data=xlsread([sourcedatapath,'SourceData'],'SupFig2A');
preactivitythreshold=[0.25, 0.5,1,1.5,2,1,1,1,1];%The different preactivitythresholds to examine
fsize=8;
tlength=.02;
lwidth=1;
preactivitythresh=[0.25 .5 1 1.5 2];
xvals=[1,2,4,5,7,8,10,11,13,14];
[handle,stats] = boxplotn(xvals,data(2:end,1:10),'unpaired',[wtcolor;delcolor;wtcolor;delcolor;wtcolor;delcolor;wtcolor;delcolor;wtcolor;delcolor],0, 'whiskpos', '5-95perc');hold on
set(gca,'xtick',1.5:3:13.5,'xticklabel',preactivitythresh)
FormatFigure([],[],'Modulation Index',-1:.5:1,fsize,fsize,tlength,lwidth);
plot([0 15],[0 0],'k--');
xlabel('Minimum separation from previous sound (s)')

for n = 1:5
    index=[n*2-1,n*2];
    stats=ranksum(data(:,index(:,1)),data(:,index(:,2)));
    h=AddSignificanceLines(xvals(index(1)),xvals(index(2)),'positive',stats,8,.035,.01);
    ylim([-1 1]);axs=gca;axs.Clipping='off';
end

subplot(2,5,6);
data=xlsread([sourcedatapath,'SourceData'],'SupFig2B');
[handle,stats] = boxplotn([1,2],data,'unpaired',[wtcolor;delcolor],0, 'whiskpos', '5-95perc');hold on
FormatFigure([],[],'Modulation Index',-1:.5:1,fsize,fsize,tlength,lwidth);
set(gca,'xlim',[0.25 2.75],'xtick',[]);
plot([0.25 2.75],[0 0],'k--');
stats=ranksum(data(:,1),data(:,2));
h=AddSignificanceLines(1,2,'positive',stats,8,.035,.01);

h1=subplot(2,5,7);
data=xlsread([sourcedatapath,'SourceData'],'SupFig2C');
[handle,stats] = boxplotn([1,2],data,'unpaired',[wtcolor;delcolor],0, 'whiskpos', '5-95perc');hold on
FormatFigure([],[],[],-1:.5:1,fsize,fsize,tlength,lwidth);
set(gca,'xlim',[0.25 2.75],'xtick',[]);
plot([0.25 2.75],[0 0],'k--');
stats=ranksum(data(:,1),data(:,2));
h=AddSignificanceLines(1,2,'positive',stats,8,.035,.01);

h1.Position(1)=h1.Position(1)+.05;
set(gcf,'units','centimeters','position',[33.1047    6.8368   12.8693   14.0335]);
%% Supplementary figure 3B
figure(6);clf;h3=subplot(4,1,3);
fsize=8;
tlength=.02;
lwidth=1;
data=xlsread([sourcedatapath,'SourceData'],'SupFig3B');
colors=colormap('jet');
colors=colors(round(linspace(1,192,4)),:);
for n = 1:4
    plot(data(1,2:end),data(n+1,2:end),'color',colors(n,:),'linewidth',1);hold on
end
set(gca,'xlim',[-.1 1.2],'xtick',[-.1 0,.2, .4, .7, 1,1.2]);
box off
FormatFigure('Time (s)',[],'Firing rate (Hz)',0:50:150,fsize,fsize,tlength,lwidth);
h3.Position(2)=h3.Position(2)+.05;
%% Supplementary Figure 3C
wtcolor=[96 96 96]./ 255;  
delcolor = [0 216 74]./ 255; 
h4=subplot(4,1,4);
set(gcf,'Name','Supplementary Figure 3')
data=xlsread([sourcedatapath,'SourceData'],'SupFig3C_WT');
h_1=ErrorPlot([0.2,0.4,0.7 1],data,1,'bar',wtcolor);hold on
data=xlsread([sourcedatapath,'SourceData'],'SupFig3C_DEL');
h_2=ErrorPlot([0.2,0.4,0.7 1],data,1,'bar',delcolor);hold on
plot([0.2,0.4,0.7 1],ones(1,4),'k--');
set(gca,'ylim',[0.4 1.2]);
ylims=get(gca,'ylim');
l=legend([h_1,h_2],{'WT','Del'},'box','off');
FormatFigure('Inter-stimulus interval (s)',[0.2,0.4,0.7 1],'Paired-pulse ratio',.4:.2:1.2,fsize,fsize,tlength,lwidth);
set(gca,'xlim',[.1 1.1]);
h4.Position(4)=h4.Position(4)*1.2;
l.Position=[ 0.6987    0.2580    0.1668    0.0615];
set(gcf,'units','centimeters','position',[40.5342   11.4300   10.7526   13.6313]);
%% Figure 2: create subplots
figure(7);clf
set(gcf,'units','centimeters','position',[20.9033   10.9643   21.5900   15.0072])
ax(1)=axes('units','centimeters','position',[2,10,10,4]*.7);
ax(2)=axes('units','centimeters','position',[2.5,12.25,2.5,1.5]*.7);
ax(3)=axes('units','centimeters','position',[13.5,10,2,4]*.7);
ax(4)=axes('units','centimeters','position',[17,10,3,4]*.7);
ax(5)=axes('units','centimeters','position',[21.5,10,3,4]*.7);

ax(6)=axes('units','centimeters','position',[2,3,3.5,4]*.7);
ax(7)=axes('units','centimeters','position',[7,3,3.5,4]*.7);
ax(8)=axes('units','centimeters','position',[12,3,5.5,4]*.7);
ax(9)=axes('units','centimeters','position',[19.5,3,5,4]*.7);

wtcolor=[96 96 96]./ 255;  
delcolor = [0 216 74]./ 255; 

%Set general axis properties:
fsize=8;
tlength=.02;
lwidth=1;
psize=10;

set(ax,'Fontsize',fsize,'fontweight','normal','linewidth',lwidth,'box','off','tickdir','out','ticklength',[tlength tlength],'YTickmode','manual')
set(gcf,'Name','Figure 2')

%% Figure 2A
PURPLE = [0.808 0 0.631];
TEAL = [0 0.60 0.839];
set(gcf,'currentaxes',ax(1)); cla%subplot(2,2,1:2);cla
data=xlsread([sourcedatapath,'SourceData'],'Fig2A');
valley2peak=data(:,1);
halfwidth=data(:,2);
cellindexGMM=data(:,3);

S1=scatter(valley2peak(cellindexGMM==1,:), halfwidth(cellindexGMM==1,:), psize, TEAL); hold on
S2=scatter(valley2peak(cellindexGMM==2), halfwidth(cellindexGMM==2), psize, PURPLE); hold on
scatter(valley2peak(cellindexGMM==6,:), halfwidth(cellindexGMM==6,:), psize, 'k'); hold on

data = [valley2peak, halfwidth];
mn = min(data); mx = max(data);
[X,Y] = meshgrid(linspace(mn(1),mx(1),1000), linspace(mn(2),mx(2),1000));
[cellindexGMM, gm] = gmmodel([valley2peak, halfwidth], 0, true);  %fuctions to look at only well seperated INT&PYRs
C = cluster(gm, [X(:) Y(:)]);
C1 = reshape(C,size(X));
contour(X,Y,C1,1,'LineColor','k');hold on;

FormatFigure('Trough-to-peak (ms)',[0.1: 0.2: 1.1],'Spike half-width (ms)',[0: 0.1: 0.6],fsize,fsize,tlength,lwidth)
text(0.125,0.225,'pINT','color',PURPLE,'fontweight','bold','FontSize',fsize);
text(0.6,0.475,'pPYR','color',TEAL,'fontweight','bold','FontSize',fsize);
% txt = ['n = ',num2str(nAllCells)];
% text(0.9,0.55,txt,'color',[0 0 0],'fontweight','bold','FontSize',fsize);
set(gca,'ticklength',[.01 .01])

%Plot spike waveforms:
data=xlsread([sourcedatapath,'SourceData'],'Fig2A_Waveforms');
tealError = [0.486 0.737 0.839];
purpleError = [0.808 0.337 0.702];
set(gcf,'currentaxes',ax(2)) 
ErrorPlot(data(1,2:end), data(data(:,1)==1,2:end), 1, 'shaded', [TEAL; tealError]); hold on;
ErrorPlot(data(1,2:end), data(data(:,1)==0,2:end), 1, 'shaded', [PURPLE; purpleError]); hold on;
axis off
%% Figure 2C
set(gcf,'currentaxes',ax(4));cla
data=xlsread([sourcedatapath,'SourceData'],'Fig2C');
IntFR_WT=data(isfinite(data(:,1)),1);
IntFR_Del=data(isfinite(data(:,2)),2);
handle = plotSpread({IntFR_WT, IntFR_Del}, 'distributionMarkers', {'o','o'}, 'distributionColors', {PURPLE,PURPLE}, 'xNames', {'WT','Df(16)A^{+/-}'});
set(handle{1}, 'Markersize', 3.75, 'LineWidth', 0.5)
FormatFigure([],[], 'Firing Rate (Hz)', 0:10:40, fsize, fsize,tlength,lwidth);
plot([.85 1.15],ones(1,2)*mean(IntFR_WT),'k','linewidth',2)
plot([1.85 2.15],ones(1,2)*mean(IntFR_Del),'k','linewidth',2)
AddStars(ranksum(IntFR_WT, IntFR_Del));
set(gca,'xtick',[1:2],'XTickLabel',{'Wild-type','{\it Df(16)A}^{+/-}'},'fontWeight','normal','xticklabelrotation',45)

%% Figure 2D
set(gcf,'currentaxes',ax(5))
data=xlsread([sourcedatapath,'SourceData'],'Fig2D');
PyrFR_WT=data(isfinite(data(:,1)),1);
PyrFR_Del=data(isfinite(data(:,2)),2);
handle = plotSpread({PyrFR_WT, PyrFR_Del}, 'distributionMarkers', {'o','o'}, 'distributionColors', {TEAL,TEAL}, 'xNames', {'WT','Df(16)A^{+/-}'});
set(handle{1}, 'Markersize', 3.75, 'LineWidth', 0.5)
FormatFigure([],[], 'Firing Rate (Hz)', 0:10:40, fsize, fsize,tlength,lwidth);
plot([.85 1.15],ones(1,2)*mean(PyrFR_WT),'k','linewidth',2)
plot([1.85 2.15],ones(1,2)*mean(PyrFR_Del),'k','linewidth',2)
AddStars(ranksum(PyrFR_WT, PyrFR_Del));
set(gca,'xtick',[1:2],'XTickLabel',{'Wild-type','{\it Df(16)A}^{+/-}'},'fontWeight','normal','xticklabelrotation',45)

%% Figure 2E
set(gcf,'currentaxes',ax(6));cla
data=xlsread([sourcedatapath,'SourceData'],'Fig2E');
miIntWT=data(isfinite(data(:,1)),1);
miIntDel=data(isfinite(data(:,2)),2);
handle = plotSpread({miIntWT, miIntDel}, 'distributionMarkers', {'o','o'}, 'distributionColors', {PURPLE,PURPLE}, 'xNames', {'INT\newlineWT','INT\newlineDf(16)A^{+/-}'});
axis([.4 2.7 -1.085 1.03]);
plot([.85 1.15],ones(1,2)*mean(miIntWT),'k','linewidth',2)
plot([1.85 2.15],ones(1,2)*mean(miIntDel),'k','linewidth',2)
plot(xlim,zeros(1,2),'k--')
set(gca,'Clipping','off');
set(handle{1}, 'Markersize', 3.75, 'LineWidth', 0.5)
h=AddSignificanceLines(1,2,'positive',stats,8,.035,.01);
axis square
set(gca,'xtick',[1:2],'XTickLabel',{'Wild-type','{\it Df(16)A}^{+/-}'},'xticklabelrotation',45)
FormatFigure([],[], 'Modulation Index', -1: 0.5: 1, fsize, fsize,tlength,lwidth);

%% Figure 2F
set(gcf,'currentaxes',ax(7));cla
data=xlsread([sourcedatapath,'SourceData'],'Fig2F');
miPyrWT=data(isfinite(data(:,1)),1);
miPyrDel=data(isfinite(data(:,2)),2);
handle = plotSpread({miPyrWT, miPyrDel}, 'distributionMarkers', {'o','o'}, 'distributionColors', {TEAL,TEAL}, 'xNames', {'Int_WT','{\it Df(16)A}^{+/-}'});
set(handle{1}, 'Markersize', 3.75, 'LineWidth', 0.5)
axis([.4 2.7 -1.085 1.15]);
plot([.85 1.15],ones(1,2)*mean(miPyrWT),'k','linewidth',2)
plot([1.85 2.15],ones(1,2)*mean(miPyrDel),'k','linewidth',2)
plot(xlim,zeros(1,2),'k--')
h=AddSignificanceLines(1,2,'positive',stats,8,.035,.01);
set(gca,'Clipping','off');
axis square
set(gca,'xtick',[1:2],'XTickLabel',{'Wild-type','{\it Df(16)A}^{+/-}'},'xticklabelrotation',45)
FormatFigure([],[], 'Modulation Index', -1: 0.5: 1, fsize, fsize,tlength,lwidth);

%% Figure 2G-H
set(gcf,'currentaxes',ax(8));cla
depthbins = [0 300 600 900 1100];
GREY = [96 96 96]./ 255;
GREEN = [0 216 74]./ 255; 
[data,b,genotype]=xlsread([sourcedatapath,'SourceData'],'Fig2G_H');
includeDel=ismember(data(:,1),1);
includeWT=ismember(data(:,1),0);
cellDepth=data(:,2);
miAll=data(:,3);
h(2)=plot(cellDepth(includeDel==1),miAll(includeDel==1),'.','color',GREEN,'markersize',15);hold on
h(1)=plot(cellDepth(includeWT==1),miAll(includeWT==1),'.','color',GREY,'markersize',15);hold on
FormatFigure('Depth (um)',0:300:900,'Modulation Index',-1:.5:1,fsize,fsize,tlength,lwidth);
set(gca,'xlim',[0 1200])
ylims=get(gca,'ylim');
plot([depthbins;depthbins],repmat(ylims',1,length(depthbins)),'k:')
plot(xlim,zeros(1,2),'k--')
l=legend(h,{'Wild-type','{\it Df(16)A}^{+/-}'},'box','off','orientation','horizontal','position',[0.3652    0.3292    0.2005    0.0339]);
l.ItemTokenSize(1)=10;

set(gcf,'currentaxes',ax(9));cla
[~,depthbin]=histc(cellDepth,depthbins);
nbins=length(depthbins)-1;

for n2=1:nbins
    del{n2}=miAll(depthbin==n2&includeDel==1);
    wt{n2}=miAll(depthbin==n2&includeWT==1);
    depthlabels(n2)={[num2str(depthbins(n2)),'-',num2str(depthbins(n2+1))]};
end
ee = ErrorPlot(1:nbins,wt,1,'bar',GREY); hold on
ee = ErrorPlot(1:nbins,del,1,'bar',GREEN);
set(gca,'xtick',1:nbins,'xticklabels',depthlabels,'xticklabelrotation',45);
FormatFigure('Depth(um)',[],'Modulation Index',-.75:.25:.25,fsize,fsize,tlength,lwidth);
set(gca,'xlim',[0.8 nbins+0.2])
plot([0.8 nbins+0.2],zeros(1,2),'k--')

%% Figure 3: Create subplots
figure(8);clf;set(gcf,'units','centimeters','position',[16, 5, 21.59,15]);
ax(1)=axes('units','centimeters','position',[2,8.15,3,1.75]*.9);
ax(2)=axes('units','centimeters','position',[2,6.2,3,1.75]*.9);
ax(3)=axes('units','centimeters','position',[6.5,6.2,6,3.9]*.9);
ax(4)=axes('units','centimeters','position',[14,6.2,3,3.9]*.9);
set(ax,'TickDir','out');
set(gcf,'Name','Figure 3')

%% Figure 3A
set(gcf,'currentaxes',ax(2));cla
data=xlsread([sourcedatapath,'SourceData'],'Fig3A');
ErrorPlot(data(1,:),data(2:end,1:end),1,'shaded',[0 0 0;.5 .5 .5]);
ylabel('Firing rate (Hz)','fontsize',8);
xlabel('Time to lever press (ms)','fontsize',8);
box off
set(gca,'tickdir','out','xtick',-1000:250:0,'xlim',[-1000 0],'ylim',[0 16]);
%% Figure 3B
smoothwindow=5;
set(gcf,'currentaxes',ax(3));cla
data=xlsread([sourcedatapath,'SourceData'],'Fig3B_WT');
time=data(1,:);
wt=data(2:end,:);
timerange=[-1 0];
data=xlsread([sourcedatapath,'SourceData'],'Fig3B_DEL');
del=data(2:end,:);

h(1)=ErrorPlot(time,wt,1,'shaded',[GREY;.5 .5 .5]);hold on;
h(2)=ErrorPlot(time,del,1,'shaded',[GREEN; .4 1 .7]);
set(h,'LineWidth',1.5);box off
ylabel('\Delta firing rate (Hz)','fontsize',8);
xlabel('Time to lever press (ms)','fontsize',8);
set(gca,'tickdir','out','xlim',[-1000 0],'ylim',[-1 5]);
plot(1000*timerange,zeros(1,2),'k--');

clear p
for n=1:length(time)
    p(n)=ranksum(wt(:,n),del(:,n));
end
ylims=get(gca,'ylim');
plot(time(p<0.01),ylims(2)*ones(1,sum(p<0.01)),'k*','markersize',3)

legend(h,{'Wild-type','{\it Df(16)A}^{+/-}'},'box','off','location','northwest');

%% Figure 3C
set(gcf,'currentaxes',ax(4));cla
ylims=[-2 15];
data=xlsread([sourcedatapath,'SourceData'],'Fig3C');
avgpreactivity_wt=data(isfinite(data(:,1)),1);
avgpreactivity_del=data(isfinite(data(:,2)),2);
h=plotSpread({avgpreactivity_wt,avgpreactivity_del},...
    'distributionMarkers',{'o','o'},'distributionColors',{GREY; GREEN},'xValues',[1,2]);
 set(h{1},'Markersize',3);
set(gca,'XTick',[1 2],'XTickLabel',{'Wild-type','{\it Df(16)A}^{+/-}'},'XTickLabelRotation',45,'xlim',[0 3],'fontsize',8);
ylabel('\Delta firing rate (Hz)','fontsize',8);
plot([0 3],zeros(1,2),'k--');
plot([0.85,1.15],[mean(avgpreactivity_wt),mean(avgpreactivity_wt)],'color','k','linewidth',1.75);
plot([1.85,2.15],[mean(avgpreactivity_del),mean(avgpreactivity_del)],'color','k','linewidth',1.75);
stats=ranksum(avgpreactivity_wt,avgpreactivity_del);
h{1}(1).YData(avgpreactivity_wt<ylims(1)|avgpreactivity_wt>ylims(2))=NaN;
h{1}(2).YData(avgpreactivity_del<ylims(1)|avgpreactivity_del>ylims(2))=NaN;
set(gca,'ylim',ylims)
h=AddSignificanceLines(1,2,'positive',stats,8,.035,.01);

%% Figure 4D
data=xlsread([sourcedatapath,'SourceData'],'Fig4D');
figure(9);clf
set(gcf,'windowstyle','normal','units','centimeters','pos',[1.0000    2.0000    4.0165    5.2653]);
ax=axes('units','centimeters','position',[1.5,0.5, 1.5, 2.6]*1.1)
a = plot(data(:,1),data(:,2)); hold on
a.Color = [.2,1,0];
% plot(dist, valuesFilt);

FormatFigure(sprintf('Distance from surface (%sm)',char(181)),[0:200:1000], 'Fluorescence',[0:1],7,7,.015,1);
camroll(-90)
%% Figure 4F-J
figure(10);clf
set(gcf,'windowstyle','normal','units','centimeters','position',[31,6,21,20]);
set(gcf,'Name','Figure 4')

for n=1:3
    ax(2,n)=axes('units','centimeters','position',[5+4*[n-1] 12 3 2]);
end

ax2(1,1)=axes('units','centimeters','position',[2 7.5 6 3]);
ax2(1,2)=axes('units','centimeters','position',[10 7.5 6 3]);
set(ax2,'YTickMode','manual','XTickMode','manual');

depthbins=200:100:1100;%depth bins
data=xlsread([sourcedatapath,'SourceData'],'Fig4I_J');
cellDepth=data(:,1);
index=logical(data(:,2:3));

letters={'F','G','H'};
timerange=[-.01 .03;-0.01 .03;-.1 .2];
for n=1:3
    data=xlsread([sourcedatapath,'SourceData'],sprintf('Fig4%s',letters{n}));
    set(gcf,'currentaxes',ax(2,n))
    plot(data(:,1),data(:,2),'k','linewidth',1.5);
    ylims=ylim;
    t=text(1000*timerange(n,2)-1000*diff(timerange(n,:))*.015,ylims(2)-diff(ylims)*.75,...
        sprintf('%d %sm',data(1,3),char(181)),'HorizontalAlignment','right','fontsize',9);
    box off
    xlabel('Time from laser onset (ms)');
    if(n==1);ylabel('Firing rate (Hz)');end
    set(gca,'xlim',timerange(n,:)*1000)
end

for n = 1:2
set(gcf,'currentaxes',ax2(1,n))
bar(conv(depthbins,[.5 .5],'valid'),histcounts(cellDepth(index(:,n)),depthbins)./histcounts(cellDepth,depthbins));hold on
set(gca,'xtick',depthbins);
ylabel('Depth')
ylabel('Fraction of neurons','fontsize',8)
xlabel(sprintf('Depth (%sm)',char(181)),'fontsize',8)
set(gca,'ylim',[0 .2])
box off
ylims(n,:)=ylim;
end
set(ax2,'ylim',[0 .155])
set(ax2,'FontSize',8,'LabelFontSizeMultiplier',1)
set(ax2,'TickDir','out','TickLength',[.03 .03])
set(ax2,'TickDir','out','TickLength',[.015 .015])
%% Supplementary Figure 4: Create subplots
figure(11);clf
set(gcf,'windowstyle','normal','units','centimeters','position',[31,6,21,20]);
ax2(2,1)=axes('units','centimeters','position',[2 7 6 3]);
ax2(2,2)=axes('units','centimeters','position',[10 7 6 3]);
ax3=axes('units','centimeters','position',[12 11.5 4 3]);
ax4=axes('units','centimeters','position',[2 2 6 3]);
ax5=axes('units','centimeters','position',[10 2 6 3]);
ax6(1)=axes('units','centimeters','position',[2 11.5 2 3]);
ax6(2)=axes('units','centimeters','position',[4.5 11.5 2 3]);
set(gcf,'Name','Figure 2')
set(ax2,'YTickMode','manual','XTickMode','manual');
set(gcf,'Name','Supplementary Figure 4')

%% Supplementary Figure 4A
data=xlsread([sourcedatapath,'SourceData'],'SupFig4A');
exc_ratio=data(:,1:2);
inh_ratio=data(:,3:4);
clear h
set(gcf,'currentaxes',ax6(1));h(:,1)=plot(exc_ratio','-o','markersize',3,'markerfacecolor',[0    0.4470    0.7410]);set(gca,'xlim',[[.5 2.5]],'ylim',[0 .12],'xtick',1:2,'xticklabel',{'Upper','Lower'},'fontsize',8);box off
ylabel('Fraction of neurons','fontsize',8);title('Excited','fontsize',8)
set(gcf,'currentaxes',ax6(2));h(:,2)=plot(inh_ratio','k-o','markersize',3);set(gca,'xlim',[[.5 2.5]],'ylim',[0 .12],'xtick',1:2,'xticklabel',{'Upper','Lower'},'fontsize',8);box off
title('Inhibited','fontsize',8)
set(h,'color',[0    0.4470    0.7410]);
set(h,'markerfacecolor',[0    0.4470    0.7410]);
set(h,'markeredgecolor',[0    0.4470    0.7410]);
%% Supplementary Figure 4B
data=xlsread([sourcedatapath,'SourceData'],'SupFig4B');
set(gcf,'currentaxes',ax3);cla
bins=0:5:50;
x=conv(bins,[.5 .5],'valid');
for n = 1:2
    plot(x,histcounts(data(:,n*2),bins)/max(data(:,1+[n-1]*2)),'.-','markersize',10);hold on
    set(gca,'xtick',bins)
    ylabel('Fraction of neurons')
    xlabel('Response latency (ms)')
end
set(gca,'xtick',0:10:50,'tickdir','out','fontsize',8,'TickLength',[.02 .02])
box off;
l=legend({'M2 terminal stimulation','M2 cell body stimulation'},'box','off');
l.Position=[0.5656    0.7286    0.1933    0.0398];
%% Supplementary Figure 4C-D:
data=xlsread([sourcedatapath,'SourceData'],'SupFig4C_D');
depthbins=200:100:1100;%depth bins

for n = 1:2
set(gcf,'currentaxes',ax2(2,n));cla
bar(conv(depthbins,[.5 .5],'valid'),histcounts(data(data(:,n+1)==1,1),depthbins)./histcounts(data(:,1),depthbins));hold on
set(gca,'xtick',depthbins);
ylabel('Depth')
ylabel('Fractiolln of neurons','fontsize',8)
xlabel(sprintf('Depth (%sm)',char(181)),'fontsize',8)
set(gca,'ylim',[0 .2])
box off
ylims(n,:)=ylim;
end
set(ax2(2,:),'ylim',[0 .155])
set(ax2(2,:),'TickDir','out','TickLength',[.015 .015])
%% Supplementary Figure 4E
data=xlsread([sourcedatapath,'SourceData'],'SupFig4E');
set(gcf,'currentaxes',ax4);cla
barplotn(data(1,:),data(2:end,:),'paired',[0 0 0],0);
timerange=[-.05 .05];
set(gca,'ylim',[-1.5 2],'xtick',-50:25:50,'xticklabel',-50:25:50,'xlim',1000*timerange,'fontsize',9);
hold on;plot([0,0],[-1.5 2],'r--');
xlabel('Time from light onset (ms)','fontsize',9);
ylabel('Firing rate relative\newline  to baseline (Hz)','fontsize',9)

%% Supplementary Figure 4F
data=xlsread([sourcedatapath,'SourceData'],'SupFig4F');
set(gcf,'currentaxes',ax5);cla
barplotn(data(1,:),data(2:end,:),'paired',[0 0 0],0);

set(gca,'ylim',[-1.5 2],'xtick',-50:25:50,'xticklabel',-50:25:50,'xlim',1000*timerange,'fontsize',9);
hold on;plot([0,0],[-1.5 2],'r--');
xlabel('Time from light onset (ms)','fontsize',9);
ylabel('Firing rate relative\newline  to baseline (Hz)','fontsize',9)
%% Figure 5: create subplots
figure(12);clf
arealabels={'M2','M1','AC','PL','IL','CL','SS','AI','OF'};
set(gcf,'windowstyle','normal','Units','centimeters','Position',[30 17 21.59 7]);
ax(1,1)=axes('Units','centimeters','Position',[3 2 7 3]);
ax(1,2)=axes('Units','centimeters','Position',[11 2 7 3]);
set(gcf,'Name','Figure 5')
set(gcf,'CurrentAxes',ax(1,1));cla
totalcounts=xlsread([sourcedatapath,'SourceData'],'Fig5H');

[~,order]=sort(mean(totalcounts),'descend');

[h,p]=barplotn(1:9,totalcounts(:,order),'paired',[.5 .5 .5],0);hold on
set(gca,'xticklabels',arealabels(order),'FontSize',7,'linewidth',1);
ylabel ('# of neurons');

%% Figure 5I
set(gcf,'CurrentAxes',ax(1,2));cla
data=xlsread([sourcedatapath,'SourceData'],'Fig5I', 'C2:J37');
totalcounts=sum(data);
data=squeeze(sum(reshape(data,9,4,8)));
ratios=data./repmat(totalcounts,4,1);
ratios(3:4,:)=ratios(3:4,:)*-1;

colors=[.25 .25 .25;.75 .75 .75;.25 .25 .25;.75 .75 .75];
b=bar(ratios','stacked');
    for o = 1:length(b)
        b(o).FaceColor=colors(o,:);
    end   

set(gca,'ytick',-.6:.2:1,'yticklabel',{'60','40','20','0','20','40','60','80','100'},'yLim',[-.6 1]);
set(gca,'xtick',1:8,'xticklabel',arealabels([1:5,7:9]),'TickDir','out','FontSize',7,'box','off');
text(4.5,-.5,'Contralateral','HorizontalAlignment','center','FontSize',7)
text(4.5,1.1,'Ipsilateral','HorizontalAlignment','center','FontSize',7)
l=legend(b(1:2),{'Upper layers','Lower layers'},'Box','off','Position',[0.7550    0.7025    0.1213    0.1016]);
ylabel('% of neurons')

%% Figure 6: create subplots
figure(13);clf
set(gcf,'windowstyle','normal','Units','centimeters','Position',[30 17 21.59 10]*1.1);
ax(2,1)=axes('Units','centimeters','Position',[3 6.5 4.25*3 3]*1.1);
ax(2,2)=axes('Units','centimeters','Position',[5 2 4.25 3]*1.1);
ax(2,3)=axes('Units','centimeters','Position',[14 2 4.25/3 3]*1.1);
set(gcf,'Name','Figure 6')

%% Figure 6A
set(gcf,'CurrentAxes',ax(2,1));cla
wt=xlsread([sourcedatapath,'SourceData'],'Fig6A_WT');
del=xlsread([sourcedatapath,'SourceData'],'Fig6A_DEL');
groupseparation=1;
wt_x=[1-groupseparation/2]:4:32+[1-groupseparation/2];
del_x=1+[groupseparation/2]:4:33+[groupseparation/2];
h_wt=plotSpread(wt(:,1:9),'xValues',wt_x,'distributionMarkers','o','distributionColors',wtcolor,'spreadwidth',5);
set(h_wt{1},'MarkerSize',5);
hold on
h_del=plotSpread(del(:,1:9),'xValues',del_x,'distributionMarkers','o','distributionColors',delcolor,'spreadwidth',5);
set(h_del{1},'MarkerSize',5);
plot([wt_x-[groupseparation/3];wt_x+[groupseparation/3]],[nanmean(wt(:,1:9));nanmean(wt(:,1:9))],'color','k','linewidth',2);
plot([del_x-[groupseparation/3];del_x+[groupseparation/3]],[nanmean(del(:,1:9));nanmean(del(:,1:9))],'color','k','linewidth',2);
ylabel('# of labeled neurons');
set(gca,'tickdir','out','xtick',mean([wt_x;del_x]),'xticklabel',arealabels,'fontsize',7);

%Add significance lines:
clear p
for n = 1:9
        p(n)=ranksum(wt(:,n),del(:,n));
    if(p(n)<.05);
        AddSignificanceLines(wt_x(n),del_x(n),'positive',p(n),10,0.1,.05);
    end
end
set(gca,'xlim',[-1 35]);
l=legend([ h_wt{1}(1), h_del{1}(1)],{'Wild-type','{\it Df(16)A}^{+/-}'},'orientation','horizontal','box','off','position',[0.3149    0.8903    0.2152    0.0465]);

%% Figure 6C
set(gcf,'CurrentAxes',ax(2,2));cla
wt=xlsread([sourcedatapath,'SourceData'],'Fig6C_WT');
del=xlsread([sourcedatapath,'SourceData'],'Fig6C_DEL');
separation=4.5;
wt_x=0.5:separation: 3*separation-separation+0.5;
del_x=1.5:separation:3*separation-separation+1+0.5;
h_wt=plotSpread(wt,'xValues',wt_x,'distributionMarkers','o','distributionColors',wtcolor);
set(h_wt{1},'MarkerSize',5);
hold on
h_del=plotSpread(del,'xValues',del_x,'distributionMarkers','o','distributionColors',delcolor);
set(h_del{1},'MarkerSize',5);
plot([wt_x-.25;wt_x+.25],[mean(wt);mean(wt)],'color','k','linewidth',2);
plot([del_x-.25;del_x+.25],[mean(del);mean(del)],'color','k','linewidth',2);
set(gca,'xticklabels',arealabels,'tickdir','out','xlim',[-1 12],'xtick',mean([wt_x;del_x]),'fontsize',7);
ylabel('# of neurons');
l=legend([ h_wt{1}(1), h_del{1}(1)],{'Wild-type','{\it Df(16)A}^{+/-}'},'orientation','horizontal','box','off');
set(l,'position',[0.2232    0.5002    0.2152    0.0466]);

%% Figure 6E
set(gcf,'CurrentAxes',ax(2,3));
data=xlsread([sourcedatapath,'SourceData'],'Fig6E');
wt=data(isfinite(data(:,1)),1);
del=data(isfinite(data(:,2)),2);
h=plotSpread({wt,del},'distributionMarker','o','distributionColor',{wtcolor,delcolor});
set(h{1},'MarkerSize',5);
ylabel('# of neurons');
set(gca,'tickdir','out','xtick','','fontsize',7);
plot([0.75,1.25],[mean(wt),mean(wt)],'color','k','linewidth',2);
plot([1.75,2.25],[mean(del),mean(del)],'color','k','linewidth',2);
%% Supplementary Figure 5: Create subplots
figure(14);clf
set(gcf,'windowstyle','normal','Units','centimeters','Position',[30 7 21.59 15]);
ax(3,1)=axes('Units','centimeters','Position',[3 10.5 12.75 3]);
ax(3,2)=axes('Units','centimeters','Position',[3 6 12.75 3]);
ax(3,3)=axes('Units','centimeters','Position',[3 1.5 12.75*5/9 3]);
ax(3,4)=axes('Units','centimeters','Position',[12 1.5 3 3]);
set(gcf,'Name','Supplementary Figure 5')

%% Supplementary Figure 5A-B:
groupseparation=1;
for n = 1:2
    switch n
        case 1
            wt=xlsread([sourcedatapath,'SourceData'],'SupFig5A_WT');
            del=xlsread([sourcedatapath,'SourceData'],'SupFig5A_DEL');
        case 2
            wt=xlsread([sourcedatapath,'SourceData'],'SupFig5B_WT');
            del=xlsread([sourcedatapath,'SourceData'],'SupFig5B_DEL');
    end
set(gcf,'CurrentAxes',ax(3,n));

wt_x=[1-groupseparation/2]:4:32+[1-groupseparation/2];
del_x=1+[groupseparation/2]:4:33+[groupseparation/2];
h_wt=plotSpread(wt,'xValues',wt_x,'distributionMarkers','o','distributionColors',wtcolor,'spreadwidth',5);
set(h_wt{1},'MarkerSize',5);
hold on
h_del=plotSpread(del,'xValues',del_x,'distributionMarkers','o','distributionColors',delcolor,'spreadwidth',5);
set(h_del{1},'MarkerSize',5);
plot([wt_x-[groupseparation/3];wt_x+[groupseparation/3]],[nanmean(wt(:,1:9));nanmean(wt(:,1:9))],'color','k','linewidth',2);
plot([del_x-[groupseparation/3];del_x+[groupseparation/3]],[nanmean(del(:,1:9));nanmean(del(:,1:9))],'color','k','linewidth',2);
ylabel('# of labeled neurons');
set(gca,'tickdir','out','xtick',mean([wt_x;del_x]),'xticklabel',arealabels,'fontsize',7);

%Add significance lines:
for n = 1:9
    p=ranksum(wt(:,n),del(:,n));
    if(p<.05);
        AddSignificanceLines(wt_x(n),del_x(n),'positive',p,10,0.1,.05);
    end
end
set(gca,'xlim',[-1 35]);
l=legend([ h_wt{1}(1), h_del{1}(1)],{'Wild-type','{\it Df(16)A}^{+/-}'},'orientation','horizontal','box','off','position',[0.3149    0.8903    0.2152    0.0465]);
end
%% Supplementary Figure 5C:
wt=xlsread([sourcedatapath,'SourceData'],'SupFig5C_WT');
del=xlsread([sourcedatapath,'SourceData'],'SupFig5C_DEL');
arealabels={'OF-M','OF-VL','OF-L','AC-D','AC-V'};
set(gcf,'CurrentAxes',ax(3,3));cla
h_wt=plotSpread(wt,'xValues',wt_x(1:5),'distributionMarkers','o','distributionColors',wtcolor,'spreadwidth',1);
set(h_wt{1},'MarkerSize',5)
hold on
h_del=plotSpread(del,'xValues',del_x(1:5),'distributionMarkers','o','distributionColors',delcolor,'spreadwidth',1.5);
set(h_del{1},'MarkerSize',5)
plot([wt_x(1:5)-[groupseparation/3];wt_x(1:5)+[groupseparation/3]],[nanmean(wt);nanmean(wt)],'color','k','linewidth',2);
plot([del_x(1:5)-[groupseparation/3];del_x(1:5)+[groupseparation/3]],[nanmean(del);nanmean(del)],'color','k','linewidth',2);
ylabel('# of labeled neurons');
set(gca,'tickdir','out','xtick',mean([wt_x;del_x]),'xticklabel',arealabels,'fontsize',7);
for n = 1:5
        p=ranksum(wt(:,n),del(:,n));
    if(p<.05);
        AddSignificanceLines(wt_x(n),del_x(n),'positive',p,10,0.1,.05);
    end
end
%% Supplementary Figure 5D:
set(gcf,'CurrentAxes',ax(3,4));cla
data=xlsread([sourcedatapath,'SourceData'],'SupFig5D');
a=plot(data(:,1),data(:,2),'o');
AddUnityLine;
box off
set(gca,'tickdir','out');
xlabel('# of neurons counted manually');
ylabel('# of neurons counted by algorithm');
set(gca,'fontsize',7);
a.MarkerSize=5;