const DURARTION = 1.3;
const EASING = 2;

function createPhotoCube(callback) { 
	//create cube root
	var cube = new THREE.Object3D();

	//add parameters
	cube.isChanging = false;
	cube.state = 0;
	cube.animTime = 0;
	
    const loader = new THREE.TextureLoader();
	loader.setPath('img/');

	
	//create cubes & state
	for(var x=0;x<2;x++) {
		for(var y=0;y<2;y++) {
			for(var z=0;z<2;z++) {
				var cubeName = `${x}${y}${z}`;

				//create material
				var material = [
					new THREE.MeshBasicMaterial( { map: loader.load(`${cubeName}r.png`) } ),
					new THREE.MeshBasicMaterial( { map: loader.load(`${cubeName}l.png`) } ),
					new THREE.MeshBasicMaterial( { map: loader.load(`${cubeName}u.png`) } ),
					new THREE.MeshBasicMaterial( { map: loader.load(`${cubeName}d.png`) } ),
					new THREE.MeshBasicMaterial( { map: loader.load(`${cubeName}f.png`) } ),
					new THREE.MeshBasicMaterial( { map: loader.load(`${cubeName}b.png`) } )
				];

				//create base cube
				var subCube = new THREE.Mesh(
					new THREE.BoxGeometry(1,1,1),
					material);
				
				//set cube name
				subCube.name = cubeName;

				//move to position
				subCube.position.set(x-.5,y-.5,z-.5);

				//add to cube root
				cube.add(subCube);
			}
		}
	}

	//create rotators
	cube.rotatorA = new THREE.Object3D();
	cube.add(cube.rotatorA);
	cube.rotatorB = new THREE.Object3D();
	cube.add(cube.rotatorB);

	callback(addCubeFunctions(cube));
}

function addCubeFunctions(cube) {
	//add functions
	cube.update = function(dt) {
		//handle animations
		if(!this.isChanging)
			return;
		
		this.animate(dt);
	}
	
	cube.nextState = function(callback = null) {
		this.changeState(this.state+1, callback);
	}
	cube.prevState = function(callback = null) {
		this.changeState(this.state-1, callback);
	}
	cube.changeState = function(newState, callback) {
		if(this.isChanging)
			return;

		newState = limitToRange(newState);

		//run the state setup method
		this[`setupAnimation${this.state}To${newState}`]();

		this.animate = this[`animate${this.state}To${newState}`];
		this.isChanging = true;
		this.animTime = 0;
		this.callback = callback;
	}

	cube.child = (childName) => cube.children.find((child) => child.name === childName);
	
	addCubeAnimationSetups(cube);
	addCubeAnimationRoutines(cube);

	return cube;
}

