* 5th January 2017

* Dr Chris Playford
* Youth Cohort Study - Latent Class Analysis

* YCS10 Preparation of SOC2000 codes

* This file is called upon by '3_ycs10_background_vars.do'

* Called this t0dadsoc2000/t0mumsoc2000 to distinguish from t0dadsoc (i.e. SOC90)

    gen t0dadsoc2000=.
replace t0dadsoc2000=1111 if ns1socf==2
replace t0dadsoc2000=1112 if ns1socf==3
replace t0dadsoc2000=1113 if ns1socf==4
replace t0dadsoc2000=1114 if ns1socf==5
replace t0dadsoc2000=1121 if ns1socf==6
replace t0dadsoc2000=1122 if ns1socf==7
replace t0dadsoc2000=1123 if ns1socf==8
replace t0dadsoc2000=1131 if ns1socf==9
replace t0dadsoc2000=1132 if ns1socf==10
replace t0dadsoc2000=1133 if ns1socf==11
replace t0dadsoc2000=1134 if ns1socf==12
replace t0dadsoc2000=1135 if ns1socf==13
replace t0dadsoc2000=1136 if ns1socf==14
replace t0dadsoc2000=1137 if ns1socf==15
replace t0dadsoc2000=1141 if ns1socf==16
replace t0dadsoc2000=1142 if ns1socf==17
replace t0dadsoc2000=1151 if ns1socf==18
replace t0dadsoc2000=1152 if ns1socf==19
replace t0dadsoc2000=1161 if ns1socf==20
replace t0dadsoc2000=1162 if ns1socf==21
replace t0dadsoc2000=1163 if ns1socf==22
replace t0dadsoc2000=1171 if ns1socf==23
replace t0dadsoc2000=1172 if ns1socf==24
replace t0dadsoc2000=1173 if ns1socf==25
replace t0dadsoc2000=1174 if ns1socf==26
replace t0dadsoc2000=1181 if ns1socf==27
replace t0dadsoc2000=1182 if ns1socf==28
replace t0dadsoc2000=1183 if ns1socf==29
replace t0dadsoc2000=1184 if ns1socf==30
replace t0dadsoc2000=1185 if ns1socf==31
replace t0dadsoc2000=1211 if ns1socf==32
replace t0dadsoc2000=1212 if ns1socf==33
replace t0dadsoc2000=1219 if ns1socf==34
replace t0dadsoc2000=1221 if ns1socf==35
replace t0dadsoc2000=1222 if ns1socf==36
replace t0dadsoc2000=1223 if ns1socf==37
replace t0dadsoc2000=1224 if ns1socf==38
replace t0dadsoc2000=1225 if ns1socf==39
replace t0dadsoc2000=1226 if ns1socf==40
replace t0dadsoc2000=1231 if ns1socf==41
replace t0dadsoc2000=1232 if ns1socf==42
replace t0dadsoc2000=1233 if ns1socf==43
replace t0dadsoc2000=1163 if ns1socf==44
replace t0dadsoc2000=1235 if ns1socf==45
replace t0dadsoc2000=1239 if ns1socf==46
replace t0dadsoc2000=2111 if ns1socf==47
replace t0dadsoc2000=2112 if ns1socf==48
replace t0dadsoc2000=2113 if ns1socf==49
replace t0dadsoc2000=2121 if ns1socf==50
replace t0dadsoc2000=2122 if ns1socf==51
replace t0dadsoc2000=2123 if ns1socf==52
replace t0dadsoc2000=2124 if ns1socf==53
replace t0dadsoc2000=2125 if ns1socf==54
replace t0dadsoc2000=2126 if ns1socf==55
replace t0dadsoc2000=2127 if ns1socf==56
replace t0dadsoc2000=2128 if ns1socf==57
replace t0dadsoc2000=2129 if ns1socf==58
replace t0dadsoc2000=2131 if ns1socf==59
replace t0dadsoc2000=2132 if ns1socf==60
replace t0dadsoc2000=2211 if ns1socf==61
replace t0dadsoc2000=2212 if ns1socf==62
replace t0dadsoc2000=2213 if ns1socf==63
replace t0dadsoc2000=2214 if ns1socf==64
replace t0dadsoc2000=2215 if ns1socf==65
replace t0dadsoc2000=2216 if ns1socf==66
replace t0dadsoc2000=2311 if ns1socf==67
replace t0dadsoc2000=2312 if ns1socf==68
replace t0dadsoc2000=2313 if ns1socf==69
replace t0dadsoc2000=2314 if ns1socf==70
replace t0dadsoc2000=2315 if ns1socf==71
replace t0dadsoc2000=2316 if ns1socf==72
replace t0dadsoc2000=2317 if ns1socf==73
replace t0dadsoc2000=2319 if ns1socf==74
replace t0dadsoc2000=2321 if ns1socf==75
replace t0dadsoc2000=2322 if ns1socf==76
replace t0dadsoc2000=2329 if ns1socf==77
replace t0dadsoc2000=2411 if ns1socf==78
replace t0dadsoc2000=2419 if ns1socf==79
replace t0dadsoc2000=2421 if ns1socf==80
replace t0dadsoc2000=2422 if ns1socf==81
replace t0dadsoc2000=2423 if ns1socf==82
replace t0dadsoc2000=2431 if ns1socf==83
replace t0dadsoc2000=2432 if ns1socf==84
replace t0dadsoc2000=2433 if ns1socf==85
replace t0dadsoc2000=2434 if ns1socf==86
replace t0dadsoc2000=2441 if ns1socf==87
replace t0dadsoc2000=2442 if ns1socf==88
replace t0dadsoc2000=2443 if ns1socf==89
replace t0dadsoc2000=2444 if ns1socf==90
replace t0dadsoc2000=2451 if ns1socf==91
replace t0dadsoc2000=2452 if ns1socf==92
replace t0dadsoc2000=3111 if ns1socf==93
replace t0dadsoc2000=3112 if ns1socf==94
replace t0dadsoc2000=3113 if ns1socf==95
replace t0dadsoc2000=3114 if ns1socf==96
replace t0dadsoc2000=3115 if ns1socf==97
replace t0dadsoc2000=3119 if ns1socf==98
replace t0dadsoc2000=3121 if ns1socf==99
replace t0dadsoc2000=3122 if ns1socf==100
replace t0dadsoc2000=3123 if ns1socf==101
replace t0dadsoc2000=3131 if ns1socf==102
replace t0dadsoc2000=3132 if ns1socf==103
replace t0dadsoc2000=3211 if ns1socf==104
replace t0dadsoc2000=3212 if ns1socf==105
replace t0dadsoc2000=3213 if ns1socf==106
replace t0dadsoc2000=3214 if ns1socf==107
replace t0dadsoc2000=3216 if ns1socf==109
replace t0dadsoc2000=3217 if ns1socf==110
replace t0dadsoc2000=3218 if ns1socf==111
replace t0dadsoc2000=3221 if ns1socf==112
replace t0dadsoc2000=3222 if ns1socf==113
replace t0dadsoc2000=3229 if ns1socf==115
replace t0dadsoc2000=3231 if ns1socf==116
replace t0dadsoc2000=3232 if ns1socf==117
replace t0dadsoc2000=3311 if ns1socf==118
replace t0dadsoc2000=3312 if ns1socf==119
replace t0dadsoc2000=3313 if ns1socf==120
replace t0dadsoc2000=3314 if ns1socf==121
replace t0dadsoc2000=3319 if ns1socf==122
replace t0dadsoc2000=3411 if ns1socf==123
replace t0dadsoc2000=3412 if ns1socf==124
replace t0dadsoc2000=3413 if ns1socf==125
replace t0dadsoc2000=3415 if ns1socf==127
replace t0dadsoc2000=3416 if ns1socf==128
replace t0dadsoc2000=3421 if ns1socf==129
replace t0dadsoc2000=3422 if ns1socf==130
replace t0dadsoc2000=3431 if ns1socf==131
replace t0dadsoc2000=3432 if ns1socf==132
replace t0dadsoc2000=3433 if ns1socf==133
replace t0dadsoc2000=3434 if ns1socf==134
replace t0dadsoc2000=3441 if ns1socf==135
replace t0dadsoc2000=3442 if ns1socf==136
replace t0dadsoc2000=3443 if ns1socf==137
replace t0dadsoc2000=3449 if ns1socf==138
replace t0dadsoc2000=3511 if ns1socf==139
replace t0dadsoc2000=3512 if ns1socf==140
replace t0dadsoc2000=3513 if ns1socf==141
replace t0dadsoc2000=3514 if ns1socf==142
replace t0dadsoc2000=3520 if ns1socf==143
replace t0dadsoc2000=3531 if ns1socf==144
replace t0dadsoc2000=3532 if ns1socf==145
replace t0dadsoc2000=3533 if ns1socf==146
replace t0dadsoc2000=3534 if ns1socf==147
replace t0dadsoc2000=3535 if ns1socf==148
replace t0dadsoc2000=3536 if ns1socf==149
replace t0dadsoc2000=3537 if ns1socf==150
replace t0dadsoc2000=3539 if ns1socf==151
replace t0dadsoc2000=3541 if ns1socf==152
replace t0dadsoc2000=3542 if ns1socf==153
replace t0dadsoc2000=3543 if ns1socf==154
replace t0dadsoc2000=3544 if ns1socf==155
replace t0dadsoc2000=1212 if ns1socf==156
replace t0dadsoc2000=3552 if ns1socf==157
replace t0dadsoc2000=3561 if ns1socf==158
replace t0dadsoc2000=3562 if ns1socf==159
replace t0dadsoc2000=3563 if ns1socf==160
replace t0dadsoc2000=3564 if ns1socf==161
replace t0dadsoc2000=3565 if ns1socf==162
replace t0dadsoc2000=3566 if ns1socf==163
replace t0dadsoc2000=3567 if ns1socf==164
replace t0dadsoc2000=3568 if ns1socf==165
replace t0dadsoc2000=4111 if ns1socf==166
replace t0dadsoc2000=4112 if ns1socf==167
replace t0dadsoc2000=4113 if ns1socf==168
replace t0dadsoc2000=4114 if ns1socf==169
replace t0dadsoc2000=4121 if ns1socf==170
replace t0dadsoc2000=4122 if ns1socf==171
replace t0dadsoc2000=4123 if ns1socf==172
replace t0dadsoc2000=4131 if ns1socf==173
replace t0dadsoc2000=4132 if ns1socf==174
replace t0dadsoc2000=4133 if ns1socf==175
replace t0dadsoc2000=4134 if ns1socf==176
replace t0dadsoc2000=4135 if ns1socf==177
replace t0dadsoc2000=4136 if ns1socf==178
replace t0dadsoc2000=4137 if ns1socf==179
replace t0dadsoc2000=4141 if ns1socf==180
replace t0dadsoc2000=4142 if ns1socf==181
replace t0dadsoc2000=4150 if ns1socf==182
replace t0dadsoc2000=4211 if ns1socf==183
replace t0dadsoc2000=4213 if ns1socf==185
replace t0dadsoc2000=4214 if ns1socf==186
replace t0dadsoc2000=4215 if ns1socf==187
replace t0dadsoc2000=4216 if ns1socf==188
replace t0dadsoc2000=5111 if ns1socf==190
replace t0dadsoc2000=5112 if ns1socf==191
replace t0dadsoc2000=5113 if ns1socf==192
replace t0dadsoc2000=5119 if ns1socf==193
replace t0dadsoc2000=5211 if ns1socf==194
replace t0dadsoc2000=5212 if ns1socf==195
replace t0dadsoc2000=5213 if ns1socf==196
replace t0dadsoc2000=5214 if ns1socf==197
replace t0dadsoc2000=5215 if ns1socf==198
replace t0dadsoc2000=5216 if ns1socf==199
replace t0dadsoc2000=5221 if ns1socf==200
replace t0dadsoc2000=5222 if ns1socf==201
replace t0dadsoc2000=5223 if ns1socf==202
replace t0dadsoc2000=5224 if ns1socf==203
replace t0dadsoc2000=5231 if ns1socf==204
replace t0dadsoc2000=5232 if ns1socf==205
replace t0dadsoc2000=5233 if ns1socf==206
replace t0dadsoc2000=5234 if ns1socf==207
replace t0dadsoc2000=5241 if ns1socf==208
replace t0dadsoc2000=5242 if ns1socf==209
replace t0dadsoc2000=5243 if ns1socf==210
replace t0dadsoc2000=5244 if ns1socf==211
replace t0dadsoc2000=5245 if ns1socf==212
replace t0dadsoc2000=2124 if ns1socf==213
replace t0dadsoc2000=5311 if ns1socf==214
replace t0dadsoc2000=5312 if ns1socf==215
replace t0dadsoc2000=5313 if ns1socf==216
replace t0dadsoc2000=5314 if ns1socf==217
replace t0dadsoc2000=5315 if ns1socf==218
replace t0dadsoc2000=5316 if ns1socf==219
replace t0dadsoc2000=5319 if ns1socf==220
replace t0dadsoc2000=5321 if ns1socf==221
replace t0dadsoc2000=5322 if ns1socf==222
replace t0dadsoc2000=5323 if ns1socf==223
replace t0dadsoc2000=5411 if ns1socf==224
replace t0dadsoc2000=5412 if ns1socf==225
replace t0dadsoc2000=5413 if ns1socf==226
replace t0dadsoc2000=5414 if ns1socf==227
replace t0dadsoc2000=5419 if ns1socf==228
replace t0dadsoc2000=5421 if ns1socf==229
replace t0dadsoc2000=5422 if ns1socf==230
replace t0dadsoc2000=5423 if ns1socf==231
replace t0dadsoc2000=5424 if ns1socf==232
replace t0dadsoc2000=5431 if ns1socf==233
replace t0dadsoc2000=5432 if ns1socf==234
replace t0dadsoc2000=5433 if ns1socf==235
replace t0dadsoc2000=5434 if ns1socf==236
replace t0dadsoc2000=5491 if ns1socf==237
replace t0dadsoc2000=5492 if ns1socf==238
replace t0dadsoc2000=5493 if ns1socf==239
replace t0dadsoc2000=5494 if ns1socf==240
replace t0dadsoc2000=5495 if ns1socf==241
replace t0dadsoc2000=5496 if ns1socf==242
replace t0dadsoc2000=5499 if ns1socf==243
replace t0dadsoc2000=6111 if ns1socf==244
replace t0dadsoc2000=6112 if ns1socf==245
replace t0dadsoc2000=6114 if ns1socf==247
replace t0dadsoc2000=6115 if ns1socf==248
replace t0dadsoc2000=6123 if ns1socf==251
replace t0dadsoc2000=6124 if ns1socf==252
replace t0dadsoc2000=6131 if ns1socf==253
replace t0dadsoc2000=6139 if ns1socf==254
replace t0dadsoc2000=6211 if ns1socf==255
replace t0dadsoc2000=6212 if ns1socf==256
replace t0dadsoc2000=6213 if ns1socf==257
replace t0dadsoc2000=6214 if ns1socf==258
replace t0dadsoc2000=6215 if ns1socf==259
replace t0dadsoc2000=6219 if ns1socf==260
replace t0dadsoc2000=6221 if ns1socf==261
replace t0dadsoc2000=6222 if ns1socf==262
replace t0dadsoc2000=6231 if ns1socf==263
replace t0dadsoc2000=6232 if ns1socf==264
replace t0dadsoc2000=6291 if ns1socf==265
replace t0dadsoc2000=6292 if ns1socf==266
replace t0dadsoc2000=7111 if ns1socf==267
replace t0dadsoc2000=7112 if ns1socf==268
replace t0dadsoc2000=7113 if ns1socf==269
replace t0dadsoc2000=7121 if ns1socf==270
replace t0dadsoc2000=7122 if ns1socf==271
replace t0dadsoc2000=7123 if ns1socf==272
replace t0dadsoc2000=7124 if ns1socf==273
replace t0dadsoc2000=7125 if ns1socf==274
replace t0dadsoc2000=7129 if ns1socf==275
replace t0dadsoc2000=7211 if ns1socf==276
replace t0dadsoc2000=7212 if ns1socf==277
replace t0dadsoc2000=8111 if ns1socf==278
replace t0dadsoc2000=8112 if ns1socf==279
replace t0dadsoc2000=8113 if ns1socf==280
replace t0dadsoc2000=8114 if ns1socf==281
replace t0dadsoc2000=8115 if ns1socf==282
replace t0dadsoc2000=8116 if ns1socf==283
replace t0dadsoc2000=8117 if ns1socf==284
replace t0dadsoc2000=8118 if ns1socf==285
replace t0dadsoc2000=8119 if ns1socf==286
replace t0dadsoc2000=8121 if ns1socf==287
replace t0dadsoc2000=8122 if ns1socf==288
replace t0dadsoc2000=8123 if ns1socf==289
replace t0dadsoc2000=8124 if ns1socf==290
replace t0dadsoc2000=8125 if ns1socf==291
replace t0dadsoc2000=8126 if ns1socf==292
replace t0dadsoc2000=8129 if ns1socf==293
replace t0dadsoc2000=8131 if ns1socf==294
replace t0dadsoc2000=8132 if ns1socf==295
replace t0dadsoc2000=8133 if ns1socf==296
replace t0dadsoc2000=8134 if ns1socf==297
replace t0dadsoc2000=8135 if ns1socf==298
replace t0dadsoc2000=8136 if ns1socf==299
replace t0dadsoc2000=8137 if ns1socf==300
replace t0dadsoc2000=8138 if ns1socf==301
replace t0dadsoc2000=8139 if ns1socf==302
replace t0dadsoc2000=8141 if ns1socf==303
replace t0dadsoc2000=8142 if ns1socf==304
replace t0dadsoc2000=8143 if ns1socf==305
replace t0dadsoc2000=8149 if ns1socf==306
replace t0dadsoc2000=8211 if ns1socf==307
replace t0dadsoc2000=8212 if ns1socf==308
replace t0dadsoc2000=8213 if ns1socf==309
replace t0dadsoc2000=8214 if ns1socf==310
replace t0dadsoc2000=8215 if ns1socf==311
replace t0dadsoc2000=8216 if ns1socf==312
replace t0dadsoc2000=8217 if ns1socf==313
replace t0dadsoc2000=8218 if ns1socf==314
replace t0dadsoc2000=8219 if ns1socf==315
replace t0dadsoc2000=8221 if ns1socf==316
replace t0dadsoc2000=8222 if ns1socf==317
replace t0dadsoc2000=8229 if ns1socf==319
replace t0dadsoc2000=9111 if ns1socf==320
replace t0dadsoc2000=9112 if ns1socf==321
replace t0dadsoc2000=9119 if ns1socf==322
replace t0dadsoc2000=9121 if ns1socf==323
replace t0dadsoc2000=9129 if ns1socf==324
replace t0dadsoc2000=9131 if ns1socf==325
replace t0dadsoc2000=9132 if ns1socf==326
replace t0dadsoc2000=9133 if ns1socf==327
replace t0dadsoc2000=9134 if ns1socf==328
replace t0dadsoc2000=9139 if ns1socf==329
replace t0dadsoc2000=9141 if ns1socf==330
replace t0dadsoc2000=9149 if ns1socf==331
replace t0dadsoc2000=9211 if ns1socf==332
replace t0dadsoc2000=9219 if ns1socf==333
replace t0dadsoc2000=9221 if ns1socf==334
replace t0dadsoc2000=9222 if ns1socf==335
replace t0dadsoc2000=9223 if ns1socf==336
replace t0dadsoc2000=9224 if ns1socf==337
replace t0dadsoc2000=9225 if ns1socf==338
replace t0dadsoc2000=9229 if ns1socf==340
replace t0dadsoc2000=9231 if ns1socf==341
replace t0dadsoc2000=9232 if ns1socf==342
replace t0dadsoc2000=9233 if ns1socf==343
replace t0dadsoc2000=9234 if ns1socf==344
replace t0dadsoc2000=9235 if ns1socf==345
replace t0dadsoc2000=9239 if ns1socf==346
replace t0dadsoc2000=9241 if ns1socf==347
replace t0dadsoc2000=9242 if ns1socf==348
replace t0dadsoc2000=9245 if ns1socf==351
replace t0dadsoc2000=9249 if ns1socf==352
replace t0dadsoc2000=9251 if ns1socf==353
replace t0dadsoc2000=9259 if ns1socf==354

