import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

Minim minim;
AudioPlayer s1, s2, s3;

PImage kitten, origKitten;

String input = "kitten.png"; // Can be changed to "kitten.png", "kitten_2.jpg", "kitten_3.jpg".

int imagePointer;
final String op0 = "kitten.png";
final String op1 = "kitten_2.jpg";
final String op2 = "kitten_3.jpg";
final String op3 = "kitten_5.jpg";
final String op4 = "kitten_6.jpg";
final String op5 = "kitten_7.jpg";
final String op6 = "kitten_8.jpg";

void setup() {
  size(1024, 512);

  minim = new Minim(this);

  s1 = minim.loadFile("s1.wav");
  s2 = minim.loadFile("s2.wav");
  s3 = minim.loadFile("s3.wav");

  kitten = loadImage(input);
  if (kitten.width != kitten.height) {
    System.err.println("ERROR: Input image needs to be square.");
    try {
      throw new Exception();
    } 
    catch(Exception e) {
      e.printStackTrace();
    }
  }
  kitten.filter(GRAY);
  origKitten = loadImage(input);
  origKitten.filter(GRAY);
  
  s1.play();
  s1.rewind();
}

int index(int x, int y) {
  return x + y * kitten.width;
}

void draw() {
  background(0);
  image(origKitten, 0, 0, 512, 512);
  kitten.loadPixels();
  
  noStroke();
  fill(255);
  rect(0, 512-30, 190, 30);
  
  fill(0);
  textFont(createFont("Carlito", 18));
  textAlign(CENTER, CENTER);
  text("Showing picture " + str(imagePointer + 1) + " of 7", 190/2-2, 512-15-1);
  
  for (int y = 0; y < kitten.height-1; y++) {
    for (int x = 1; x < kitten.width-1; x++) {
      color pix = kitten.pixels[index(x, y)];

      float old_r, old_g, old_b;
      int factor = 1;

      old_r = red(pix);
      old_g = green(pix);
      old_b = blue(pix);

      int new_r = round(factor * old_r / 255) * (255/factor);
      int new_g = round(factor * old_g / 255) * (255/factor);
      int new_b = round(factor * old_b / 255) * (255/factor);

      float err_r = old_r - new_r;
      float err_g = old_g - new_g;
      float err_b = old_b - new_b;

      int index = index(x+1, y);
      color c = kitten.pixels[index];
      float r = red(c);
      float g = green(c);
      float b = blue(c);
      r = r + err_r * 7/16.0;
      g = g + err_g * 7/16.0;
      b = b + err_b * 7/16.0;
      kitten.pixels[index] = color(r, g, b);

      index = index(x-1, y+1);
      c = kitten.pixels[index];
      r = red(c);
      g = green(c);
      b = blue(c);
      r = r + err_r * 3/16.0;
      g = g + err_g * 3/16.0;
      b = b + err_b * 3/16.0;
      kitten.pixels[index] = color(r, g, b);

      index = index(x, y+1);
      c = kitten.pixels[index];
      r = red(c);
      g = green(c);
      b = blue(c);
      r = r + err_r * 5/16.0;
      g = g + err_g * 5/16.0;
      b = b + err_b * 5/16.0;
      kitten.pixels[index] = color(r, g, b);

      index = index(x+1, y+1);
      c = kitten.pixels[index];
      r = red(c);
      g = green(c);
      b = blue(c);
      r = r + err_r * 1/16.0;
      g = g + err_g * 1/16.0;
      b = b + err_b * 1/16.0;
      kitten.pixels[index] = color(r, g, b);

      kitten.pixels[index(x, y)] = color(new_r, new_g, new_b);
    }
  }
  kitten.updatePixels();
  image(kitten, 512, 0, 512, 512);
}


void keyPressed() {
  if (keyCode == UP) {
    
    int rand = floor(random(0, 3));
    
    if(rand == 0) {s1.play(); s1.rewind();}
    if(rand == 1) {s2.play(); s2.rewind();}
    if(rand == 2) {s3.play(); s3.rewind();}
    
    imagePointer++;
    
    if(imagePointer > 6) imagePointer = 0;
    if(imagePointer < 0) imagePointer = 5;

    if (imagePointer % 7 == 0)
      input = op0;

    if (imagePointer % 7 == 1)
      input = op1;

    if (imagePointer % 7 == 2)
      input = op2;
      
    if (imagePointer % 7 == 3)
      input = op3;

    if (imagePointer % 7 == 4)
      input = op4;

    if (imagePointer % 7 == 5)
      input = op5;
      
    if (imagePointer % 7 == 6)
      input = op6;

    kitten = loadImage(input);
    if (kitten.width != kitten.height) {
      System.err.println("ERROR: Input image needs to be square.");
      try {
        throw new Exception();
      } 
      catch(Exception e) {
        e.printStackTrace();
      }
    }
    kitten.filter(GRAY);
    origKitten = loadImage(input);
    origKitten.filter(GRAY);
  }

  if (keyCode == DOWN) {
    
    int rand = floor(random(0, 3));
    
    if(rand == 0) {s1.play(); s1.rewind();}
    if(rand == 1) {s2.play(); s2.rewind();}
    if(rand == 2) {s3.play(); s3.rewind();}
    
    imagePointer--;
    
    if(imagePointer > 6) imagePointer = 0;
    if(imagePointer < 0) imagePointer = 5;

    if (imagePointer % 7 == 0)
      input = op0;

    if (imagePointer % 7 == 1)
      input = op1;

    if (imagePointer % 7 == 2)
      input = op2;
      
    if (imagePointer % 7 == 3)
      input = op3;

    if (imagePointer % 7 == 4)
      input = op4;

    if (imagePointer % 7 == 5)
      input = op5;
      
    if (imagePointer % 7 == 6)
      input = op6;

    kitten = loadImage(input);
    if (kitten.width != kitten.height) {
      System.err.println("ERROR: Input image needs to be square.");
      try {
        throw new Exception();
      } 
      catch(Exception e) {
        e.printStackTrace();
      }
    }
    kitten.filter(GRAY);
    origKitten = loadImage(input);
    origKitten.filter(GRAY);
  }
}
