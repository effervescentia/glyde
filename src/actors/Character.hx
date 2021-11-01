package actors;

import h3d.scene.Object;
import h3d.scene.Scene;
import h3d.Matrix;
import hxd.Key;

class Character implements Actor {
	private var model:Object;
	private var pov:Object;
	private var acceleration:Float = 0;

	public var name:String;

	public function new(name:String, cache:h3d.prim.ModelCache) {
		this.name = name;

		model = cache.loadModel(hxd.Res.kirby);
		pov = new Object(model);

		model.setPosition(0, 0, 0.04);
		pov.setPosition(-5, 0, 5);
	}

	public function attach(scene:Scene) {
		scene.addChild(model);
	}

	public function follow(scene:Scene) {
		scene.camera.follow = {target: model, pos: pov};
	}

	public function update(dt:Float) {
		var direc = model.getLocalDirection();
		var pos = model.getRelPos(model.parent).getPosition();

		if (Key.isDown(Key.UP)) {
			var move = direc.clone();
			move.scale(2 * dt);

			var res = pos.add(move);
			model.setPosition(res.x, res.y, res.z);
		}

		if (Key.isDown(Key.DOWN)) {
			var move = direc.clone();
			move.scale(-2 * dt);

			var res = pos.add(move);
			model.setPosition(res.x, res.y, res.z);
		}

		if (Key.isDown(Key.SPACE)) {
			acceleration += dt;
		} else if (acceleration > 0) {
			var move = direc.clone();
			move.scale(acceleration * dt);

			var res = pos.add(move);
			model.setPosition(res.x, res.y, res.z);

			acceleration = Math.max(0, acceleration - dt);
		}

		if (Key.isDown(Key.RIGHT)) {
			direc.transform(Matrix.R(0, 0, 1.5 * dt));
			model.setDirection(direc);
		}

		if (Key.isDown(Key.LEFT)) {
			direc.transform(Matrix.R(0, 0, -1.5 * dt));
			model.setDirection(direc);
		}
	}

	public function collide(bounds:h3d.col.Bounds) {
		return model.getBounds().collide(bounds);
	}

	public function toString() {
		return name + "\n  Position: x=" + model.x + " y=" + model.y + " z=" + model.z + "\n  Acceleration: " + acceleration;
	}
}
