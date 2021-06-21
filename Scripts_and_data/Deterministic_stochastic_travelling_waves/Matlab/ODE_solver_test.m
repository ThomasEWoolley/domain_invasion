ccc

load AllData_L_2_W_10.mat

for i=1:10
    for j=1:length(Stringdata{i})
        YStringdata{i}{j}=['y',Stringdata{i}{j}{1}];
    end
end

% for i=1:10
%     s=GoodA(i);
%     eval(['syms y',GoodA{i},'(t)'])
%     
%     for j=1:length(Stringdata{i})
%         if strcmp(s,Stringdata{i}{j})
%         end
% 
%     end
% end
% 
