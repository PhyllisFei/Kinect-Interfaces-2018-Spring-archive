var FLOOR_LEVEL = 150;

//define arrays for each type of fountain
var particles = [];
var particlesSway = [];
var particlesWave = [];
var waveCount = [];
var particlesSpin = [];
var particlesCenter = [];
var particlesSmall = [];
var test = [];

var range = 120;
var time = 0;
var stateTakeOut = false;
var state = false;

//set all the intervals for each type of fountain
var interval = 30;
var intervalSway = 20;
var intervalWave = 3;
var intervalSpin = 180;
var intervalSmall = 30;

//define sound-related variables
var ampli, frequ;
var song, analyzer, fft, spe;

//input
var mic;


//gui
// var param = {
//   debugMode: false,
//   upState: false,
//   swayState: false,
//   waveState: false,
//   centerState: false,
//   spinState: false,
//   smallState: false,
//   playRate: 1,
//   pause: false,
// };

// var gui = new dat.gui.GUI();
// gui.add(param, "debugMode")
// gui.add(param, "upState");
// gui.add(param, "swayState");
// gui.add(param, "waveState");
// gui.add(param, "centerState");
// gui.add(param, "spinState");
// gui.add(param, "smallState");
// gui.add(param, 'playRate', 1, 8, 0.1);
// gui.add(param, 'pause');


//preload song
function preload() {
  soundFormats('mp3', 'ogg');
  song = loadSound('assets/StolenDance.mp3');
}

function setup() {

  createCanvas(windowWidth, windowHeight, WEBGL);
  song.play();
  //get the amplitude of the song
  analyzer = new p5.Amplitude();
  analyzer.setInput(song);
  mic = new p5.AudioIn();
  mic.start();
  fullscreen();
}

function keyPressed() {
  if (key == "R") {
    mic = new p5.AudioIn();
    mic.start();
  }
}

function draw() {
  
  if(frameCount % 1000 == 0){
    mic = new p5.AudioIn();
    mic.start();
    print("work!");
  }

  micLevel = mic.getLevel();
  if (song.isPlaying() == false) {
    song.play();
  }
  background(0);
  //get current playtime
  time = song.currentTime();
  //song.rate(param.playRate);

  // if (param.debugMode == false) {
  if (time < 188.3 || time > 151.5) {
    rotateY(frameCount * 0.003);
  }
  //}

  //make the song pausable 
  // if (song.isPlaying()) {
  //   if (param.pause) {
  //     song.pause();
  //   }
  // }
  // if (song.isPaused()) {
  //   if (param.pause == false) {
  //     song.play();
  //   }
  // }

  //get amplitude
  ampli = 12 * analyzer.getLevel();

  //create different kinds of fountains according to playtime
  //if (param.debugMode == false) {
  if (time > 8.3 && time < 57.5 || time > 63 && time < 97 || time > 101 && time < 116 || time > 156 && time < 189.5) {
    createSway();
  }

  if ((time < 57.5 || time > 95 && time < 117) && micLevel > 0.2) {
    wave();
  }

  if (!(time > 62.5 && time < 65 || time > 70 && time < 73 || time > 78.5 && time < 81.5 || time > 87.5 && time < 90 || time > 116 && time < 156 || time > 189.5)) {
    createUp();
  }

  if (time > 118.3 && time < 155 || time > 189.5) {
    createSpin();
  }

  if (time > 118.3 && time < 155 || time > 189.5) {
    createSmall();
  }

  if ((time > 62 && time < 93 || time > 156 && time < 183) && micLevel > 0.2) {
    createCenter();
  }

  // for (var i = 62.7; i < 64; i += 0.6) {
  //   if (time > i && time < (i + 0.2)) {
  //     createCenter();
  //   }
  // }

  // for (var i = 71; i < 72.5; i += 0.6) {
  //   if (time > i && time < (i + 0.2)) {
  //     createCenter();
  //   }
  // }

  // for (var i = 80; i < 81.5; i += 0.6) {
  //   if (time > i && time < (i + 0.2)) {
  //     createCenter();
  //   }
  // }

  // for (var i = 88; i < 89.5; i += 0.6) {
  //   if (time > i && time < (i + 0.2)) {
  //     createCenter();
  //   }
  // }

  // for (var i = 155.5; i < 157; i += 0.6) {
  //   if (time > i && time < (i + 0.2)) {
  //     createCenter();
  //   }
  // }

  // for (var i = 155.5; i < 157; i += 0.6) {
  //   if (time > i && time < (i + 0.2)) {
  //     createCenter();
  //   }
  // }

  // for (var i = 164; i < 165.5; i += 0.6) {
  //   if (time > i && time < (i + 0.2)) {
  //     createCenter();
  //   }
  // }

  // for (var i = 172.5; i < 174; i += 0.6) {
  //   if (time > i && time < (i + 0.2)) {
  //     createCenter();
  //   }
  // }

  // for (var i = 181; i < 182.5; i += 0.6) {
  //   if (time > i && time < (i + 0.2)) {
  //     createCenter();
  //   }
  // }
  //}

  //create different kinds of fountains according to gui
  // if (param.debugMode == true) {
  //   if (param.upState == true) {
  //     createUp();
  //   }
  //   if (param.swayState == true) {
  //     createSway();
  //   }
  //   if (param.centerState == true) {
  //     createCenter();
  //   }
  //   if (param.waveState == true) {
  //     wave();
  //   }
  //   if (param.spinState == true) {
  //     createSpin();
  //   }
  //   if (param.smallState == true) {
  //     createSmall();
  //   }
  // }

  //draw these fountain particles
  up();
  sway();
  left();
  right();
  center();
  spin();
  small();
}

