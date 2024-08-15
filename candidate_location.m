
clc;
area_type = ["Market"; "Office"; "Residents"; "School"; "Factory"; "Hospital"];
node_vsf=[];
Total_vsf=0;
for i=1:16
    
    for j=1:16
        Total_vsf=Total_vsf+Jacobian(i,j);
    end
end
for i=1:16
    sum=0;
    for j=1:16
        sum=sum+Jacobian(i,j);
    end
    node_vsf=[node_vsf,sum];
end
node_vsf;
%Node specifications
nodes=[];
nodes=[nodes,struct('node_no',1,'area_type',area_type(2),'congestion',p_congestion(2),'vsf',node_vsf(1),'x',0,'y',0)];
nodes=[nodes,struct('node_no',2,'area_type',area_type(2),'congestion',p_congestion(2),'vsf',node_vsf(2),'x',1,'y',0)];
nodes=[nodes,struct('node_no',3,'area_type',area_type(3),'congestion',p_congestion(3),'vsf',node_vsf(3),'x',1,'y',1)];
nodes=[nodes,struct('node_no',4,'area_type',area_type(3),'congestion',p_congestion(3),'vsf',node_vsf(4),'x',2,'y',1)];
nodes=[nodes,struct('node_no',5,'area_type',area_type(1),'congestion',p_congestion(1),'vsf',node_vsf(5),'x',2,'y',0)];
nodes=[nodes,struct('node_no',6,'area_type',area_type(1),'congestion',p_congestion(1),'vsf',node_vsf(6),'x',2,'y',-1)];
nodes=[nodes,struct('node_no',7,'area_type',area_type(3),'congestion',p_congestion(3),'vsf',node_vsf(7),'x',3,'y',-1)];
nodes=[nodes,struct('node_no',8,'area_type',area_type(6),'congestion',p_congestion(6),'vsf',node_vsf(8),'x',3,'y',0)];
nodes=[nodes,struct('node_no',9,'area_type',area_type(3),'congestion',p_congestion(3),'vsf',node_vsf(9),'x',3,'y',1)];
nodes=[nodes,struct('node_no',10,'area_type',area_type(1),'congestion',p_congestion(1),'vsf',node_vsf(10),'x',4,'y',0)];
nodes=[nodes,struct('node_no',11,'area_type',area_type(2),'congestion',p_congestion(2),'vsf',node_vsf(11),'x',4,'y',-1)];
nodes=[nodes,struct('node_no',12,'area_type',area_type(1),'congestion',p_congestion(1),'vsf',node_vsf(12),'x',5,'y',0)];
nodes=[nodes,struct('node_no',13,'area_type',area_type(4),'congestion',p_congestion(4),'vsf',node_vsf(13),'x',5,'y',1)];
nodes=[nodes,struct('node_no',14,'area_type',area_type(3),'congestion',p_congestion(3),'vsf',node_vsf(14),'x',4,'y',1)];
nodes=[nodes,struct('node_no',15,'area_type',area_type(5),'congestion',p_congestion(5),'vsf',node_vsf(15),'x',6,'y',0)];
nodes=[nodes,struct('node_no',16,'area_type',area_type(5),'congestion',p_congestion(5),'vsf',node_vsf(16),'x',6,'y',-1)];
%node_score=congestion-vsf/total_vsf-->Maximise
node_score=[];
for i = 2:length(nodes)
    node_score=[node_score,struct('node_no',i,'score',nodes(i).congestion-nodes(i).vsf/Total_vsf)];
end
temp = struct2table(node_score); 
sorted_temp = sortrows(temp,'score', 'descend'); 
sorted_node = table2struct(sorted_temp);
disp('All nodes and their scores in descending order:')
disp('Nodes->(Score)');
     for i=1:length(sorted_node)
     
        fprintf('%d->(%.4f)\n',sorted_node(i).node_no,sorted_node(i).score)
     end
 candidate_node=[];
 %assigning first best score
 for i=1:length(sorted_node)
            if (nodes(sorted_node(i).node_no).area_type)~='Residents'
                 candidate_node=[candidate_node,nodes(sorted_node(i).node_no)];
                 break;
            end
 end
     

 for i=2:length(sorted_node)%threshhold
    check_near=true;
    for j=1:length(candidate_node)
            if sqrt((nodes(sorted_node(i).node_no).x-candidate_node(j).x)^2+(nodes(sorted_node(i).node_no).y-candidate_node(j).y)^2)<2
                %abs(sorted_node(i).node_no-candidate_node(j).node_no)<2
                check_near=false;
            end
            if (nodes(sorted_node(i).node_no).area_type)=='Residents'
                check_near=false;
            end
    end
     if check_near
         candidate_node=[candidate_node,nodes(sorted_node(i).node_no)];
     end
 end
fprintf('Selected Candidates:\n');
for i=1:length(candidate_node)
   fprintf('%d\n',candidate_node(i).node_no);
end
