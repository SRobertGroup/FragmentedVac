// Gmsh project created on Fri Aug 16 08:32:19 2024
SetFactory("OpenCASCADE");
//+
Rectangle(1) = {0, 0, 0, 6, 6, 1};
//+
Rectangle(2) = {-0.2, -.2, 0, 6.4, 6.4, 1.2};//+
Circle(17) = {3,3, 0, 2.8, 0, 2*Pi};
//+
Point(26) = {-0.2, 6.2, 0, 1.0};
//+
Point(27) = {6.2, 6.2, 0, 1.0};
//+
Point(28) = {-0.2, -0.2, 0, 1.0};
//+
Point(29) = {6.2, -0.2, 0, 1.0};

//+
Line(18) = {26, 15};
//+
Line(19) = {26, 14};
//+
Line(20) = {13, 27};
//+
Line(21) = {27, 12};
//+
Line(22) = {29, 11};
//+
Line(23) = {29, 10};
//+
Line(24) = {9, 28};
//+
Line(25) = {28, 16};
//+
Curve Loop(3) = {5, 6, 7, 8, 1, 2, 3, 4};
//+
Curve Loop(4) = {17};
//+
Plane Surface(3) = {3, 4};
//+
Curve Loop(5) = {13, 14, 15, 16, 9, 10, 11, 12};
//+
Curve Loop(6) = {4, 5, 6, 7, 8, 1, 2, 3};
//+
Plane Surface(4) = {5, 6};
//+
Curve Loop(7) = {19, 14, -18};
//+
Plane Surface(5) = {7};
//+
Curve Loop(8) = {20, 21, 12};
//+
Plane Surface(6) = {8};
//+
Curve Loop(9) = {23, 10, -22};
//+
Plane Surface(7) = {9};
//+
Curve Loop(10) = {24, 25, 16};
//+
Plane Surface(8) = {10};
Physical Surface("inter", 3) = {5,6,7,8};

Physical Surface("cell wall", 1) = {4};
Physical Surface("cytoplasm", 2) = {3};
//+