function addCubeAnimationSetups(cube) {
	cube.setupAnimation0To1 = function() {
		this.rotatorA.position.set(-1, 0, 0);
		this.rotatorA.rotation.set( 0, 0, 0);
		this.rotatorB.position.set( 1, 0, 0);
		this.rotatorB.rotation.set( 0, 0, 0);

		this.child("010").position.x += 1;
		this.child("011").position.x += 1;
		this.rotatorA.add(this.child("010"));
		this.rotatorA.add(this.child("011"));

		this.child("110").position.x -= 1;
		this.child("111").position.x -= 1;
		this.rotatorB.add(this.child("110"));
		this.rotatorB.add(this.child("111"));
	}
	cube.setupAnimation1To2 = function() {
		this.rotatorA.position.set( 0,-.5, 0);
		this.rotatorA.rotation.set( 0,  0, 0);
		this.rotatorB.position.set( 0,-.5, 0);
		this.rotatorB.rotation.set( 0,  0, 0);

		this.child("010").position.y += .5;
		this.child("000").position.y += .5;
		this.child("100").position.y += .5;
		this.child("110").position.y += .5;
		this.child("011").position.y += .5;
		this.child("001").position.y += .5;
		this.child("101").position.y += .5;
		this.child("111").position.y += .5;

		this.rotatorA.add(this.child("010"));
		this.rotatorA.add(this.child("000"));
		this.rotatorA.add(this.child("100"));
		this.rotatorA.add(this.child("110"));

		this.rotatorB.add(this.child("011"));
		this.rotatorB.add(this.child("001"));
		this.rotatorB.add(this.child("101"));
		this.rotatorB.add(this.child("111"));
	}
	cube.setupAnimation2To3 = function() {
		this.rotatorA.position.set( 0,-.5, 0);
		this.rotatorA.rotation.set( 0,  0, 0);
		this.rotatorB.position.set( 0,-.5, 0);
		this.rotatorB.rotation.set( 0,  0, 0);
		
		this.child("010").position.y += .5;
		this.child("000").position.y += .5;
		this.child("100").position.y += .5;
		this.child("110").position.y += .5;
		this.child("011").position.y += .5;
		this.child("001").position.y += .5;
		this.child("101").position.y += .5;
		this.child("111").position.y += .5;

		this.rotatorA.add(this.child("010"));
		this.rotatorA.add(this.child("000"));
		this.rotatorA.add(this.child("011"));
		this.rotatorA.add(this.child("001"));

		this.rotatorB.add(this.child("100"));
		this.rotatorB.add(this.child("101"));
		this.rotatorB.add(this.child("110"));
		this.rotatorB.add(this.child("111"));
	}
	cube.setupAnimation3To4 = function() {
		this.rotatorA.position.set( 0, 0,-1);
		this.rotatorA.rotation.set( 0, 0, 0);
		this.rotatorB.position.set( 0, 0, 1);
		this.rotatorB.rotation.set( 0, 0, 0);

		this.child("000").position.z += 1;
		this.child("100").position.z += 1;
		this.rotatorA.add(this.child("000"));
		this.rotatorA.add(this.child("100"));

		this.child("001").position.z -= 1;
		this.child("101").position.z -= 1;
		this.rotatorB.add(this.child("001"));
		this.rotatorB.add(this.child("101"));
	}
	cube.setupAnimation4To5 = function() {
		this.rotatorA.position.set( 0,-.5, 0);
		this.rotatorA.rotation.set( 0,  0, 0);
		this.rotatorB.position.set( 0,-.5, 0);
		this.rotatorB.rotation.set( 0,  0, 0);

		this.child("010").position.y += .5;
		this.child("000").position.y += .5;
		this.child("100").position.y += .5;
		this.child("110").position.y += .5;
		this.child("011").position.y += .5;
		this.child("001").position.y += .5;
		this.child("101").position.y += .5;
		this.child("111").position.y += .5;

		this.rotatorA.add(this.child("000"));
		this.rotatorA.add(this.child("010"));
		this.rotatorA.add(this.child("011"));
		this.rotatorA.add(this.child("001"));

		this.rotatorB.add(this.child("100"));
		this.rotatorB.add(this.child("110"));
		this.rotatorB.add(this.child("111"));
		this.rotatorB.add(this.child("101"));
	}
	cube.setupAnimation5To0 = function() {
		this.rotatorA.position.set( 0,-.5, 0);
		this.rotatorA.rotation.set( 0,  0, 0);
		this.rotatorB.position.set( 0,-.5, 0);
		this.rotatorB.rotation.set( 0,  0, 0);

		this.child("010").position.y += .5;
		this.child("000").position.y += .5;
		this.child("100").position.y += .5;
		this.child("110").position.y += .5;
		this.child("011").position.y += .5;
		this.child("001").position.y += .5;
		this.child("101").position.y += .5;
		this.child("111").position.y += .5;

		this.rotatorA.add(this.child("000"));
		this.rotatorA.add(this.child("100"));
		this.rotatorA.add(this.child("010"));
		this.rotatorA.add(this.child("110"));
		
		this.rotatorB.add(this.child("001"));
		this.rotatorB.add(this.child("101"));
		this.rotatorB.add(this.child("011"));
		this.rotatorB.add(this.child("111"));
	}

	cube.setupAnimation1To0 = function() {
		this.rotatorA.position.set(-1,.5, 0);
		this.rotatorA.rotation.set( 0, 0, 0);
		this.rotatorB.position.set( 1,.5, 0);
		this.rotatorB.rotation.set( 0, 0, 0);


		this.child("010").position.x += 1;
		this.child("010").position.y -= .5;
		this.child("011").position.x += 1;
		this.child("011").position.y -= .5;
		this.rotatorA.add(this.child("010"));
		this.rotatorA.add(this.child("011"));

		this.child("110").position.x -= 1;
		this.child("110").position.y -= .5;
		this.child("111").position.x -= 1;
		this.child("111").position.y -= .5;
		this.rotatorB.add(this.child("110"));
		this.rotatorB.add(this.child("111"));
	}
	cube.setupAnimation2To1 = function() {
		this.rotatorA.position.set( 0,.5, 0);
		this.rotatorA.rotation.set( 0, 0, 0);
		this.rotatorB.position.set( 0,.5, 0);
		this.rotatorB.rotation.set( 0, 0, 0);

		this.child("010").position.y -= .5;
		this.child("000").position.y -= .5;
		this.child("100").position.y -= .5;
		this.child("110").position.y -= .5;
		this.child("011").position.y -= .5;
		this.child("001").position.y -= .5;
		this.child("101").position.y -= .5;
		this.child("111").position.y -= .5;

		this.rotatorA.add(this.child("010"));
		this.rotatorA.add(this.child("000"));
		this.rotatorA.add(this.child("100"));
		this.rotatorA.add(this.child("110"));

		this.rotatorB.add(this.child("011"));
		this.rotatorB.add(this.child("001"));
		this.rotatorB.add(this.child("101"));
		this.rotatorB.add(this.child("111"));
	}
	cube.setupAnimation3To2 = function() {
		this.rotatorA.position.set( 0, 1, 0);
		this.rotatorA.rotation.set( 0, 0, 0);
		this.rotatorB.position.set( 0, 1, 0);
		this.rotatorB.rotation.set( 0, 0, 0);

		this.child("010").position.y -= 1;
		this.child("000").position.y -= 1;
		this.child("100").position.y -= 1;
		this.child("110").position.y -= 1;
		this.child("011").position.y -= 1;
		this.child("001").position.y -= 1;
		this.child("101").position.y -= 1;
		this.child("111").position.y -= 1;

		this.rotatorA.add(this.child("010"));
		this.rotatorA.add(this.child("000"));
		this.rotatorA.add(this.child("011"));
		this.rotatorA.add(this.child("001"));

		this.rotatorB.add(this.child("100"));
		this.rotatorB.add(this.child("101"));
		this.rotatorB.add(this.child("110"));
		this.rotatorB.add(this.child("111"));
	}
	cube.setupAnimation4To3 = function() {
		this.rotatorA.position.set( 0,.5,-1);
		this.rotatorA.rotation.set( 0, 0, 0);
		this.rotatorB.position.set( 0,.5, 1);
		this.rotatorB.rotation.set( 0, 0, 0);

		this.child("000").position.z += 1;
		this.child("000").position.y -= .5;
		this.child("100").position.z += 1;
		this.child("100").position.y -= .5;
		this.rotatorA.add(this.child("000"));
		this.rotatorA.add(this.child("100"));

		this.child("001").position.z -= 1;
		this.child("001").position.y -= .5;
		this.child("101").position.z -= 1;
		this.child("101").position.y -= .5;
		this.rotatorB.add(this.child("001"));
		this.rotatorB.add(this.child("101"));
	}
	cube.setupAnimation5To4 = function() {
		this.rotatorA.position.set( 0,.5, 0);
		this.rotatorA.rotation.set( 0, 0, 0);
		this.rotatorB.position.set( 0,.5, 0);
		this.rotatorB.rotation.set( 0, 0, 0);

		this.child("010").position.y -= .5;
		this.child("000").position.y -= .5;
		this.child("100").position.y -= .5;
		this.child("110").position.y -= .5;
		this.child("011").position.y -= .5;
		this.child("001").position.y -= .5;
		this.child("101").position.y -= .5;
		this.child("111").position.y -= .5;

		this.rotatorA.add(this.child("000"));
		this.rotatorA.add(this.child("010"));
		this.rotatorA.add(this.child("011"));
		this.rotatorA.add(this.child("001"));

		this.rotatorB.add(this.child("100"));
		this.rotatorB.add(this.child("110"));
		this.rotatorB.add(this.child("111"));
		this.rotatorB.add(this.child("101"));
	}
	cube.setupAnimation0To5 = function() {
		this.rotatorA.position.set( 0, 1, 0);
		this.rotatorA.rotation.set( 0, 0, 0);
		this.rotatorB.position.set( 0, 1, 0);
		this.rotatorB.rotation.set( 0, 0, 0);

		this.child("010").position.y -= 1;
		this.child("000").position.y -= 1;
		this.child("100").position.y -= 1;
		this.child("110").position.y -= 1;
		this.child("011").position.y -= 1;
		this.child("001").position.y -= 1;
		this.child("101").position.y -= 1;
		this.child("111").position.y -= 1;

		this.rotatorA.add(this.child("000"));
		this.rotatorA.add(this.child("100"));
		this.rotatorA.add(this.child("010"));
		this.rotatorA.add(this.child("110"));
		
		this.rotatorB.add(this.child("001"));
		this.rotatorB.add(this.child("101"));
		this.rotatorB.add(this.child("011"));
		this.rotatorB.add(this.child("111"));
	}
}

