( Made using CamBam - http://www.cambam.co.uk )
( sidePanel 1/31/2021 11:32:24 PM )
( T2 : 2.0 )
( CUTVIEWER )
( FROM/0,0,5 )
( Select dummy tool to avoid warnings )
( TOOL/MILL,1,0,20.0,0 )
( STOCK/BLOCK,180.0,100.0,4.0,90.0,50.0,4.0 )
G21 G90 G91.1 G64 G40
G0 Z3.0
( T2 : 2.0 )
( Tool Taper coming soon )
( TOOL/MILL,2.0,0.0,0.0,0 )
T2 M6
( frontWallPocket )
G17
M3 S1000
G0 X-3.0 Y-39.5
G0 Z1.0
G1 F300.0 Z0.0
G1 F800.0 X-72.0 Z-0.4
G1 X-3.0
G0 Z3.0
G0 X-72.4
G0 Z1.0
G1 F300.0 Z0.0
G1 F800.0 Y-39.1 Z-0.0011
G1 X-2.6 Z-0.1989
G1 Y-39.9 Z-0.2011
G1 X-72.4 Z-0.3989
G1 Y-39.5 Z-0.4
G1 F300.0 X-73.2
G1 F800.0 Y-38.3
G1 X-1.8
G1 Y-40.7
G1 X-73.2
G1 Y-39.5
G1 F300.0 X-74.0
G1 F800.0 Y-37.5
G1 X-1.0
G1 Y-41.5
G1 X-74.0
G1 Y-39.5
G0 Z3.0
G0 X-3.0
G0 Z0.6
G1 F300.0 Z-0.4
G1 F800.0 X-72.0 Z-0.8
G1 X-3.0
G0 Z3.0
G0 X-72.4
G0 Z0.6
G1 F300.0 Z-0.4
G1 F800.0 Y-39.1 Z-0.4011
G1 X-2.6 Z-0.5989
G1 Y-39.9 Z-0.6011
G1 X-72.4 Z-0.7989
G1 Y-39.5 Z-0.8
G1 F300.0 X-73.2
G1 F800.0 Y-38.3
G1 X-1.8
G1 Y-40.7
G1 X-73.2
G1 Y-39.5
G1 F300.0 X-74.0
G1 F800.0 Y-37.5
G1 X-1.0
G1 Y-41.5
G1 X-74.0
G1 Y-39.5
G0 Z3.0
G0 X-3.0
G0 Z0.2
G1 F300.0 Z-0.8
G1 F800.0 X-72.0 Z-1.2
G1 X-3.0
G0 Z3.0
G0 X-72.4
G0 Z0.2
G1 F300.0 Z-0.8
G1 F800.0 Y-39.1 Z-0.8011
G1 X-2.6 Z-0.9989
G1 Y-39.9 Z-1.0011
G1 X-72.4 Z-1.1989
G1 Y-39.5 Z-1.2
G1 F300.0 X-73.2
G1 F800.0 Y-38.3
G1 X-1.8
G1 Y-40.7
G1 X-73.2
G1 Y-39.5
G1 F300.0 X-74.0
G1 F800.0 Y-37.5
G1 X-1.0
G1 Y-41.5
G1 X-74.0
G1 Y-39.5
G0 Z3.0
G0 X-3.0
G0 Z-0.2
G1 F300.0 Z-1.2
G1 F800.0 X-72.0 Z-1.6
G1 X-3.0
G0 Z3.0
G0 X-72.4
G0 Z-0.2
G1 F300.0 Z-1.2
G1 F800.0 Y-39.1 Z-1.2011
G1 X-2.6 Z-1.3989
G1 Y-39.9 Z-1.4011
G1 X-72.4 Z-1.5989
G1 Y-39.5 Z-1.6
G1 F300.0 X-73.2
G1 F800.0 Y-38.3
G1 X-1.8
G1 Y-40.7
G1 X-73.2
G1 Y-39.5
G1 F300.0 X-74.0
G1 F800.0 Y-37.5
G1 X-1.0
G1 Y-41.5
G1 X-74.0
G1 Y-39.5
G0 Z3.0
G0 X-3.0
G0 Z-0.6
G1 F300.0 Z-1.6
G1 F800.0 X-72.0 Z-2.0
G1 X-3.0
G0 Z3.0
G0 X-72.4
G0 Z-0.6
G1 F300.0 Z-1.6
G1 F800.0 Y-39.1 Z-1.6011
G1 X-2.6 Z-1.7989
G1 Y-39.9 Z-1.8011
G1 X-72.4 Z-1.9989
G1 Y-39.5 Z-2.0
G1 Y-39.1
G1 X-2.6
G1 Y-39.9
G1 X-72.4
G1 Y-39.5
G1 F300.0 X-73.2
G1 F800.0 Y-38.3
G1 X-1.8
G1 Y-40.7
G1 X-73.2
G1 Y-39.5
G1 F300.0 X-74.0
G1 F800.0 Y-37.5
G1 X-1.0
G1 Y-41.5
G1 X-74.0
G1 Y-39.5
( wallbackPocket )
S1000
G0 Z3.0
G0 X-1.8 Y40.3
G0 Z1.0
G1 F300.0 Z0.0
G1 F800.0 X-73.2 Z-0.1989
G1 Y40.7 Z-0.2
G1 X-1.8 Z-0.3989
G1 Y40.3 Z-0.4
G1 F300.0 Y39.5
G1 F800.0 X-74.0
G1 Y41.5
G1 X-1.0
G1 Y39.5
G1 X-1.8
G1 F300.0 Y40.3
G1 F800.0 X-73.2 Z-0.5989
G1 Y40.7 Z-0.6
G1 X-1.8 Z-0.7989
G1 Y40.3 Z-0.8
G1 F300.0 Y39.5
G1 F800.0 X-74.0
G1 Y41.5
G1 X-1.0
G1 Y39.5
G1 X-1.8
G1 F300.0 Y40.3
G1 F800.0 X-73.2 Z-0.9989
G1 Y40.7 Z-1.0
G1 X-1.8 Z-1.1989
G1 Y40.3 Z-1.2
G1 F300.0 Y39.5
G1 F800.0 X-74.0
G1 Y41.5
G1 X-1.0
G1 Y39.5
G1 X-1.8
G1 F300.0 Y40.3
G1 F800.0 X-73.2 Z-1.3989
G1 Y40.7 Z-1.4
G1 X-1.8 Z-1.5989
G1 Y40.3 Z-1.6
G1 F300.0 Y39.5
G1 F800.0 X-74.0
G1 Y41.5
G1 X-1.0
G1 Y39.5
G1 X-1.8
G1 F300.0 Y40.3
G1 F800.0 X-73.2 Z-1.7989
G1 Y40.7 Z-1.8
G1 X-1.8 Z-1.9989
G1 Y40.3 Z-2.0
G1 X-73.2
G1 Y40.7
G1 X-1.8
G1 Y40.3
G1 F300.0 Y39.5
G1 F800.0 X-74.0
G1 Y41.5
G1 X-1.0
G1 Y39.5
G1 X-1.8
( edgeProfile )
S1000
G0 Z3.0
G0 X0.0 Y43.5
G0 Z1.0
G1 F300.0 Z0.0
G1 F800.0 X-75.0 Z-0.0919
G3 X-76.0 Y42.5 Z-0.0939 I0.0 J-1.0
G1 Y-42.5 Z-0.1981
G3 X-75.0 Y-43.5 Z-0.2 I1.0 J0.0
G1 X0.0 Z-0.2919
G3 X1.0 Y-42.5 Z-0.2939 I0.0 J1.0
G1 Y42.5 Z-0.3981
G3 X0.0 Y43.5 Z-0.4 I-1.0 J0.0
G1 X-75.0 Z-0.4919
G3 X-76.0 Y42.5 Z-0.4939 I0.0 J-1.0
G1 Y-42.5 Z-0.5981
G3 X-75.0 Y-43.5 Z-0.6 I1.0 J0.0
G1 X0.0 Z-0.6919
G3 X1.0 Y-42.5 Z-0.6939 I0.0 J1.0
G1 Y42.5 Z-0.7981
G3 X0.0 Y43.5 Z-0.8 I-1.0 J0.0
G1 X-75.0 Z-0.8919
G3 X-76.0 Y42.5 Z-0.8939 I0.0 J-1.0
G1 Y-42.5 Z-0.9981
G3 X-75.0 Y-43.5 Z-1.0 I1.0 J0.0
G1 X0.0 Z-1.0919
G3 X1.0 Y-42.5 Z-1.0939 I0.0 J1.0
G1 Y42.5 Z-1.1981
G3 X0.0 Y43.5 Z-1.2 I-1.0 J0.0
G1 X-75.0 Z-1.2919
G3 X-76.0 Y42.5 Z-1.2939 I0.0 J-1.0
G1 Y-42.5 Z-1.3981
G3 X-75.0 Y-43.5 Z-1.4 I1.0 J0.0
G1 X0.0 Z-1.4919
G3 X1.0 Y-42.5 Z-1.4939 I0.0 J1.0
G1 Y42.5 Z-1.5981
G3 X0.0 Y43.5 Z-1.6 I-1.0 J0.0
G1 X-75.0 Z-1.6919
G3 X-76.0 Y42.5 Z-1.6939 I0.0 J-1.0
G1 Y-42.5 Z-1.7981
G3 X-75.0 Y-43.5 Z-1.8 I1.0 J0.0
G1 X0.0 Z-1.8919
G3 X1.0 Y-42.5 Z-1.8939 I0.0 J1.0
G1 Y42.5 Z-1.9981
G3 X0.0 Y43.5 Z-2.0 I-1.0 J0.0
G1 X-75.0 Z-2.0919
G3 X-76.0 Y42.5 Z-2.0939 I0.0 J-1.0
G1 Y-42.5 Z-2.1981
G3 X-75.0 Y-43.5 Z-2.2 I1.0 J0.0
G1 X0.0 Z-2.2919
G3 X1.0 Y-42.5 Z-2.2939 I0.0 J1.0
G1 Y42.5 Z-2.3981
G3 X0.0 Y43.5 Z-2.4 I-1.0 J0.0
G1 X-75.0 Z-2.4919
G3 X-76.0 Y42.5 Z-2.4939 I0.0 J-1.0
G1 Y-42.5 Z-2.5981
G3 X-75.0 Y-43.5 Z-2.6 I1.0 J0.0
G1 X0.0 Z-2.6919
G3 X1.0 Y-42.5 Z-2.6939 I0.0 J1.0
G1 Y42.5 Z-2.7981
G3 X0.0 Y43.5 Z-2.8 I-1.0 J0.0
G1 X-75.0 Z-2.8919
G3 X-76.0 Y42.5 Z-2.8939 I0.0 J-1.0
G1 Y-42.5 Z-2.9981
G3 X-75.0 Y-43.5 Z-3.0 I1.0 J0.0
G1 X0.0 Z-3.0919
G3 X1.0 Y-42.5 Z-3.0939 I0.0 J1.0
G1 Y42.5 Z-3.1981
G3 X0.0 Y43.5 Z-3.2 I-1.0 J0.0
G1 X-75.0 Z-3.2919
G3 X-76.0 Y42.5 Z-3.2939 I0.0 J-1.0
G1 Y-42.5 Z-3.3981
G3 X-75.0 Y-43.5 Z-3.4 I1.0 J0.0
G1 X0.0 Z-3.4919
G3 X1.0 Y-42.5 Z-3.4939 I0.0 J1.0
G1 Y42.5 Z-3.5981
G3 X0.0 Y43.5 Z-3.6 I-1.0 J0.0
G1 X-75.0 Z-3.6919
G3 X-76.0 Y42.5 Z-3.6939 I0.0 J-1.0
G1 Y-42.5 Z-3.7981
G3 X-75.0 Y-43.5 Z-3.8 I1.0 J0.0
G1 X0.0 Z-3.8919
G3 X1.0 Y-42.5 Z-3.8939 I0.0 J1.0
G1 Y42.5 Z-3.9981
G3 X0.0 Y43.5 Z-4.0 I-1.0 J0.0
G1 X-75.0 Z-4.046
G3 X-76.0 Y42.5 Z-4.0469 I0.0 J-1.0
G1 Y-42.5 Z-4.099
G3 X-75.0 Y-43.5 Z-4.1 I1.0 J0.0
G1 X0.0 Z-4.146
G3 X1.0 Y-42.5 Z-4.1469 I0.0 J1.0
G1 Y42.5 Z-4.199
G3 X0.0 Y43.5 Z-4.2 I-1.0 J0.0
G1 X-75.0
G3 X-76.0 Y42.5 I0.0 J-1.0
G1 Y-42.5
G3 X-75.0 Y-43.5 I1.0 J0.0
G1 X0.0
G3 X1.0 Y-42.5 I0.0 J1.0
G1 Y42.5
G3 X0.0 Y43.5 I-1.0 J0.0
G0 Z3.0
M5
M30
