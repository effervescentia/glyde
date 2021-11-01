package act;

import core.World;
import data.Abilities;
import h3d.Matrix;
import h3d.col.Bounds;
import h3d.prim.ModelCache;
import h3d.scene.Object;
import h3d.scene.Scene;

class Powerup implements Actor {
	public static function SpeedUp(cache:ModelCache) {
		return new Powerup(cache, hxd.Res.speed_up, [Speed(0.1)]);
	}

	public static function LiftUp(cache:ModelCache) {
		return new Powerup(cache, hxd.Res.lift_up, [Lift(0.1)]);
	}

	private var mods:Array<Modifier>;
	private var model:Object;

	public var used = false;

	private function new(cache:ModelCache, res:hxd.res.Model, mods:Array<Modifier>) {
		this.mods = mods;

		model = cache.loadModel(res);
		model.setPosition(Math.random() * World.WORLD_SIZE, Math.random() * World.WORLD_SIZE, 0);
		model.setRotation(0, 0, hxd.Math.srand(Math.PI));
	}

	// getters

	public function getBounds() {
		return model.getBounds();
	}

	// methods

	public function attach(scene:Scene) {
		scene.addChild(model);
	}

	public function update(dt:Float) {
		var direc = model.getLocalDirection();
		direc.transform(Matrix.R(0, 0, 1.5 * dt));
		model.setDirection(direc);
	}

	public function collide(bounds:Bounds) {
		return getBounds().collide(bounds);
	}

	public function apply(character:Character) {
		if (used)
			return;

		used = true;
		character.powerup(mods);
		model.remove();
	}

	public function toString():String {
		throw "x: " + model.x + " y: " + model.y;
	}
}