function addCubeAnimationRoutines(cube) {
	//setups for both directions
	cube.animate0To1 = function(dt) {
		this.animTime += dt;
		var progress = getProgress(this.animTime);
		var easing = getEasing(progress);

		var cubeY = easing/2 - .5;
		var rotatorTheta = easing*Math.PI;

		// set rotation for rotatorA and rotatorB
		this.rotatorA.rotation.z = rotatorTheta;
		this.rotatorB.rotation.z = -rotatorTheta;

		//update positions
		this.rotatorA.position.y = easing/2;
		this.rotatorB.position.y = easing/2;
		this.child("000").position.y = cubeY;
		this.child("001").position.y = cubeY;
		this.child("100").position.y = cubeY;
		this.child("101").position.y = cubeY;
		
		if(progress == 1)
			this.completeAnimation(1);
	}
	cube.animate1To2 = function(dt) {
		this.animTime += dt;
		var progress = getProgress(this.animTime);
		var easing = getEasing(progress);
		
		var rotatorY = easing - .5;
		var rotatorTheta = easing*Math.PI/2;

		// set rotation for rotatorA and rotatorB
		this.rotatorA.rotation.x = -rotatorTheta;
		this.rotatorB.rotation.x = rotatorTheta;

		//update positions
		this.rotatorA.position.y = rotatorY;
		this.rotatorB.position.y = rotatorY;

		if(progress == 1)
			this.completeAnimation(2);
	}
	cube.animate2To3 = function(dt) {
		this.animTime += dt;
		var progress = getProgress(this.animTime);
		var easing = getEasing(progress);
		
		var rotatorY = (3*easing-1)/2;
		var rotatorTheta = easing*Math.PI/2;

		// set rotation for rotatorA and rotatorB
		this.rotatorA.rotation.z = rotatorTheta;
		this.rotatorB.rotation.z = -rotatorTheta;

		//update positions
		this.rotatorA.position.y = rotatorY;
		this.rotatorB.position.y = rotatorY;

		if(progress == 1)
			this.completeAnimation(3);
	}
	cube.animate3To4 = function(dt) {
		this.animTime += dt;
		var progress = getProgress(this.animTime);
		var easing = getEasing(progress);

		var cubeY = easing/2 - .5;
		var rotatorTheta = easing*Math.PI;

		// set rotation for rotatorA and rotatorB
		this.rotatorA.rotation.x = -rotatorTheta;
		this.rotatorB.rotation.x = rotatorTheta;

		//update positions
		this.rotatorA.position.y = easing/2;
		this.rotatorB.position.y = easing/2;
		this.child("010").position.y = cubeY;
		this.child("011").position.y = cubeY;
		this.child("110").position.y = cubeY;
		this.child("111").position.y = cubeY;
		
		if(progress == 1)
			this.completeAnimation(4);
	}
	cube.animate4To5 = function(dt) {
		this.animTime += dt;
		var progress = getProgress(this.animTime);
		var easing = getEasing(progress);
		
		var rotatorY = easing - .5;
		var rotatorTheta = easing*Math.PI/2;

		// set rotation for rotatorA and rotatorB
		this.rotatorA.rotation.z = rotatorTheta;
		this.rotatorB.rotation.z = -rotatorTheta;

		//update positions
		this.rotatorA.position.y = rotatorY;
		this.rotatorB.position.y = rotatorY;

		if(progress == 1)
			this.completeAnimation(5);
	}
	cube.animate5To0 = function(dt) {
		this.animTime += dt;
		var progress = getProgress(this.animTime);
		var easing = getEasing(progress);
		
		var rotatorY = (3*easing-1)/2;
		var rotatorTheta = easing*Math.PI/2;

		// set rotation for rotatorA and rotatorB
		this.rotatorA.rotation.x = -rotatorTheta;
		this.rotatorB.rotation.x = rotatorTheta;

		//update positions
		this.rotatorA.position.y = rotatorY;
		this.rotatorB.position.y = rotatorY;

		if(progress == 1)
			this.completeAnimation(0);
	}

	cube.animate1To0 = function(dt) {
		this.animTime += dt;
		var progress = getProgress(this.animTime);
		var easing = getEasing(progress);

		var cubeY = -(easing/2);
		var rotatorY = (1-easing)/2;
		var rotatorTheta = easing*Math.PI;

		// set rotation for rotatorA and rotatorB
		this.rotatorA.rotation.z = -rotatorTheta;
		this.rotatorB.rotation.z = rotatorTheta;

		//update positions
		this.rotatorA.position.y = rotatorY;
		this.rotatorB.position.y = rotatorY;
		this.child("000").position.y = cubeY;
		this.child("001").position.y = cubeY;
		this.child("100").position.y = cubeY;
		this.child("101").position.y = cubeY;
		
		if(progress == 1)
			this.completeAnimation(0);
	}
	cube.animate2To1 = function(dt) {
		this.animTime += dt;
		var progress = getProgress(this.animTime);
		var easing = getEasing(progress);
		
		var rotatorY = .5-easing;
		var rotatorTheta = easing*Math.PI/2;

		// set rotation for rotatorA and rotatorB
		this.rotatorA.rotation.x = rotatorTheta;
		this.rotatorB.rotation.x = -rotatorTheta;

		//update positions
		this.rotatorA.position.y = rotatorY;
		this.rotatorB.position.y = rotatorY;

		if(progress == 1)
			this.completeAnimation(1);
	}
	cube.animate3To2 = function(dt) {
		this.animTime += dt;
		var progress = getProgress(this.animTime);
		var easing = getEasing(progress);
		
		var rotatorY = 3*(1-easing)/2-.5;
		var rotatorTheta = easing*Math.PI/2;

		// set rotation for rotatorA and rotatorB
		this.rotatorA.rotation.z = -rotatorTheta;
		this.rotatorB.rotation.z = rotatorTheta;

		//update positions
		this.rotatorA.position.y = rotatorY;
		this.rotatorB.position.y = rotatorY;

		if(progress == 1)
			this.completeAnimation(2);
	}
	cube.animate4To3 = function(dt) {
		this.animTime += dt;
		var progress = getProgress(this.animTime);
		var easing = getEasing(progress);

		var cubeY = -.5*easing;
		var rotatorY = (1-easing)/2;
		var rotatorTheta = easing*Math.PI;

		// set rotation for rotatorA and rotatorB
		this.rotatorA.rotation.x = rotatorTheta;
		this.rotatorB.rotation.x = -rotatorTheta;

		//update positions
		this.rotatorA.position.y = rotatorY;
		this.rotatorB.position.y = rotatorY;
		this.child("010").position.y = cubeY;
		this.child("011").position.y = cubeY;
		this.child("110").position.y = cubeY;
		this.child("111").position.y = cubeY;
		
		if(progress == 1)
			this.completeAnimation(3);
	}
	cube.animate5To4 = function(dt) {
		this.animTime += dt;
		var progress = getProgress(this.animTime);
		var easing = getEasing(progress);
		
		var rotatorY = .5-easing;
		var rotatorTheta = easing*Math.PI/2;

		// set rotation for rotatorA and rotatorB
		this.rotatorA.rotation.z = -rotatorTheta;
		this.rotatorB.rotation.z = rotatorTheta;

		//update positions
		this.rotatorA.position.y = rotatorY;
		this.rotatorB.position.y = rotatorY;

		if(progress == 1)
			this.completeAnimation(4);
	}
	cube.animate0To5 = function(dt) {
		this.animTime += dt;
		var progress = getProgress(this.animTime);
		var easing = getEasing(progress);
		
		var rotatorY = (3*(1-easing)-1)/2;
		var rotatorTheta = easing*Math.PI/2;

		// set rotation for rotatorA and rotatorB
		this.rotatorA.rotation.x = rotatorTheta;
		this.rotatorB.rotation.x = -rotatorTheta;

		//update positions
		this.rotatorA.position.y = rotatorY;
		this.rotatorB.position.y = rotatorY;

		if(progress == 1)
			this.completeAnimation(5);
	}

	cube.completeAnimation = function(newState) {
		//return children from rotators to the cube
		while(this.rotatorA.children.length>0)
			this.attach(this.rotatorA.children[0]);
		while(this.rotatorB.children.length>0)
			this.attach(this.rotatorB.children[0]);
	
		this.state = newState;

		if(this.state == 3) {
			triggerOverlay();
		}

		this.isChanging = false;
		if(typeof this.callback === "function")
			this.callback();
	}
}

