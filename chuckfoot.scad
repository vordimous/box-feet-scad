$fn = 30;
shH = 40;
whallT = 4;
shN = shH-whallT;
legH = shH /2;
slot = 6.35;

module base() {
    difference(){
        cube(shH);
        union(){
            cube([shN - slot, shN - slot, shN+slot]);
            cube([slot, shN, shN+slot]);
            cube([shN, slot, shN+slot]);
        }
        
    }
}

module leg(){
    legB = shH - whallT;
    legP = [
      [  0,  0,  0 ],  //0
      [ legB,  0,  0 ],  //1
      [ legB,  legB,  0 ],  //2
      [  0,  legB,  0 ],  //3
      [  0,  0,  legH  ],  //4
      [ shH,  0,  legH  ],  //5
      [ shH,  shH,  legH  ],  //6
      [  0,  shH,  legH  ]]; //7
    CubeFaces = [
      [0,1,2,3],  // bottom
      [4,5,1,0],  // front
      [7,6,5,4],  // top
      [5,6,2,1],  // right
      [6,7,3,2],  // back
      [7,4,0,3]];
    polyhedron(legP, CubeFaces);
}

module pedistal(){
    intersection(){
        leg();
        translate([slot,slot,legH - slot]){
            cube([shN, shN, slot]);
        }
    }
}

module foot(){
    difference(){
        leg();
        translate([0,0,legH - slot]){
            cube([shN+slot, shN+slot, slot]);
        }
    }
}

base();
translate([0,0,-legH]){
    pedistal();
    foot();
}
