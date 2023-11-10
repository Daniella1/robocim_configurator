<p align="center">
    <img alt="ViewCount" src="https://views.whatilearened.today/views/github/Daniella1/robocim_configurator.svg">
    <br>
    Counting since 10-11-2023
</p>

# Example Configurator For Robot Systems
The devices and manufacturers are anonymized.

## Runing the code
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

## RoboCIM paper and Citation Info

Check out the paper on [CEUR](https://ceur-ws.org/Vol-2956/paper12.pdf).

If the configurator helped you in your research, please cite

```
@inproceedings{Tola2021,
  title = {{RoboCIM: Towards a Domain Model for Industrial Robot System Configurators}},
  author = "Daniella Tola and {Gon{\c c}alves Gomes}, {Cl{\'a}udio {\^A}ngelo} and Schultz, {Carl Peter Leslie} and Christian Schlette and Casper Hansen and Lukas               Esterle",
  year = "2021",
  language = "English",
  series = "CEUR Workshop Proceedings",
  publisher = "CEUR-WS.org",
  editor = "Ahmet Soylu and Nezhad, {Alireza Tamaddoni} and Nikolay Nikolov and Ioan Toma and Anna Fensel and Joost Vennekens",
  booktitle = "Proceedings of the 15th International Rule Challenge, 7th Industry Track, and 5th Doctoral Consortium",
  keywords={publication}
}
```