var getProgress = (animTime) => Math.min(animTime,DURARTION)/DURARTION;
var getEasing = (progress) => Math.pow(progress,EASING)/(Math.pow(progress,EASING)+Math.pow(1-progress,EASING));

function limitToRange(state) {
	while(state > 5)
		state -= 6;
	while(state < 0)
		state += 6;
	return state;
}

// cube.animateTo0 = function(dt) {
// 	//update positions
// 	this.child("000").position.set(-.5, -.5, -.5);
// 	this.child("000").rotation.set(0, 0, 0);
// 	this.child("001").position.set(-.5, -.5, 0.5);
// 	this.child("001").rotation.set(0, 0, 0);
// 	this.child("010").position.set(-.5, 0.5, -.5);
// 	this.child("010").rotation.set(0, 0, 0);
// 	this.child("011").position.set(-.5, 0.5, 0.5);
// 	this.child("011").rotation.set(0, 0, 0);
// 	this.child("100").position.set(0.5, -.5, -.5);
// 	this.child("100").rotation.set(0, 0, 0);
// 	this.child("101").position.set(0.5, -.5, 0.5);
// 	this.child("101").rotation.set(0, 0, 0);
// 	this.child("110").position.set(0.5, 0.5, -.5);
// 	this.child("110").rotation.set(0, 0, 0);
// 	this.child("111").position.set(0.5, 0.5, 0.5);
// 	this.child("111").rotation.set(0, 0, 0);