***

    gen t0mumsoc2000=.
replace t0mumsoc2000=1112 if ns1socm==3
replace t0mumsoc2000=1113 if ns1socm==4
replace t0mumsoc2000=1114 if ns1socm==5
replace t0mumsoc2000=1121 if ns1socm==6
replace t0mumsoc2000=1122 if ns1socm==7
replace t0mumsoc2000=1123 if ns1socm==8
replace t0mumsoc2000=1131 if ns1socm==9
replace t0mumsoc2000=1132 if ns1socm==10
replace t0mumsoc2000=1133 if ns1socm==11
replace t0mumsoc2000=1135 if ns1socm==13
replace t0mumsoc2000=1136 if ns1socm==14
replace t0mumsoc2000=1137 if ns1socm==15
replace t0mumsoc2000=1142 if ns1socm==17
replace t0mumsoc2000=1151 if ns1socm==18
replace t0mumsoc2000=1152 if ns1socm==19
replace t0mumsoc2000=1161 if ns1socm==20
replace t0mumsoc2000=1162 if ns1socm==21
replace t0mumsoc2000=1163 if ns1socm==22
replace t0mumsoc2000=1171 if ns1socm==23
replace t0mumsoc2000=1173 if ns1socm==25
replace t0mumsoc2000=1181 if ns1socm==27
replace t0mumsoc2000=1182 if ns1socm==28
replace t0mumsoc2000=1183 if ns1socm==29
replace t0mumsoc2000=1184 if ns1socm==30
replace t0mumsoc2000=1185 if ns1socm==31
replace t0mumsoc2000=1219 if ns1socm==34
replace t0mumsoc2000=1221 if ns1socm==35
replace t0mumsoc2000=1222 if ns1socm==36
replace t0mumsoc2000=1223 if ns1socm==37
replace t0mumsoc2000=1224 if ns1socm==38
replace t0mumsoc2000=1225 if ns1socm==39
replace t0mumsoc2000=1226 if ns1socm==40
replace t0mumsoc2000=1231 if ns1socm==41
replace t0mumsoc2000=1232 if ns1socm==42
replace t0mumsoc2000=1163 if ns1socm==44
replace t0mumsoc2000=1239 if ns1socm==46
replace t0mumsoc2000=2111 if ns1socm==47
replace t0mumsoc2000=2112 if ns1socm==48
replace t0mumsoc2000=2113 if ns1socm==49
replace t0mumsoc2000=2121 if ns1socm==50
replace t0mumsoc2000=2122 if ns1socm==51
replace t0mumsoc2000=2124 if ns1socm==53
replace t0mumsoc2000=2127 if ns1socm==56
replace t0mumsoc2000=2128 if ns1socm==57
replace t0mumsoc2000=2129 if ns1socm==58
replace t0mumsoc2000=2131 if ns1socm==59
replace t0mumsoc2000=2132 if ns1socm==60
replace t0mumsoc2000=2211 if ns1socm==61
replace t0mumsoc2000=2212 if ns1socm==62
replace t0mumsoc2000=2213 if ns1socm==63
replace t0mumsoc2000=2214 if ns1socm==64
replace t0mumsoc2000=2215 if ns1socm==65
replace t0mumsoc2000=2216 if ns1socm==66
replace t0mumsoc2000=2311 if ns1socm==67
replace t0mumsoc2000=2312 if ns1socm==68
replace t0mumsoc2000=2313 if ns1socm==69
replace t0mumsoc2000=2314 if ns1socm==70
replace t0mumsoc2000=2315 if ns1socm==71
replace t0mumsoc2000=2316 if ns1socm==72
replace t0mumsoc2000=2317 if ns1socm==73
replace t0mumsoc2000=2319 if ns1socm==74
replace t0mumsoc2000=2321 if ns1socm==75
replace t0mumsoc2000=2322 if ns1socm==76
replace t0mumsoc2000=2329 if ns1socm==77
replace t0mumsoc2000=2411 if ns1socm==78
replace t0mumsoc2000=2419 if ns1socm==79
replace t0mumsoc2000=2421 if ns1socm==80
replace t0mumsoc2000=2422 if ns1socm==81
replace t0mumsoc2000=2423 if ns1socm==82
replace t0mumsoc2000=2431 if ns1socm==83
replace t0mumsoc2000=2432 if ns1socm==84
replace t0mumsoc2000=2434 if ns1socm==86
replace t0mumsoc2000=2441 if ns1socm==87
replace t0mumsoc2000=2442 if ns1socm==88
replace t0mumsoc2000=2443 if ns1socm==89
replace t0mumsoc2000=2444 if ns1socm==90
replace t0mumsoc2000=2451 if ns1socm==91
replace t0mumsoc2000=2452 if ns1socm==92
replace t0mumsoc2000=3111 if ns1socm==93
replace t0mumsoc2000=3115 if ns1socm==97
replace t0mumsoc2000=3119 if ns1socm==98
replace t0mumsoc2000=3122 if ns1socm==100
replace t0mumsoc2000=3123 if ns1socm==101
replace t0mumsoc2000=3131 if ns1socm==102
replace t0mumsoc2000=3132 if ns1socm==103
replace t0mumsoc2000=3211 if ns1socm==104
replace t0mumsoc2000=3212 if ns1socm==105
replace t0mumsoc2000=3213 if ns1socm==106
replace t0mumsoc2000=3214 if ns1socm==107
replace t0mumsoc2000=3215 if ns1socm==108
replace t0mumsoc2000=3216 if ns1socm==109
replace t0mumsoc2000=3217 if ns1socm==110
replace t0mumsoc2000=3218 if ns1socm==111
replace t0mumsoc2000=3221 if ns1socm==112
replace t0mumsoc2000=3222 if ns1socm==113
replace t0mumsoc2000=3223 if ns1socm==114
replace t0mumsoc2000=3229 if ns1socm==115
replace t0mumsoc2000=3231 if ns1socm==116
replace t0mumsoc2000=3232 if ns1socm==117
replace t0mumsoc2000=3312 if ns1socm==119
replace t0mumsoc2000=3314 if ns1socm==121
replace t0mumsoc2000=3319 if ns1socm==122
replace t0mumsoc2000=3411 if ns1socm==123
replace t0mumsoc2000=3412 if ns1socm==124
replace t0mumsoc2000=3413 if ns1socm==125
replace t0mumsoc2000=3414 if ns1socm==126
replace t0mumsoc2000=3415 if ns1socm==127
replace t0mumsoc2000=3416 if ns1socm==128
replace t0mumsoc2000=3421 if ns1socm==129
replace t0mumsoc2000=3422 if ns1socm==130
replace t0mumsoc2000=3431 if ns1socm==131
replace t0mumsoc2000=3432 if ns1socm==132
replace t0mumsoc2000=3433 if ns1socm==133
replace t0mumsoc2000=3434 if ns1socm==134
replace t0mumsoc2000=3442 if ns1socm==136
replace t0mumsoc2000=3443 if ns1socm==137
replace t0mumsoc2000=3511 if ns1socm==139
replace t0mumsoc2000=3520 if ns1socm==143
replace t0mumsoc2000=3531 if ns1socm==144
replace t0mumsoc2000=3532 if ns1socm==145
replace t0mumsoc2000=3534 if ns1socm==147
replace t0mumsoc2000=3535 if ns1socm==148
replace t0mumsoc2000=3536 if ns1socm==149
replace t0mumsoc2000=3537 if ns1socm==150
replace t0mumsoc2000=3539 if ns1socm==151
replace t0mumsoc2000=3541 if ns1socm==152
replace t0mumsoc2000=3542 if ns1socm==153
replace t0mumsoc2000=3543 if ns1socm==154
replace t0mumsoc2000=3544 if ns1socm==155
replace t0mumsoc2000=1212 if ns1socm==156
replace t0mumsoc2000=3561 if ns1socm==158
replace t0mumsoc2000=3562 if ns1socm==159
replace t0mumsoc2000=3563 if ns1socm==160
replace t0mumsoc2000=3564 if ns1socm==161
replace t0mumsoc2000=3565 if ns1socm==162
replace t0mumsoc2000=3566 if ns1socm==163
replace t0mumsoc2000=3567 if ns1socm==164
replace t0mumsoc2000=3568 if ns1socm==165
replace t0mumsoc2000=4111 if ns1socm==166
replace t0mumsoc2000=4112 if ns1socm==167
replace t0mumsoc2000=4113 if ns1socm==168
replace t0mumsoc2000=4114 if ns1socm==169
replace t0mumsoc2000=4121 if ns1socm==170
replace t0mumsoc2000=4122 if ns1socm==171
replace t0mumsoc2000=4123 if ns1socm==172
replace t0mumsoc2000=4131 if ns1socm==173
replace t0mumsoc2000=4132 if ns1socm==174
replace t0mumsoc2000=4133 if ns1socm==175
replace t0mumsoc2000=4134 if ns1socm==176
replace t0mumsoc2000=4135 if ns1socm==177
replace t0mumsoc2000=4136 if ns1socm==178
replace t0mumsoc2000=4137 if ns1socm==179
replace t0mumsoc2000=4141 if ns1socm==180
replace t0mumsoc2000=4142 if ns1socm==181
replace t0mumsoc2000=4150 if ns1socm==182
replace t0mumsoc2000=4211 if ns1socm==183
replace t0mumsoc2000=4212 if ns1socm==184
replace t0mumsoc2000=4213 if ns1socm==185
replace t0mumsoc2000=4214 if ns1socm==186
replace t0mumsoc2000=4215 if ns1socm==187
replace t0mumsoc2000=4216 if ns1socm==188
replace t0mumsoc2000=4217 if ns1socm==189
replace t0mumsoc2000=5111 if ns1socm==190
replace t0mumsoc2000=5112 if ns1socm==191
replace t0mumsoc2000=5113 if ns1socm==192
replace t0mumsoc2000=5119 if ns1socm==193
replace t0mumsoc2000=5213 if ns1socm==196
replace t0mumsoc2000=5214 if ns1socm==197
replace t0mumsoc2000=5215 if ns1socm==198
replace t0mumsoc2000=5221 if ns1socm==200
replace t0mumsoc2000=5223 if ns1socm==202
replace t0mumsoc2000=5224 if ns1socm==203
replace t0mumsoc2000=5231 if ns1socm==204
replace t0mumsoc2000=5232 if ns1socm==205
replace t0mumsoc2000=5241 if ns1socm==208
replace t0mumsoc2000=5242 if ns1socm==209
replace t0mumsoc2000=5245 if ns1socm==212
replace t0mumsoc2000=2124 if ns1socm==213
replace t0mumsoc2000=5314 if ns1socm==217
replace t0mumsoc2000=5315 if ns1socm==218
replace t0mumsoc2000=5319 if ns1socm==220
replace t0mumsoc2000=5323 if ns1socm==223
replace t0mumsoc2000=5411 if ns1socm==224
replace t0mumsoc2000=5412 if ns1socm==225
replace t0mumsoc2000=5413 if ns1socm==226
replace t0mumsoc2000=5414 if ns1socm==227
replace t0mumsoc2000=5419 if ns1socm==228
replace t0mumsoc2000=5421 if ns1socm==229
replace t0mumsoc2000=5422 if ns1socm==230
replace t0mumsoc2000=5423 if ns1socm==231
replace t0mumsoc2000=5424 if ns1socm==232
replace t0mumsoc2000=5431 if ns1socm==233
replace t0mumsoc2000=5432 if ns1socm==234
replace t0mumsoc2000=5434 if ns1socm==236
replace t0mumsoc2000=5491 if ns1socm==237
replace t0mumsoc2000=5492 if ns1socm==238
replace t0mumsoc2000=5495 if ns1socm==241
replace t0mumsoc2000=5496 if ns1socm==242
replace t0mumsoc2000=5499 if ns1socm==243
replace t0mumsoc2000=6111 if ns1socm==244
replace t0mumsoc2000=6112 if ns1socm==245
replace t0mumsoc2000=6113 if ns1socm==246
replace t0mumsoc2000=6114 if ns1socm==247
replace t0mumsoc2000=6115 if ns1socm==248
replace t0mumsoc2000=6121 if ns1socm==249
replace t0mumsoc2000=6122 if ns1socm==250
replace t0mumsoc2000=6123 if ns1socm==251
replace t0mumsoc2000=6124 if ns1socm==252
replace t0mumsoc2000=6131 if ns1socm==253
replace t0mumsoc2000=6139 if ns1socm==254
replace t0mumsoc2000=6211 if ns1socm==255
replace t0mumsoc2000=6212 if ns1socm==256
replace t0mumsoc2000=6213 if ns1socm==257
replace t0mumsoc2000=6214 if ns1socm==258
replace t0mumsoc2000=6219 if ns1socm==260
replace t0mumsoc2000=6221 if ns1socm==261
replace t0mumsoc2000=6222 if ns1socm==262
replace t0mumsoc2000=6231 if ns1socm==263
replace t0mumsoc2000=6232 if ns1socm==264
replace t0mumsoc2000=6291 if ns1socm==265
replace t0mumsoc2000=7111 if ns1socm==267
replace t0mumsoc2000=7112 if ns1socm==268
replace t0mumsoc2000=7113 if ns1socm==269
replace t0mumsoc2000=7121 if ns1socm==270
replace t0mumsoc2000=7122 if ns1socm==271
replace t0mumsoc2000=7123 if ns1socm==272
replace t0mumsoc2000=7124 if ns1socm==273
replace t0mumsoc2000=7125 if ns1socm==274
replace t0mumsoc2000=7129 if ns1socm==275
replace t0mumsoc2000=7211 if ns1socm==276
replace t0mumsoc2000=7212 if ns1socm==277
replace t0mumsoc2000=8111 if ns1socm==278
replace t0mumsoc2000=8113 if ns1socm==280
replace t0mumsoc2000=8114 if ns1socm==281
replace t0mumsoc2000=8116 if ns1socm==283
replace t0mumsoc2000=8117 if ns1socm==284
replace t0mumsoc2000=8119 if ns1socm==286
replace t0mumsoc2000=8121 if ns1socm==287
replace t0mumsoc2000=8125 if ns1socm==291
replace t0mumsoc2000=8129 if ns1socm==293
replace t0mumsoc2000=8131 if ns1socm==294
replace t0mumsoc2000=8132 if ns1socm==295
replace t0mumsoc2000=8133 if ns1socm==296
replace t0mumsoc2000=8134 if ns1socm==297
replace t0mumsoc2000=8136 if ns1socm==299
replace t0mumsoc2000=8137 if ns1socm==300
replace t0mumsoc2000=8138 if ns1socm==301
replace t0mumsoc2000=8139 if ns1socm==302
replace t0mumsoc2000=8142 if ns1socm==304
replace t0mumsoc2000=8149 if ns1socm==306
replace t0mumsoc2000=8211 if ns1socm==307
replace t0mumsoc2000=8212 if ns1socm==308
replace t0mumsoc2000=8213 if ns1socm==309
replace t0mumsoc2000=8214 if ns1socm==310
replace t0mumsoc2000=8215 if ns1socm==311
replace t0mumsoc2000=8219 if ns1socm==315
replace t0mumsoc2000=8222 if ns1socm==317
replace t0mumsoc2000=9111 if ns1socm==320
replace t0mumsoc2000=9119 if ns1socm==322
replace t0mumsoc2000=9129 if ns1socm==324
replace t0mumsoc2000=9132 if ns1socm==326
replace t0mumsoc2000=9133 if ns1socm==327
replace t0mumsoc2000=9134 if ns1socm==328
replace t0mumsoc2000=9139 if ns1socm==329
replace t0mumsoc2000=9149 if ns1socm==331
replace t0mumsoc2000=9211 if ns1socm==332
replace t0mumsoc2000=9219 if ns1socm==333
replace t0mumsoc2000=9222 if ns1socm==335
replace t0mumsoc2000=9223 if ns1socm==336
replace t0mumsoc2000=9224 if ns1socm==337
replace t0mumsoc2000=9225 if ns1socm==338
replace t0mumsoc2000=9226 if ns1socm==339
replace t0mumsoc2000=9229 if ns1socm==340
replace t0mumsoc2000=9233 if ns1socm==343
replace t0mumsoc2000=9234 if ns1socm==344
replace t0mumsoc2000=9235 if ns1socm==345
replace t0mumsoc2000=9241 if ns1socm==347
replace t0mumsoc2000=9242 if ns1socm==348
replace t0mumsoc2000=9243 if ns1socm==349
replace t0mumsoc2000=9244 if ns1socm==350
replace t0mumsoc2000=9245 if ns1socm==351
replace t0mumsoc2000=9249 if ns1socm==352
replace t0mumsoc2000=9251 if ns1socm==353
replace t0mumsoc2000=9259 if ns1socm==354

* END *
