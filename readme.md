# EV Charging Station Optimization

This repository contains code for optimizing the placement and capacity of electric vehicle (EV) charging stations. The project focuses on two key objective functions to determine optimal locations and the number of charging points.

## Objective Functions

### Objective 1: Screening Candidate Locations for Charging Stations

- **Purpose**: Optimize candidate locations for EV charging stations by analyzing the power grid's voltage stability factor (VSF) and traffic congestion.
- **Techniques**:
  - **Traffic Congestion**: Modeled using a **Bayesian Network**.
  - **Voltage Stability Factor (VSF)**: Calculated using a **Forward-Backward Sweep** method.
  
#### Function Photo
![Objective 1 Function](ob_1.jpg)<br />
Where P is for congestion and Jacobian Matrix is for VSF<br />

#### Result Photo
Results obtained from candidate selection
![Objective 1 Results](result_1.jpg)


### Objective 2: Minimizing Cost and Waiting Time

- **Purpose**: Minimize the overall cost and waiting time at charging stations.
- **Techniques**:
  - **Queuing Theory**: Used to model waiting time.
  - **Teaching-Learning-Based Optimization (TLBO)**: Optimizes the number of charging stations and points at each location.

#### Function Photo
![Objective 2 Function](ob_2.jpg)<br />
Where<br />
m= number of candidate locations<br />
x=Number of charging stations at each locations<br />
y=Number of charging points at each stations<br />
C=Total cost of charging stations<br />
ρ=Utilization rate of charging stations<br />
λ=Arrival rate of EVs in charging stations<br />
P=Probability of no EVs waiting in charging stations<br />

#### Result Photo
![Objective 2 Results](result_2.jpg)<br />
Results[x,y]<br />
Where<br />
x=Number of charging stations at each locations<br />
y=Number of charging points at each stations<br />

## For more detailed explanation access file named TP.pdf

## How to Run the Project

### Installation
1. Ensure MATLAB is installed on your system.
2. Clone this repository to your local machine
-Installation of EV charging Stations
The comments contain the information about which index in a given array/structure contains which info so all those can be changed accordingly.
1. Open all codes in matlab 
2. First run VSF code
3. Run congestion code
4. Run candidate code->Gives Candidate Locations
5. Run TBLO code->Gives number of charging stations per loaction and number of charging points per station