// 	//on complete
// 	this.completeAnimation(0);
// }
// cube.animateTo1 = function(dt) {
// 	//update positions
// 	this.child("000").position.set(-.5, 0, -.5);
// 	this.child("000").rotation.set(0, 0, 0);
// 	this.child("100").position.set(0.5, 0, -.5);
// 	this.child("100").rotation.set(0, 0, 0);
// 	this.child("001").position.set(-.5, 0, 0.5);
// 	this.child("001").rotation.set(0, 0, 0);
// 	this.child("101").position.set(0.5, 0, 0.5);
// 	this.child("101").rotation.set(0, 0, 0);
	
// 	this.child("010").position.set(-1.5, 0, -.5);
// 	this.child("010").rotation.set(0, 0, Math.PI);
// 	this.child("011").position.set(-1.5, 0, 0.5);
// 	this.child("011").rotation.set(0, 0, Math.PI);
	
// 	this.child("110").position.set(1.5, 0, -.5)
// 	this.child("110").rotation.set(0, 0, -Math.PI);
// 	this.child("111").position.set(1.5, 0, 0.5)
// 	this.child("111").rotation.set(0, 0, -Math.PI);

// 	//on complete
// 	this.completeAnimation(1);
// }
// cube.animateTo2 = function(dt) {
// 	//update positions		
// 	this.child("000").position.set(-.5, 0, -.5);
// 	this.child("000").rotation.set(-Math.PI/2, 0, 0);
// 	this.child("010").position.set(-1.5, 0, -.5);
// 	this.child("010").rotation.set(-Math.PI/2, 0, Math.PI);
// 	this.child("100").position.set(0.5, 0, -.5);
// 	this.child("100").rotation.set(-Math.PI/2, 0, 0);
// 	this.child("110").position.set(1.5, 0, -.5)
// 	this.child("110").rotation.set(-Math.PI/2, 0, -Math.PI);

