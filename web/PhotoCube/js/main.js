var clock, scene, camera, controls, renderer, cube;
var listener;
var st = 0;
var raycaster, mouseVector;
var overlayTriggered = false;

function main() {
	//initilise the game
	init();
	
	//begin animation loop 
	animate();
}

function init() {
	//get viewport
	var viewport = document.getElementById('viewport');
	
	//create clock
	clock = new THREE.Clock();
	
	//create scene
	scene = new THREE.Scene();
	
	//add camera
	camera = new THREE.PerspectiveCamera(75, viewport.clientWidth/viewport.clientHeight, 0.1, 1000);
	camera.position.z = 3;
	
	//attach renderer to page
	renderer = new THREE.WebGLRenderer({ antialias: true });
	renderer.setPixelRatio( window.devicePixelRatio );
	renderer.setSize(viewport.clientWidth, viewport.clientHeight);
	viewport.appendChild(renderer.domElement);
	
	//lighting
	var lightA = new THREE.AmbientLight( 0x404040 ); // soft white light
	scene.add( lightA );
	var lightH = new THREE.HemisphereLight(0xffffff, 0xf0f0f0, 1);
	scene.add(lightH);	
	var lightD = new THREE.DirectionalLight(0xffffff, .6);
	scene.add(lightD);
	lightD.position.set(10, 0, 10);
	
	//cube
	createPhotoCube(cubeBuilt);
}

function cubeBuilt(newCube) {
	cube = newCube;

	cube.rotation.set(Math.PI/6,Math.PI/4,0);

	scene.add(cube);

	controls = new THREE.OrbitControls(camera, renderer.domElement);
	controls.screenSpacePanning = false;
	controls.enableZoom = false;
	controls.keys = {};
	controls.mouseButtons = {
		LEFT: THREE.MOUSE.ROTATE,
		MIDDLE: THREE.MOUSE.ROTATE,
		RIGHT: THREE.MOUSE.ROTATE
	}

	//init click detection on the cube mesh for interaction
	raycaster = new THREE.Raycaster();
	mouseVector = new THREE.Vector2();

	// TODO - do we need to allow for touch input on mobile

	//add input controller to allow for key input
	listener = new window.keypress.Listener();
	listener.simple_combo("left", ()=>{ cube.prevState() });
	listener.simple_combo("right", ()=>{ cube.nextState() });
	listener.simple_combo("up", ()=>{ cube.nextState() });
	listener.simple_combo("down", ()=>{ cube.prevState() });
}

function animate() {
	requestAnimationFrame(animate);
	
	var dt = clock.getDelta();
	st += dt;

	//animate elements
	cube.update(dt);

	//render scene
	controls.update();
	renderer.render(scene, camera);
}

function onWindowResize() {
	camera.aspect = window.innerWidth / window.innerHeight;
	camera.updateProjectionMatrix();

	renderer.setSize(window.innerWidth, window.innerHeight );
}

function onMouseClick(e) {
	if(clickingTarget(e))
		cube.nextState();
}
function onRightClick(e) {
	if(clickingTarget(e))
		cube.prevState();
}
function clickingTarget(e) {
	mouseVector.x = 2*(e.clientX/window.innerWidth)-1;
	mouseVector.y = 1-2*(e.clientY/window.innerHeight);
	raycaster.setFromCamera(mouseVector, camera);

	var collisions = raycaster.intersectObjects(cube.children);
	if(collisions.length == 0)
		return false;
	
	return collisions[0].object.name != "";
}

function onTouchEnd(e) {
	onMouseClick(e.changedTouches[0]);
}

function triggerOverlay() {
	if(overlayTriggered)
		return;

	overlayTriggered = true;

	var ele = document.getElementById("overlay");
	ele.classList.add("fade-in");
}

//add onload listener
if (window.addEventListener) {
	window.addEventListener('load', main);
	window.addEventListener('resize', onWindowResize, false);
	window.addEventListener('click', onMouseClick, false );
	window.addEventListener('contextmenu', onRightClick, false );
	window.addEventListener('touchend', onTouchEnd, false );
} else {
	window.attachEvent('onload', main);
	window.attachEvent('onresize', onWindowResize);
	window.attachEvent('onclick', onMouseClick);
}