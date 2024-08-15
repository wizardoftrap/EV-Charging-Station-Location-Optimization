# EV Charging Station Optimization

This repository contains code for optimizing the placement and capacity of electric vehicle (EV) charging stations. The project focuses on two key objective functions to determine optimal locations and the number of charging points.

## Objective Functions

### Objective 1: Screening Candidate Locations for Charging Stations

- **Purpose**: Optimize candidate locations for EV charging stations by analyzing the power grid's voltage stability factor (VSF) and traffic congestion.
- **Techniques**:
  - **Traffic Congestion**: Modeled using a **Bayesian Network**.
  - **Voltage Stability Factor (VSF)**: Calculated using a **Forward-Backward Sweep** method.
  
#### Function Photo
![Objective 1 Function](path/to/objective1_function_image.png)

#### Result Photo
![Objective 1 Results](path/to/objective1_result_image.png)

### Objective 2: Minimizing Cost and Waiting Time

- **Purpose**: Minimize the overall cost and waiting time at charging stations.
- **Techniques**:
  - **Queuing Theory**: Used to model waiting time.
  - **Teaching-Learning-Based Optimization (TLBO)**: Optimizes the number of charging stations and points at each location.

#### Function Photo
![Objective 2 Function](path/to/objective2_function_image.png)

#### Result Photo
![Objective 2 Results](path/to/objective2_result_image.png)

## How to Run the Project

### Installation
1. Ensure MATLAB is installed on your system.
2. Clone this repository to your local machine using the following command:
   ```bash
   git clone https://github.com/yourusername/ev-charging-station-optimization.git
