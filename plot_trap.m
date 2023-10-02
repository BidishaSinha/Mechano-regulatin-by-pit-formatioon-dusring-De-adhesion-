%%
clear;clc;
name = "pl7_003.txt";
name1 = convertStringsToChars(name);
name2 = strrep(name1,'_','-');
a = load(name);
for ii=1:20
    ccc1 = ((ii-1)*50)+1;
    ccc2 = (ii*50); 
    bbb1 = std(a(ccc1:ccc2,2));
    k_all(ii,:) = 4.278/((bbb1*65)^2);
end  
k_net = mean(k_all)
a11 = median(a(1:100,2));
% bbb = std(a(1:100,2));
% k = 4.278/((bbb*65)^2);
for i=1:(length(a))
    b(i,:)=((a(i,2)-a11)*k_net*65);
    t(i,:)= (i*0.005);
end
% total = [t,b];

plot(t,b);ylabel('Force (pN)');xlabel('Time (sec)');title([name2(1:end-4), "Date - 06.08.22"]);ylim([-50 70]);grid on; hold on;
%%
n = input("Enter number of points for fitting :");

for jj = 1:n
    plot(t,b,'-r'); ylim([-30 40]);ylabel('Force (pN)');xlabel('Time (sec)');title([name2(1:end-4), "Date - 04.08.22"]);
    clear x y ind1 ind2 data_fit fitted_curve gof
    [x,y]=ginput
    ind1 = find(t==(round(x(1)*100)/100));
    ind2 = find(t==(round(x(2)*100)/100));
    data_fit = b(ind1:ind2);
    fitfun = fittype( @(c,x) (c + (0*x)) );
    [fitted_curve,gof] = fit(x,y,fitfun)
    %pause(10)
end

