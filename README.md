# robocim_configurator

The code can be run by installing clingo, and typing the following in a command line:

```
clingo solver.lp 0 -c product_count=4 -c req_payload_g=950
```
The -c is used when specifying constants. In this case we specify the amount of products we want in a configuration to be 4, and we specify that the payload required is 950 grams.

Constant values that can be specified, are:
- product_count
- req_payload_g
- req_reach_mm
- req_application (can be one of the elements {screwdriving, pick_n_place})
- exclude_justification
