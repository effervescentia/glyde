package act;

import core.World;
import data.Abilities;
import h3d.Matrix;
import h3d.prim.ModelCache;

class Powerup extends Actor {
	public static function SpeedUp(cache:ModelCache) {
		return new Powerup(cache, hxd.Res.speed_up, [Speed(0.1)]);
	}

	public static function LiftUp(cache:ModelCache) {
		return new Powerup(cache, hxd.Res.lift_up, [Lift(0.1)]);
	}

	private var mods:Array<Modifier>;

	public var used = false;

	private function new(cache:ModelCache, res:hxd.res.Model, mods:Array<Modifier>) {
		this.mods = mods;

		model = cache.loadModel(res);
		model.setPosition(Math.random() * World.WORLD_SIZE, Math.random() * World.WORLD_SIZE, 0);
		model.setRotation(0, 0, hxd.Math.srand(Math.PI));
	}

	// methods

	public function update(dt:Float) {
		var direc = model.getLocalDirection();
		direc.transform(Matrix.R(0, 0, 1.5 * dt));
		model.setDirection(direc);
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
