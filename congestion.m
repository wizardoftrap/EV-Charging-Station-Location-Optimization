clc;
%Traffic Data
area_type = ["Market"; "Office"; "Residents"; "School"; "Factory"; "Hospital"];
%index to perticular area is fixed every where as same as area_type
total_node=16;
numbers=[4,3,5,1,2,1];
%1->low,2->high later change to high low
area_traffic_flow = [struct('area_type',area_type(1), 'weekdayM',1, 'weekdayA',1, 'weekdayE',2, 'weekendM',2, 'weekendA',2, 'weekendE',2),
    struct('area_type',area_type(2), 'weekdayM',2, 'weekdayA',1, 'weekdayE',2, 'weekendM',1, 'weekendA',1, 'weekendE',1),
    struct('area_type',area_type(3), 'weekdayM',2, 'weekdayA',1, 'weekdayE' ,2,'weekendM',1, 'weekendA',1, 'weekendE',2),
    struct('area_type',area_type(4), 'weekdayM',2,'weekdayA',1, 'weekdayE' ,2,'weekendM',1, 'weekendA',1, 'weekendE',1),
    struct('area_type',area_type(5), 'weekdayM' ,2,'weekdayA',1, 'weekdayE',2, 'weekendM',1, 'weekendA' ,1,'weekendE',1),
    struct('area_type',area_type(6), 'weekdayM',1, 'weekdayA' ,1,'weekdayE',2, 'weekendM',1, 'weekendA',2, 'weekendE',2)
];
% probability of area type e.g. P(A=R)
p_type=[];
for i=1:length(area_type)
    p_type=[p_type,numbers(i)/total_node];
end
% probability of high traffic flow e.g. P(C=H)
count_high=0;
count_high_area=[];
for i=1:length(area_type)
    count=0;
    if area_traffic_flow(i).weekdayM==2
        count_high=count_high+1;
        count=count+1;
    end
    if area_traffic_flow(i).weekdayA==2
        count_high=count_high+1;
        count=count+1;
    end
    if area_traffic_flow(i).weekdayE==2
        count_high=count_high+1;
        count=count+1;
    end
    if area_traffic_flow(i).weekendM==2
        count_high=count_high+1;
        count=count+1;
    end
    if area_traffic_flow(i).weekendA==2
        count_high=count_high+1;
        count=count+1;
    end
    if area_traffic_flow(i).weekendE==2
        count_high=count_high+1;
        count=count+1;
    end
    count_high_area=[count_high_area,count];

end
p_high=count_high/(6*length(p_type));
% probability of high traffic flow given the area e.g. P(C=H|A=R)
p_high_area=[];
for i=1:length(area_type)
    p=count_high_area(i)/6;
    p_high_area=[p_high_area,p];
end
% Congestion probability P=P(A=R|C=H)=>P(R)*P(C=H|A=R)/P(C=H)->Bayes' theorem
p_congestion=[];
for i=1:length(area_type)
    p=p_type(i)*p_high_area(i)/p_high;
    p_congestion=[p_congestion,p];
end
p_type;
p_high_area;
p_high;
p_congestion;
fprintf('Congestion of each area type:\n')
fprintf('Market:%0.4f \nOffice:%0.4f \nResidents:%0.4f \nSchool:%0.4f \nFactory:%0.4f \nHospital:%0.4f\n',p_congestion(1),p_congestion(2),p_congestion(3),p_congestion(4),p_congestion(5),p_congestion(6))




