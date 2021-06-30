
% include other files
#include "meta_model.lp".
#include "domain_model.lp".
#include "product_catalogue.lp".


% default user requirements
#const product_count = 4.
#const exclude_justification = empirical_test.
#const req_payload_g = 50.
#const req_reach_mm = 50.
#const req_application = none.


% Show results of valid configurations
#show product_instance/2.