//create wave fountains
function wave() {

  for (var angle = 0; angle < range; angle += intervalWave) {
    var r = 350;
    push();
    translate(r * sin(radians(angle)), FLOOR_LEVEL, r * cos(radians(angle)));
    particlesWave.push(new ParticleWave(angle * 0.05));
    pop();
  }
}

//run wave fountains on the left side
function left() {
  var count = 0;
  for (var i = 0; i < range / intervalWave; i++) {
    for (var a = i; a < particlesWave.length; a += range / intervalWave) {
      var r = 350;
      fill(sin(time) * 50 + 200, cos(time) * 50 + 200, 200);
      push();
      translate(r * sin(radians(i * intervalWave)), FLOOR_LEVEL, r * cos(radians(i * intervalWave)))
      var p = particlesWave[a];

      var gravity = createVector(0, 1 - micLevel * 1.5, 0);
      if (p.isDead == false) {
        gravity.mult(p.mass);
        p.display();
        p.update();
        p.applyForce(gravity);
        p.updateLife();
      } else {
        count = count + 1;
      }
      pop();
    }
  }
  if (count == particlesWave.length) {
    particlesWave.splice(0, particlesWave.length);
  }
}

//run wave fountains on the right side
function right() {
  // print(particlesWave.length);
  for (var i = 180 / intervalWave; i < 2 * range / intervalWave + (180 - range) / intervalWave; i++) {
    for (var a = i; a < particlesWave.length; a += 120 / intervalWave) {
      fill(sin(time) * 50 + 200, cos(time) * 50 + 200, 200);
      var r = 350;
      push();
      translate(r * sin(radians(i * intervalWave)), FLOOR_LEVEL, r * cos(radians(i * intervalWave)))
      var p = particlesWave[a];
      var gravity = createVector(0, 1 - micLevel * 1.5, 0);
      if (p.isDead == false) {
        gravity.mult(p.mass);
        p.display();
        p.update();
        p.applyForce(gravity);
        p.updateLife();
      }
      pop();
    }
  }
}

//create fountains that go up
function createUp() {
  pointLight(120, 130, 255, 100, 100, 100);
  for (var angle = 0; angle < 360; angle += interval) {
    var r = 100;
    push();
    translate(r * sin(radians(angle)), FLOOR_LEVEL, r * cos(radians(angle)));
    sphere(2);
    particles.push(new Particle(0, ampli));
    pop();
  }
}

//run fountains that go up
function up() {

  for (var i = 0; i < 360 / interval; i++) {
    for (var a = i; a < particles.length; a += 360 / interval) {
      var r = 100;

      push();
      translate(r * sin(radians(i * interval)), FLOOR_LEVEL, r * cos(radians(i * interval)))
      var p = particles[a];
      var gravity = createVector(0, 1.1, 0);
      gravity.mult(p.mass);
      fill(500 * micLevel - p.pos.y * 0.5, 100 - p.pos.y * 0.4, 255);
      p.checkBoundary();
      p.update();
      p.applyForce(gravity);
      p.updateLife();
      p.display();

      if (p.isDead) {
        particles.splice(i, 1);
      }

      pop();
    }
  }
}

