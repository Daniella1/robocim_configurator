
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Domain Configuration facts   %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Source of Data sheets
source(datasheetA; datasheetB; datasheetC; datasheetD).
% Source of Observations
source(obs_diff_koala_a_b; catomatic_tool_elec_conn;).

%%% Robotic arms
series_has_product(robotarm, koala).
series_has_product(robotarm, dingo).

series_has_product(koala, koala_a).
series_has_product(koala, koala_b).
series_has_product(koala_a, koala_1a).
series_has_product(koala_a, koala_2a).
series_has_product(koala_a, koala_3a).
series_has_product(koala_b, koala_1b).
series_has_product(koala_b, koala_2b).
series_has_product(koala_b, koala_3b).

series_has_product(koala, koala_1).
series_has_product(koala_1, koala_1a).
series_has_product(koala_1, koala_1b).

series_has_product(koala, koala_2).
series_has_product(koala_2, koala_2a).
series_has_product(koala_2, koala_2b).

series_has_product(koala, koala_3).
series_has_product(koala_3, koala_3a).
series_has_product(koala_3, koala_3b).

has_primitive_attr(robotarm, type, robotarm, primary, datasheetA).

has_primitive_attr(koala_1, payload_g, 1000, primary, datasheetA).
has_primitive_attr(koala_2, payload_g, 2000, primary, datasheetA).
has_primitive_attr(koala_3, payload_g, 3000, primary, datasheetA).

has_primitive_attr(koala_1, reach_mm, 100, primary, datasheetA).
has_primitive_attr(koala_2, reach_mm, 200, primary, datasheetA).
has_primitive_attr(koala_3, reach_mm, 300, primary, datasheetA).

port(robotarm_mech, robotarm_mech_A, koala).
has_primitive_attr(robotarm_mech_A, input, robot_flange_iso_9409_1_50, primary, datasheetA).

port(robotarm_data_conn_sw,robotarm_data_conn_sw_A, koala).
has_primitive_attr(robotarm_data_conn_sw_A, output, modbus_tcp_robot, primary, datasheetA).
port(robotarm_data_conn_physical,robotarm_data_conn_physical_A, koala).
has_primitive_attr(robotarm_data_conn_physical_A, output, modbus_physical, primary, datasheetA).

port(robotarm_elec,robotarm_koala_elec1, koala_a).
has_primitive_attr(robotarm_koala_elec1, output, koala_a_elec, observation, obs_diff_koala_a_b).
port(robotarm_elec,robotarm_koala_elec2, koala_b).
has_primitive_attr(robotarm_koala_elec2, output, koala_b_elec, observation, obs_diff_koala_a_b).

series_has_product(dingo, dingo_a).
series_has_product(dingo, dingo_b).

port(robotarm_mech, robotarm_mech_B, dingo_a).
has_primitive_attr(robotarm_mech_B, input, robot_flange_iso_9409_1_31_5, secondary, datasheetB).
port(robotarm_data_conn_sw,robotarm_data_conn_sw_B, dingo).
has_primitive_attr(robotarm_data_conn_sw_B, output, ethernet_ip_robot, primary, datasheetA).
port(robotarm_data_conn_physical,robotarm_data_conn_physical_B, dingo).
has_primitive_attr(robotarm_data_conn_physical_B, output, ethernet_port, primary, datasheetA).
port(robotarm_elec,robotarm_dingo_elec1, dingo).
has_primitive_attr(robotarm_dingo_elec1, output, dingo_elec, observation, obs_diff_koala_a_b).

port(robotarm_mech, robotarm_mech_dingob, dingo_b).
has_primitive_attr(robotarm_mech_dingob, input, robot_flange_iso_9409_1_50, primary, datasheetA).

%%% EECDs
series_has_product(eecd, catomatic_eecd_series).
has_primitive_attr(eecd, type, eecd, primary, datasheetB).

% catomatic
series_has_product(catomatic_eecd_series, catomatic_eecd).
series_has_product(catomatic_eecd_series, catomatic_eecd_io).
series_has_product(catomatic_eecd_series, catomatic_eecd_3A).

port(eecd_mech_robot, eecd_mech1, catomatic_eecd_series).
has_primitive_attr(eecd_mech1, output, robot_flange_iso_9409_1_50, primary, datasheetA).

port(eecd_mech_tool,eecd_mech2, catomatic_eecd_series).
has_primitive_attr(eecd_mech2, output, catomatic_tool_coupling, primary, datasheetA).

port(eecd_elec_tool,eecd_elec1, catomatic_eecd_series).
has_primitive_attr(eecd_elec1, output, catomatic_tool_elec, observation, catomatic_tool_elec_conn).

port(eecd_elec_robot,eecd_elec2, catomatic_eecd).
port(eecd_elec_robot,eecd_elec2, catomatic_eecd_3A).
has_primitive_attr(eecd_elec2, input, koala_a_elec, observation, obs_diff_koala_a_b).
has_primitive_attr(eecd_elec2, input, koala_b_elec, observation, obs_diff_koala_a_b).
has_primitive_attr(eecd_elec2, input, dingo_elec, observation, catomatic_tool_elec_conn).

port(eecd_elec_robot, eecd_elec3, catomatic_eecd_io).
has_primitive_attr(eecd_elec3, input, koala_b_elec, observation, obs_diff_koala_a_b).


%%% End effectors
series_has_product(end_effector, catomatic_end_effectors).
has_primitive_attr(end_effector, type, end_effector, primary, datasheetC).

series_has_product(catomatic_end_effectors, catomatic_screwdriver).
has_primitive_attr(catomatic_screwdriver, subtype, screwdriver, primary, datasheetC).

