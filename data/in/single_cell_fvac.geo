// Gmsh project created on Fri Aug 16 08:32:19 2024
SetFactory("OpenCASCADE");
//+
Rectangle(1) = {0, 0, 0, 6, 6, 1};
//+
Rectangle(2) = {-0.2, -.2, 0, 6.4, 6.4, 1.2};//+
Circle(17) = {5.19,3.5, 0, 0.75, 0, 2*Pi};
Circle(18) = {3.11,5.14, 0, 0.82, 0, 2*Pi};
Circle(19) = {1.13,2.65, 0, 0.99, 0, 2*Pi};
Circle(20) = {2.79,1.02, 0, 0.99, 0, 2*Pi};
Circle(21) = {5.16,5.12, 0, 0.76, 0, 2*Pi};
Circle(22) = {1.20,4.75, 0, 1.09, 0, 2*Pi};
Circle(23) = {0.96,0.83, 0, 0.79, 0, 2*Pi};
Circle(24) = {3.3,3.28, 0, 0.99, 0, 2*Pi};
Circle(25) = {4.85,1.6, 0, 1.13, 0, 2*Pi};
//+
Curve Loop(3) = {6, 7, 8, 1, 2, 3, 4, 5};
//+
Curve Loop(4) = {22};
//+
Curve Loop(5) = {19};
//+
Curve Loop(6) = {23};
//+
Curve Loop(7) = {20};
//+
Curve Loop(8) = {24};
//+
Curve Loop(9) = {18};
//+
Curve Loop(10) = {21};
//+
Curve Loop(11) = {17};
//+
Curve Loop(12) = {25};
//+
Plane Surface(3) = {3, 4, 5, 6, 7, 8, 9, 10, 11, 12};
//+
Curve Loop(13) = {13, 14, 15, 16, 9, 10, 11, 12};
//+
Curve Loop(14) = {5, 6, 7, 8, 1, 2, 3, 4};
//+
Plane Surface(4) = {13, 14};

Physical Surface("cell wall", 1) = {4};
Physical Surface("cytoplasm", 2) = {3};
//+
Coherence;
//+
Point(26) = {-0.2, 6.2, 0, 1.0};
//+
Point(27) = {6.2, 6.2, 0, 1.0};
//+
Point(28) = {-0.2, -0.2, 0, 1.0};
//+
Point(29) = {6.2, -0.2, 0, 1.0};
//+
Line(26) = {26, 20};
//+
Line(27) = {26, 19};
//+
Line(28) = {18, 27};
//+
Line(29) = {27, 25};
//+
Line(30) = {23, 29};
//+
Line(31) = {29, 24};
//+
Line(32) = {22, 28};
//+
Line(33) = {28, 21};
//+
Curve Loop(10) = {26, -19, -27};
//+
Surface(14) = {10};
//+
Curve Loop(12) = {28, 29, 25};
//+
Surface(15) = {12};
//+
Curve Loop(14) = {30, 31, -23};
//+
Surface(16) = {14};
//+
Curve Loop(16) = {32, 33, 21};
//+
Surface(17) = {16};
Physical Surface("inter", 3) = {14, 15,16,17};