//create swaying fountains
function createSway() {
  for (var angle = 0; angle < 360; angle += intervalSway) {
    var r = 200;
    var velx;
    if (time * 100 % 108 < 54) {
      velx = map(time * 100 % 54, 0, 26, -1, 1);
    } else {
      velx = map(time * 100 % 54, 0, 26, 1, -1);
    }
    push();
    translate(r * sin(radians(angle)), FLOOR_LEVEL, r * cos(radians(angle)));
    fill(250);
    sphere(1);
    particlesSway.push(new ParticleSway(velx, 0.5));
    pop();
  }
}

//run swaying fountains
function sway() {
  for (var i = 0; i < 360 / intervalSway; i++) {
    for (var a = i; a < particlesSway.length; a += 360 / intervalSway) {
      var r = 200;
      push();
      translate(r * sin(radians(i * intervalSway)), FLOOR_LEVEL, r * cos(radians(i * intervalSway)))
      var p = particlesSway[a];
      var gravity = createVector(0, 1, 0);
      gravity.mult(p.mass);
      fill((50 + micLevel * 500) * p.lifespan, (200 + micLevel * 500) * p.lifespan, (200 - micLevel * 500) * p.lifespan);
      p.checkBoundary();
      p.update();
      p.applyForce(gravity);
      p.updateLife();
      p.display();

      if (p.isDead) {
        particlesSway.splice(i, 1);
      }

      pop();
    }
  }
}

//create center fountains
function createCenter() {
  push();
  for (angle = 0; angle < 360; angle += 5) {
    particlesCenter.push(new ParticleCenter(angle));
  }
  pop();
}

//run center fountains
function center() {
  for (i = 0; i < particlesCenter.length; i++) {
    push();
    translate(0, FLOOR_LEVEL, 0);
    var p = particlesCenter[i];
    var gravity = createVector(0, 5, 0);
    gravity.mult(p.mass);
    p.checkBoundary();
    p.update();
    p.applyForce(gravity);
    p.updateLife();
    p.display();

    if (p.isDead) {
      particlesCenter.splice(i, 1);
    }

    pop();
  }
}

//create spinning fountains
function createSpin() {
  for (var i = 0; i < 6; i++) {
    push();
    translate(0, FLOOR_LEVEL, 0);
    particlesSpin.push(new ParticleSpin(time + i));
    pop();
  }
}

//run spinning fountains
function spin() {
  for (var i = 0; i < particlesSpin.length; i++) {
    push();
    translate(0, FLOOR_LEVEL, 0);
    var p = particlesSpin[i];
    var gravity = createVector(0, 2.2 - micLevel * 5, 0);
    fill((sin(frameCount * 0.05 + 3) * 50 + 200) * p.lifespan, (sin(frameCount * 0.05) * 50 + 200) * p.lifespan, (cos(frameCount * 0.05) * 50 + 200) * p.lifespan);
    gravity.mult(p.mass);
    p.update();
    p.applyForce(gravity);
    p.updateLife();
    p.checkBoundary();
    p.display();

    if (p.isDead) {
      particlesSpin.splice(i, 1);
    }

    pop();
  }
}

//create small fountains
function createSmall() {
  for (var angle = 0; angle < 360; angle += intervalSmall) {
    for (var radius = intervalSmall * 3; radius < intervalSmall * 15 + 1; radius += intervalSmall * 3) {
      particlesSmall.push(new ParticleSmall());
    }
  }
}

//run small fountains
function small() {
  for (var multiples = 0; multiples < floor(particlesSmall.length / 180); multiples++) {
    for (var angle = 0; angle < 360; angle += intervalSmall) {
      for (var radius = intervalSmall * 3; radius < intervalSmall * 15 + 1; radius += intervalSmall * 3) {
        var r = radius;
        fill(-radius * 0.3 + cos(frameCount * 0.05) * 40 + 210, -radius * 0.3 + sin(frameCount * 0.05) * 40 + 210, -radius * 0.3 + sin(frameCount * 0.05) * 40 + 210);
        push();
        translate(r * sin(radians(angle)), FLOOR_LEVEL, r * cos(radians(angle)));
        var pIndex = (angle / intervalSmall) * 5 + ((radius / intervalSmall) - 1) + multiples * 180;
        var p = particlesSmall[pIndex];
        var gravity = createVector(0, 1.2 - micLevel * 0.8, 0);
        gravity.mult(p.mass);
        p.update();
        p.checkBoundary();
        p.applyForce(gravity);
        p.updateLife();
        p.display();
        pop();
      }
    }
  }

  for (var i = particlesSmall.length - 1; i >= 0; i--) {
    if (particlesSmall[i].isDead) {
      particlesSmall.splice(i, 1);
    }
  }

}