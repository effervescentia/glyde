package act;

import core.World;
import data.Abilities;
import hxd.Key;
import h3d.Matrix;
import h3d.col.Bounds;
import h3d.prim.ModelCache;
import h3d.scene.Object;
import h3d.scene.Scene;

class Character implements Actor {
	private static var BASE_SPEED = 2;
	private static var BASE_ACCELERATION = 1.5;
	private static var BASE_TURN = 1.5;

	private var model:Object;
	private var pov:Object;
	private var acceleration:Float = 0;
	private var abilities = new data.Abilities();

	public var name:String;

	public function new(name:String, cache:ModelCache) {
		this.name = name;

		model = cache.loadModel(hxd.Res.kirby);
		model.setPosition(0, 0, 0.04);

		pov = new Object(model);
		pov.setPosition(-5, 0, 5);
	}

	// getters

	public function getBounds() {
		return model.getBounds();
	}

	// methods

	public function attach(scene:Scene) {
		scene.addChild(model);
	}

	public function follow(scene:Scene) {
		scene.camera.follow = {target: model, pos: pov};
	}

	public function update(dt:Float) {
		var direc = model.getLocalDirection();
		var pos = model.getRelPos(model.parent).getPosition();
		var moved = false;

		if (Key.isDown(Key.UP)) {
			var move = direc.clone();
			move.scale(BASE_SPEED * dt * abilities.speed);

			var res = pos.add(move);
			model.setPosition(res.x, res.y, res.z);
			moved = true;
		}

		if (Key.isDown(Key.DOWN)) {
			var move = direc.clone();
			move.scale(-BASE_SPEED * dt * abilities.speed);

			var res = pos.add(move);
			model.setPosition(res.x, res.y, res.z);
			moved = true;
		}

		if (Key.isDown(Key.SPACE)) {
			acceleration += dt;
		} else if (acceleration > 0) {
			var move = direc.clone();
			move.scale(BASE_ACCELERATION * acceleration * dt);

			var res = pos.add(move);
			model.setPosition(res.x, res.y, res.z);

			acceleration = Math.max(0, acceleration - dt);
			moved = true;
		}

		model.x = hxd.Math.clamp(model.x, 0, World.WORLD_SIZE);
		model.y = hxd.Math.clamp(model.y, 0, World.WORLD_SIZE);

		if (Key.isDown(Key.RIGHT)) {
			direc.transform(Matrix.R(0, 0, BASE_TURN * dt));
			model.setDirection(direc);
		}

		if (Key.isDown(Key.LEFT)) {
			direc.transform(Matrix.R(0, 0, -BASE_TURN * dt));
			model.setDirection(direc);
		}
	}

	public function collide(bounds:Bounds) {
		return getBounds().collide(bounds);
	}

	public function powerup(mods:Array<Modifier>) {
		abilities.apply(mods);
	}

	public function toString() {
		return name
			+ "\n  position: x="
			+ model.x
			+ " y="
			+ model.y
			+ " z="
			+ model.z
			+ "\n  acceleration: "
			+ acceleration
			+ "\n  "
			+ abilities.toString();
	}
}
