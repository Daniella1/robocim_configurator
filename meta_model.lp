
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Universal Configuration facts   %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The types of justifications that can be used
justification(primary; secondary; empirical_test; observation).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Universal Configuration Rules   %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
config_entity(I) :- port(P,I,X). % a port IS A configuration entity
config_entity(X) :- port_container(X). % a port_container IS A configuration entity
port_container(X) :- product(X). % a product IS A port container
port_container(S) :- series_has_product(S,X). % a product series IS A port container
config_entity(X) :- series_has_product(S,X). % if a series has a product, then that product is at least a config_entity (In order to define domain constraints on non-instantiated products)
port_container(X) :- port(P,I,X). % if a port belongs to a product, then that product is at least a port_container (In order to define domain constraints on non-instantiated products)

% inheritance of attributes and ports
port(P,I,X) :- port(P,I,Y), series_has_product(Y, X), port_container(X).
has_primitive_attr(X,I,V,J,S) :- has_primitive_attr(Y,I,V,J,S), series_has_product(Y,X).
has_interval_attr(X,I,V1,V2,J1,J2,S1,S2) :- has_interval_attr(Y,I,V1,V2,J1,J2,S1,S2), series_has_product(Y,X).

% two ports are compatible if have same port type with different orientation. These ports must belong to products.
compatible(P1,A,P2,B) :-
  port(P1,I1,A),
  port(P2,I2,B),
  product_instance(_,A),
  product_instance(_,B),
  has_primitive_attr(I1,input,V,_,_),
  has_primitive_attr(I2,output,V,_,_),
  not -compatible(P1,A,P2,B). 

%% product incompatibility implies port incompatibility
-compatible(P1,A,P2,B) :-
  incompatible_neighbours(A,B),
  port(P1,I1,A),
  port(P2,I2,B).

%% incompatibility is symmetric
-compatible(P1,A,P2,B) :- -compatible(P2,B,P1,A).

%%%%%%%%
% Product level incompatibility

% compatibility is symmetric
compatible(P1,A,P2,B) :- compatible(P2,B,P1,A).

%% product incompatibility is symmetric
incompatible_neighbours(A,B) :- incompatible_neighbours(B,A).
incompatible_products(A,B) :- incompatible_products(B,A).

% incompatible product and series: If a series is incompatible with a product, the complete series inherits this incompatibility property
incompatible_products(X,B) :- incompatible_products(A,B), series_has_product(A,X).
incompatible_products(X,B,C) :- incompatible_products(A,B,C), series_has_product(A,X).

% If products are incompatible, then we do not include their configurations
:- incompatible_products(A,B,C), product_instance(_,A),product_instance(_,B),product_instance(_,C).
:- incompatible_products(A,B), product_instance(_,A),product_instance(_,B).

%%%%%%%%%


%% A configuration is a set of product instances
product_id(1..product_count). %% this predicate is used to specify the number of product
                 %% instances that should be in a configuration
                 %% The upper number is a parameter that can be set to any positive integer
                 %% The max number can be incrementally increased to some user-specified
                 %% upper bound (will be implemented using ASP's multi-shot solving)

%% each product is assigned exactly one type
1{product_instance(Id, T) : product(T)}1 :- product_id(Id).

%% symmetry breaking for product type assignment:
%% assign smaller product IDs to (lexigraphically) smaller types 
:- product_instance(P1,T1), product_instance(P2,T2), P1 < P2, T1 > T2.

% each product port can be connected to (at most) one other port
{connect(P1,Port1,P2,Port2) :
   product_instance(T2,P2), port(Port2,I2, P2), compatible(Port1,P1,Port2,P2)
}1 :- product_instance(T1,P1), port(Port1,I1,P1).

% connection is symmetric
connect(P1,Port1,P2,Port2) :- connect(P2,Port2,P1,Port1).

%% all selected products in the configuration must be transitively connected
contact_(P1,P2) :- connect(P1,_,P2,_).
contact_(P1,P3) :- contact_(P1,P2), contact_(P2,P3).
:- product_instance(_,P1), product_instance(_,P2), P1 != P2, not contact_(P1,P2).

% The same product cannot be instantiated twice.
:- product_instance(T1,P), product_instance(T2,P), T1 != T2.

%% Each port type of a product must be used
:- product_instance(_,P), port(Port,I,P), not connect(P,Port,_,_).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Universal Configuration Constraints %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Configuration Entity Constraints
:- has_primitive_attr(X,A,_,_,_), not config_entity(X). 
:- has_interval_attr(X,_,_,_,_,_,_,_), not config_entity(X).
%%% Port constraints
:- port(P,I,N), not port_container(N).
:- port(P,I,X), not has_primitive_attr(I,input,_,_,_), not has_primitive_attr(I,output,_,_,_). % ports can only have primitive_attributes, which are either input or output
%%% Product constraints
:- product_instance(_,X), not port(_,_,X).% A product instance must contain a port TODO: test this
%%% Product series constraints
:- series_has_product(S,X), S = X. % a series cannot be it's own product
:- series_has_product(S,X), series_has_product(X,S). % a product series relationship with a product is NOT symmetric.
%%% Attribute Constraints
:- has_primitive_attr(_,_,_,J,_), not justification(J). % A value must contain a justification.
:- has_primitive_attr(_,_,_,_,S), not source(S). % A value must contain a source of justification/evidence.
:- has_interval_attr(_,_,_,_,J1,_,_,_), not justification(J1).% A value must contain a source of justification/evidence.
:- has_interval_attr(_,_,_,_,_,J2,_,_), not justification(J2). % A value must contain a source of justification/evidence.
:- has_interval_attr(_,_,_,_,_,_,S1,_), not source(S1).
:- has_interval_attr(_,_,_,_,_,_,_,S2), not source(S2).
:- has_interval_attr(_,_,V1,V2,_,_,_,_), V1 > V2. % lower_bound must be less than upper_bound



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%% User Constraints %%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Only accept products that we know their type is evidented by primary or secondary sources.
:- product_instance(1..product_count,A), not has_primitive_attr(A,type,_,primary,_), not has_primitive_attr(A,type,_,secondary,_).

% Tell me how the product port is justified
justification(A, T, J):- product_instance(1..product_count,A), port(T,P,A), has_primitive_attr(P,_,_,J,_).

% We exclude configurations where the justification is exclude_justification
:- product_instance(1..product_count,A), justification(A,_,exclude_justification).

