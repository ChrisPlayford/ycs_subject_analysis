* 6th January 2017

* Dr Chris Playford
* Youth Cohort Study - Latent Class Analysis

* SOC2000 code labels - called from other files

label define soc2000 ///
1111 "Senior officials in national government" ///
1112 "Directors and chief executives of major organisations" ///
1113 "Senior officials in local government" ///
1114 "Senior officials of special interest organisations" ///
1121 "Production, works and maintenance managers" ///
1122 "Managers in construction" ///
1123 "Managers in mining and energy" ///
1131 "Financial managers and chartered secretaries" ///
1132 "Marketing and sales managers" ///
1133 "Purchasing managers" ///
1134 "Advertising and public relations managers" ///
1135 "Personnel, training and industrial relations managers" ///
1136 "Information and communication technology managers" ///
1137 "Research and development managers" ///
1141 "Quality assurance managers" ///
1142 "Customer care managers" ///
1151 "Financial institution managers" ///
1152 "Office managers" ///
1161 "Transport and distribution managers" ///
1162 "Storage and warehouse managers" ///
1163 "Retail and wholesale managers" ///
1171 "Officers in armed forces" ///
1172 "Police officers (inspectors and above)" ///
1173 "Senior officers in fire, ambulance, prison and related services" ///
1174 "Security managers" ///
1181 "Hospital and health service managers" ///
1182 "Pharmacy managers" ///
1183 "Healthcare practice managers" ///
1184 "Social services managers" ///
1185 "Residential and day care managers" ///
1211 "Farm managers" ///
1212 "Natural environment and conservation managers" ///
1219 "Managers in animal husbandry, forestry and fishing n.e.c." ///
1221 "Hotel and accommodation managers" ///
1222 "Conference and exhibition managers" ///
1223 "Restaurant and catering managers" ///
1224 "Publicans and managers of licensed premises" ///
1225 "Leisure and sports managers" ///
1226 "Travel agency managers" ///
1231 "Property, housing and land managers" ///
1232 "Garage managers and proprietors" ///
1233 "Hairdressing and beauty salon managers and proprietors" ///
1234 "Shopkeepers and wholesale/retail dealers" ///
1235 "Recycling and refuse disposal managers" ///
1239 "Managers and proprietors in other services n.e.c." ///
2111 "Chemists" ///
2112 "Biological scientists and biochemists" ///
2113 "Physicists, geologists and meteorologists" ///
2121 "Civil engineers" ///
2122 "Mechanical engineers" ///
2123 "Electrical engineers" ///
2124 "Electronics engineers" ///
2125 "Chemical engineers" ///
2126 "Design and development engineers" ///
2127 "Production and process engineers" ///
2128 "Planning and quality control engineers" ///
2129 "Engineering professionals n.e.c." ///
2131 "IT strategy and planning professionals" ///
2132 "Software professionals" ///
2211 "Medical practitioners" ///
2212 "Psychologists" ///
2213 "Pharmacists/pharmacologists" ///
2214 "Ophthalmic opticians" ///
2215 "Dental practitioners" ///
2216 "Veterinarians" ///
2311 "Higher education teaching professionals" ///
2312 "Further education teaching professionals" ///
2313 "Education officers, school inspectors" ///
2314 "Secondary education teaching  professionals" ///
2315 "Primary and nursery education teaching professionals" ///
2316 "Special needs education teaching professionals" ///
2317 "Registrars and senior administrators of educational establishments" ///
2319 "Teaching professionals n.e.c." ///
2321 "Scientific researchers" ///
2322 "Social science researchers" ///
2329 "Researchers n.e.c." ///
2411 "Solicitors and lawyers, judges and coroners" ///
2419 "Legal professionals n.e.c." ///
2421 "Chartered and certified accountants" ///
2422 "Management accountants" ///
2423 "Management consultants, actuaries, economists and statisticians" ///
2431 "Architects" ///
2432 "Town planners" ///
2433 "Quantity surveyors" ///
2434 "Chartered surveyors (not quantity surveyors)" ///
2441 "Public service administrative professionals" ///
2442 "Social workers" ///
2443 "Probation officers" ///
2444 "Clergy" ///
2451 "Librarians" ///
2452 "Archivists and curators" ///
3111 "Laboratory technicians" ///
3112 "Electrical/electronics technicians" ///
3113 "Engineering technicians" ///
3114 "Building and civil engineering technicians" ///
3115 "Quality assurance technicians" ///
3119 "Science and engineering technicians n.e.c." ///
3121 "Architectural technologists and town planning technicians" ///
3122 "Draughtspersons" ///
3123 "Building inspectors" ///
3131 "IT operations technicians" ///
3132 "IT user support technicians" ///
3211 "Nurses" ///
3212 "Midwives" ///
3213 "Paramedics" ///
3214 "Medical radiographers" ///
3215 "Chiropodists" ///
3216 "Dispensing opticians" ///
3217 "Pharmaceutical dispensers" ///
3218 "Medical and dental technicians" ///
3221 "Physiotherapists" ///
3222 "Occupational therapists" ///
3223 "Speech and language therapists" ///
3229 "Therapists n.e.c." ///
3231 "Youth and community workers" ///
3232 "Housing and welfare officers" ///
3311 "NCOs and other ranks" ///
3312 "Police officers (sergeant and below)" ///
3313 "Fire service officers (leading fire officer and below)" ///
3314 "Prison service officers (below principal officer)" ///
3319 "Protective service associate professionals n.e.c." ///
3411 "Artists" ///
3412 "Authors, writers" ///
3413 "Actors, entertainers" ///
3414 "Dancers and choreographers" ///
3415 "Musicians" ///
3416 "Arts officers, producers and directors" ///
3421 "Graphic designers" ///
3422 "Product, clothing and related designers" ///
3431 "Journalists, newspaper and periodical editors" ///
3432 "Broadcasting associate professionals" ///
3433 "Public relations officers" ///
3434 "Photographers and audio-visual equipment operators" ///
3441 "Sports players" ///
3442 "Sports coaches, instructors and officials" ///
3443 "Fitness instructors" ///
3449 "Sports and fitness occupations n.e.c." ///
3511 "Air traffic controllers" ///
3512 "Aircraft pilots and flight engineers" ///
3513 "Ship and hovercraft officers" ///
3514 "Train drivers" ///
3520 "Legal associate professionals" ///
3531 "Estimators, valuers and assessors" ///
3532 "Brokers" ///
3533 "Insurance underwriters" ///
3534 "Finance and investment analysts/advisers" ///
3535 "Taxation experts" ///
3536 "Importers, exporters" ///
3537 "Financial and accounting technicians" ///
3539 "Business and related associate professionals n.e.c." ///
3541 "Buyers and purchasing officers" ///
3542 "Sales representatives" ///
3543 "Marketing associate professionals" ///
3544 "Estate agents, auctioneers" ///
3551 "Conservation and environmental protection officers" ///
3552 "Countryside and park rangers" ///
3561 "Public service associate professionals" ///
3562 "Personnel and industrial relations officers" ///
3563 "Vocational and industrial trainers and instructors" ///
3564 "Careers advisers and vocational guidance specialists" ///
3565 "Inspectors of factories, utilities and trading standards" ///
3566 "Statutory examiners" ///
3567 "Occupational hygienists and safety officers (health and safety)" ///
3568 "Environmental health officers" ///
4111 "Civil Service executive officers" ///
4112 "Civil Service administrative officers and assistants" ///
4113 "Local government clerical officers and assistants" ///
4114 "Officers of non-governmental organisations" ///
4121 "Credit controllers" ///
4122 "Accounts and wages clerks, book-keepers, other financial clerks" ///
4123 "Counter clerks" ///
4131 "Filing and other records assistants/clerks" ///
4132 "Pensions and insurance clerks" ///
4133 "Stock control clerks" ///
4134 "Transport and distribution clerks" ///
4135 "Library assistants/clerks" ///
4136 "Database assistants/clerks" ///
4137 "Market research interviewers" ///
4141 "Telephonists" ///
4142 "Communication operators" ///
4150 "General office assistants/clerks" ///
4211 "Medical secretaries" ///
4212 "Legal secretaries" ///
4213 "School secretaries" ///
4214 "Company secretaries" ///
4215 "Personal assistants and other secretaries" ///
4216 "Receptionists" ///
4217 "Typists" ///
5111 "Farmers" ///
5112 "Horticultural trades" ///
5113 "Gardeners and groundsmen/groundswomen" ///
5119 "Agricultural and fishing trades n.e.c." ///
5211 "Smiths and forge workers" ///
5212 "Moulders, core makers, die casters" ///
5213 "Sheet metal workers" ///
5214 "Metal plate workers, shipwrights, riveters" ///
5215 "Welding trades" ///
5216 "Pipe fitters" ///
5221 "Metal machining setters and setter-operators" ///
5222 "Tool makers, tool fitters and markers-out" ///
5223 "Metal working production and maintenance fitters" ///
5224 "Precision instrument makers and repairers" ///
5231 "Motor mechanics, auto engineers" ///
5232 "Vehicle body builders and repairers" ///
5233 "Auto electricians" ///
5234 "Vehicle spray painters" ///
5241 "Electricians, electrical fitters" ///
5242 "Telecommunications engineers" ///
5243 "Lines repairers and cable jointers," ///
5244 "TV, video and audio engineers" ///
5245 "Computer engineers, installation and maintenance" ///
5249 "Electrical/electronics engineers n.e.c." ///
5311 "Steel erectors" ///
5312 "Bricklayers, masons" ///
5313 "Roofers, roof tilers and slaters" ///
5314 "Plumbers, heating and ventilating engineers" ///
5315 "Carpenters and joiners" ///
5316 "Glaziers, window fabricators and fitters" ///
5319 "Construction trades n.e.c." ///
5321 "Plasterers" ///
5322 "Floorers and wall tilers" ///
5323 "Painters and decorators" ///
5411 "Weavers and knitters" ///
5412 "Upholsterers" ///
5413 "Leather and related trades" ///
5414 "Tailors and dressmakers" ///
5419 "Textiles, garments and related trades n.e.c." ///
5421 "Originators, compositors and print preparers" ///
5422 "Printers" ///
5423 "Bookbinders and print finishers" ///
5424 "Screen printers" ///
5431 "Butchers, meat cutters" ///
5432 "Bakers, flour confectioners" ///
5433 "Fishmongers, poultry dressers" ///
5434 "Chefs, cooks" ///
5491 "Glass and ceramics makers, decorators and finishers" ///
5492 "Furniture makers, other craft woodworkers" ///
5493 "Pattern makers (moulds)" ///
5494 "Musical instrument makers and tuners" ///
5495 "Goldsmiths, silversmiths, precious stone workers" ///
5496 "Floral arrangers, florists" ///
5499 "Hand craft occupations n.e.c." ///
6111 "Nursing auxiliaries and assistants" ///
6112 "Ambulance staff (excluding paramedics)" ///
6113 "Dental nurses" ///
6114 "Houseparents and residential wardens" ///
6115 "Care assistants and home carers" ///
6121 "Nursery nurses" ///
6122 "Childminders and related occupations" ///
6123 "Playgroup leaders/assistants" ///
6124 "Educational assistants" ///
6131 "Veterinary nurses and assistants" ///
6139 "Animal care occupations n.e.c." ///
6211 "Sports and leisure assistants" ///
6212 "Travel agents" ///
6213 "Travel and tour guides" ///
6214 "Air travel assistants" ///
6215 "Rail travel assistants" ///
6219 "Leisure and travel service occupations n.e.c." ///
6221 "Hairdressers, barbers" ///
6222 "Beauticians and related occupations" ///
6231 "Housekeepers and related occupations" ///
6232 "Caretakers" ///
6291 "Undertakers and mortuary assistants" ///
6292 "Pest control officers" ///
7111 "Sales and retail assistants" ///
7112 "Retail cashiers and check-out operators" ///
7113 "Telephone salespersons" ///
7121 "Collector salespersons and credit agents" ///
7122 "Debt, rent and other cash collectors" ///
7123 "Roundsmen/women and van salespersons" ///
7124 "Market and street traders and assistants" ///
7125 "Merchandisers and window dressers" ///
7129 "Sales related occupations n.e.c." ///
7211 "Call centre agents/operators" ///
7212 "Customer care occupations" ///
8111 "Food, drink and tobacco process operatives" ///
8112 "Glass and ceramics process operatives" ///
8113 "Textile process operatives" ///
8114 "Chemical and related process operatives" ///
8115 "Rubber process operatives" ///
8116 "Plastics process operatives" ///
8117 "Metal making and treating process operatives" ///
8118 "Electroplaters" ///
8119 "Process operatives n.e.c." ///
8121 "Paper and wood machine operatives" ///
8122 "Coal mine operatives" ///
8123 "Quarry workers and related operatives" ///
8124 "Energy plant operatives" ///
8125 "Metal working machine operatives" ///
8126 "Water and sewerage plant operatives" ///
8129 "Plant and machine operatives n.e.c." ///
8131 "Assemblers (electrical products)" ///
8132 "Assemblers (vehicles and metal goods)" ///
8133 "Routine inspectors and testers" ///
8134 "Weighers, graders, sorters" ///
8135 "Tyre, exhaust and windscreen fitters" ///
8136 "Clothing cutters" ///
8137 "Sewing machinists" ///
8138 "Routine laboratory testers" ///
8139 "Assemblers and routine operatives n.e.c." ///
8141 "Scaffolders, stagers, riggers" ///
8142 "Road construction operatives" ///
8143 "Rail construction and maintenance operatives" ///
8149 "Construction operatives n.e.c." ///
8211 "Heavy goods vehicle drivers" ///
8212 "Van drivers" ///
8213 "Bus and coach drivers" ///
8214 "Taxi, cab drivers and chauffeurs" ///
8215 "Driving instructors" ///
8216 "Rail transport operatives" ///
8217 "Seafarers (merchant navy); barge, lighter and boat operatives" ///
8218 "Air transport operatives" ///
8219 "Transport operatives n.e.c." ///
8221 "Crane drivers" ///
8222 "Fork-lift truck drivers" ///
8223 "Agricultural machinery drivers" ///
8229 "Mobile machine drivers and operatives n.e.c." ///
9111 "Farm workers" ///
9112 "Forestry workers" ///
9119 "Fishing and agriculture related occupations n.e.c." ///
9121 "Labourers in building and woodworking trades" ///
9129 "Labourers in other construction trades n.e.c." ///
9131 "Labourers in foundries" ///
9132 "Industrial cleaning process occupations" ///
9133 "Printing machine minders and assistants" ///
9134 "Packers, bottlers, canners, fillers" ///
9139 "Labourers in process and plant operations n.e.c." ///
9141 "Stevedores, dockers and slingers" ///
9149 "Other goods handling and storage occupations n.e.c." ///
9211 "Postal workers, mail sorters, messengers, couriers" ///
9219 "Elementary office occupations n.e.c." ///
9221 "Hospital porters" ///
9222 "Hotel porters" ///
9223 "Kitchen and catering assistants" ///
9224 "Waiters, waitresses" ///
9225 "Bar staff" ///
9226 "Leisure and theme park attendants" ///
9229 "Elementary personal services occupations n.e.c." ///
9231 "Window cleaners" ///
9232 "Road sweepers" ///
9233 "Cleaners, domestics" ///
9234 "Launderers, dry cleaners, pressers" ///
9235 "Refuse and salvage occupations" ///
9239 "Elementary cleaning occupations n.e.c." ///
9241 "Security guards and related occupations" ///
9242 "Traffic wardens" ///
9243 "School crossing patrol attendants" ///
9244 "School midday assistants" ///
9245 "Car park attendants" ///
9249 "Elementary security occupations n.e.c." ///
9251 "Shelf fillers" ///
9259 "Elementary sales occupations n.e.c."

* END *