// 	this.child("001").position.set(-.5, 0, 0.5);
// 	this.child("001").rotation.set(Math.PI/2, 0, 0);
// 	this.child("011").position.set(-1.5, 0, 0.5);
// 	this.child("011").rotation.set(Math.PI/2, 0, Math.PI);
// 	this.child("101").position.set(0.5, 0, 0.5);
// 	this.child("101").rotation.set(Math.PI/2, 0, 0);
// 	this.child("111").position.set(1.5, 0, 0.5)
// 	this.child("111").rotation.set(Math.PI/2, 0, -Math.PI);

// 	//on complete
// 	this.completeAnimation(2);
// }
// cube.animateTo3 = function(dt) {
// 	//update positions
// 	this.child("000").position.set(-.5, 0.5, -.5);
// 	this.child("000").rotation.set(0, -Math.PI/2, Math.PI/2);
// 	this.child("101").position.set(0.5, 0.5, 0.5);
// 	this.child("101").rotation.set(0, -Math.PI/2, -Math.PI/2);

// 	this.child("001").position.set(-.5, 0.5, 0.5);
// 	this.child("001").rotation.set(0, Math.PI/2, Math.PI/2);
// 	this.child("100").position.set(0.5, 0.5, -.5);
// 	this.child("100").rotation.set(0, Math.PI/2, -Math.PI/2);

