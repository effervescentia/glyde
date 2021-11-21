package act;

import core.Controls;
import data.Abilities;
import h3d.prim.ModelCache;
import h3d.scene.Object;
import h3d.scene.Scene;

class Character extends Actor {
	private static var BASE_SPEED = 2;
	private static var BASE_ACCELERATION = 1.5;
	private static var BASE_TURN = 1.5;

	private var pov:Object;
	private var focus:Object;
	private var controls:Controls;

	public var name:String;
	public var abilities = new data.Abilities();

	public function new(name:String, cache:ModelCache) {
		this.name = name;

		controls = new Controls(this, abilities);

		this.model = cache.loadModel(hxd.Res.kirby);
		this.model.setPosition(0, 0, 0.04);

		focus = new Object(model);
		focus.setPosition(1, 0, 0);

		pov = new Object(model);
		pov.setPosition(-3, 0, 1.5);
	}

	// methods

	public function follow(scene:Scene) {
		scene.camera.follow = {target: focus, pos: pov};
	}

	public function update(dt:Float) {
		controls.update(dt);
	}

	public function powerup(mods:Array<Modifier>) {
		abilities.apply(mods);
	}

	public function toString() {
		return name + "\n  position: x=" + model.x + " y=" + model.y + " z=" + model.z + "\n  acceleration: " + controls.acceleration + "\n  "
			+ abilities.toString();
	}
}