series_has_product(catomatic_end_effectors, catomatic_grippers).
series_has_product(catomatic_grippers, catomatic_gripperA).
series_has_product(catomatic_grippers, catomatic_gripperB).
series_has_product(catomatic_grippers, catomatic_gripperC).
series_has_product(catomatic_grippers, catomatic_gripperD).
series_has_product(catomatic_grippers, catomatic_gripperE).
has_primitive_attr(catomatic_grippers, subtype, gripper, primary, datasheetC).

port(end_effector_elec,ct_end_effector_elec, catomatic_end_effectors).
has_primitive_attr(ct_end_effector_elec, input, catomatic_tool_elec, primary, datasheetC).

port(end_effector_mech, ct_end_effector_mech, catomatic_end_effectors).
has_primitive_attr(ct_end_effector_mech, input, catomatic_tool_coupling, primary, datasheetC).
port(end_effector_data, ct_end_effector_data,catomatic_grippers).
has_primitive_attr(ct_end_effector_data, input, modbus_rtu_tool, primary, datasheetC).
has_primitive_attr(ct_end_effector_data, input, ethernet_ip_tool, primary, datasheetC).

port(end_effector_data, ct_end_effector_data_sd,catomatic_screwdriver).
has_primitive_attr(ct_end_effector_data_sd, input, modbus_tcp_tool, primary, datasheetC).
has_primitive_attr(ct_end_effector_data_sd, input, ethernet_ip_tool, primary, datasheetC).


%%% Data Connections
has_primitive_attr(catomatic_data_cable, type, data_connection, primary, datasheetD).
port(data_conn_tool,c_data_connA, catomatic_data_cable).
has_primitive_attr(c_data_connA, output, modbus_rtu_tool, primary, datasheetD).
port(data_conn_robot,c_data_connB, catomatic_data_cable).
has_primitive_attr(c_data_connB, input, modbus_tcp_robot, primary, datasheetD).
port(data_conn_physical, c_data_conn_physical, catomatic_data_cable).
has_primitive_attr(c_data_conn_physical, input, modbus_physical, primary, datasheetD).


has_primitive_attr(catomatic_data_controller, type, data_connection, primary, datasheetD).
port(data_conn_tool,ctrl_data_conn_tool, catomatic_data_controller).
has_primitive_attr(ctrl_data_conn_tool, output, modbus_tcp_tool, primary, datasheetD).
has_primitive_attr(ctrl_data_conn_tool, output, modbus_rtu_tool, primary, datasheetD).
has_primitive_attr(ctrl_data_conn_tool, output, ethernet_ip_tool, primary, datasheetD).
port(data_conn_robot, ctrl_data_conn_robot, catomatic_data_controller).
has_primitive_attr(ctrl_data_conn_robot, input, modbus_tcp_robot, primary, datasheetD).
has_primitive_attr(ctrl_data_conn_robot, input, ethernet_ip_robot, primary, datasheetD).
port(data_conn_physical, ctrl_data_conn_physical, catomatic_data_controller).
has_primitive_attr(ctrl_data_conn_physical, input, modbus_physical, primary, datasheetD).
has_primitive_attr(ctrl_data_conn_physical, input, ethernet_port, primary, datasheetD).

%%% Flange Adapters
has_primitive_attr(flange_adapter_A, type, flange_adapter, primary, datasheetA).
port(mech_in, fa_mech_in,flange_adapter_A).
has_primitive_attr(fa_mech_in, output, robot_flange_iso_9409_1_31_5, primary, datasheetD).
port(mech_out, fa_mech_out,flange_adapter_A).
has_primitive_attr(fa_mech_out, input, robot_flange_iso_9409_1_50, primary, datasheetD).

%% Incompatible products:
incompatible_products(catomatic_screwdriver, catomatic_eecd_io).
incompatible_products(koala_a, catomatic_eecd_io).
incompatible_products(catomatic_data_controller, catomatic_eecd_io).

incompatible_products(koala_b, catomatic_eecd, catomatic_data_cable).
incompatible_products(koala_b, catomatic_eecd_3A, catomatic_data_cable).

% If two products cannot be directly connected, then they are incompatible neighbours
incompatible_neighbours(catomatic_screwdriver, catomatic_eecd).

%%% Applications
application(screwdriving, screwdriver).
application(pick_n_place, gripper).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Domain Configuration Constraints  %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% If a product is of type robotarm, then it must have a robotarm_mech port
:- product_instance(_,X), has_primitive_attr(X,type,robotarm,_,_), not port(robotarm_mech,_,X). 

% Products of type: robotarm, eecd, end_effector, and data_conn, must be exist in the configuration.
:- not {product_instance(1..product_count,A): has_primitive_attr(A,type,robotarm,_,_)} = 1.
:- not {product_instance(1..product_count,A): has_primitive_attr(A,type,eecd,_,_)} = 1.
:- not {product_instance(1..product_count,A): has_primitive_attr(A,type,end_effector,_,_)} = 1.
:- not {product_instance(1..product_count,A): has_primitive_attr(A,type,data_connection,_,_)} = 1.

% User requirement about payload [g] and reachability [mm]
:- product_instance(_,A), has_primitive_attr(A, type, robotarm,_,_), has_primitive_attr(A, payload_g, X,_,_), req_payload_g > X.
:- product_instance(_,A), has_primitive_attr(A, type, robotarm,_,_), has_primitive_attr(A, reach_mm, X,_,_), req_reach_mm > X.

% Application selection
:- application(req_application,A), product_instance(_,P), has_primitive_attr(P, type,end_effector,_,_), not has_primitive_attr(P, subtype, A,_,_).

%%%%%%%%%