// 	this.child("010").position.set(-.5, -.5, -.5);
// 	this.child("010").rotation.set(Math.PI, -Math.PI/2, Math.PI/2);
// 	this.child("011").position.set(-.5, -.5, 0.5);
// 	this.child("011").rotation.set(Math.PI, Math.PI/2, Math.PI/2);
	
// 	this.child("110").position.set(0.5, -.5, -.5)
// 	this.child("110").rotation.set(Math.PI, Math.PI/2, -Math.PI/2);
// 	this.child("111").position.set(0.5, -.5, 0.5)
// 	this.child("111").rotation.set(Math.PI, -Math.PI/2, -Math.PI/2);

// 	//on complete
// 	this.completeAnimation(3);
// }
// cube.animateTo4 = function(dt) {
// 	//update positions
// 	this.child("000").position.set(-.5, 0, -1.5);
// 	this.child("000").rotation.set(Math.PI, -Math.PI/2, Math.PI/2);
// 	this.child("100").position.set(0.5, 0, -1.5);
// 	this.child("100").rotation.set(Math.PI, Math.PI/2, -Math.PI/2);

// 	this.child("001").position.set(-.5, 0, 1.5);
// 	this.child("001").rotation.set(Math.PI, Math.PI/2, Math.PI/2);
// 	this.child("101").position.set(0.5, 0, 1.5);
// 	this.child("101").rotation.set(Math.PI, -Math.PI/2, -Math.PI/2);

// 	this.child("010").position.set(-.5, 0, -.5);
// 	this.child("010").rotation.set(Math.PI, -Math.PI/2, Math.PI/2);
// 	this.child("011").position.set(-.5, 0, 0.5);
// 	this.child("011").rotation.set(Math.PI, Math.PI/2, Math.PI/2);
// 	this.child("110").position.set(0.5, 0, -.5)
// 	this.child("110").rotation.set(Math.PI, Math.PI/2, -Math.PI/2);
// 	this.child("111").position.set(0.5, 0, 0.5)
// 	this.child("111").rotation.set(Math.PI, -Math.PI/2, -Math.PI/2);

// 	//on complete
// 	this.completeAnimation(4);
// }
// cube.animateTo5 = function(dt) {
// 	//update positions
// 	this.child("000").position.set(-.5, 0, -1.5);
// 	this.child("000").rotation.set(Math.PI/2, 0, 0);
// 	this.child("010").position.set(-.5, 0, -.5);
// 	this.child("010").rotation.set(Math.PI/2, 0, 0);
// 	this.child("011").position.set(-.5, 0, 0.5);
// 	this.child("011").rotation.set(-Math.PI/2, 0, 0);
// 	this.child("001").position.set(-.5, 0, 1.5);
// 	this.child("001").rotation.set(-Math.PI/2, 0, 0);

// 	this.child("100").position.set(0.5, 0, -1.5);
// 	this.child("100").rotation.set(Math.PI/2, 0, 0);
// 	this.child("110").position.set(0.5, 0, -.5)
// 	this.child("110").rotation.set(Math.PI/2, 0, 0);
// 	this.child("111").position.set(0.5, 0, 0.5)
// 	this.child("111").rotation.set(-Math.PI/2, 0, 0);
// 	this.child("101").position.set(0.5, 0, 1.5);
// 	this.child("101").rotation.set(-Math.PI/2, 0, 0);

// 	//on complete
// 	this.completeAnimation(5);
// }