var numberOfChunks = 64;
var worldSize = 256;

class Main extends hxd.App {
	var model:h3d.scene.Object;
	var debug:h2d.Text;
	var debug2:h2d.Text;

	override function init() {
		s3d.lightSystem.ambientLight.set(0.4, 0.4, 0.4);

		var cache = new h3d.prim.ModelCache();

		model = cache.loadModel(hxd.Res.star);
		s3d.addChild(model);

		var dirLight = new h3d.scene.fwd.DirLight(new h3d.Vector(-1, 3, -10), s3d);
		dirLight.enableSpecular = true;

		new h3d.scene.CameraController(5, s3d).loadFromCamera();

		var font = hxd.res.DefaultFont.get();

		debug = new h2d.Text(font, s2d);
		debug2 = new h2d.Text(font, s2d);
		debug.x = debug.y = debug2.x = 5;
		debug2.y = 35;

		cache.dispose();
	}

	override function update(dt:Float) {
		var direc = model.getLocalDirection();
		var pos = model.getRelPos(model.parent).getPosition();

		if (hxd.Key.isDown(hxd.Key.UP)) {
			var move = direc.clone();
			move.scale(2 * dt);

			var res = pos.add(move);
			model.setPosition(res.x, res.y, res.z);
		}

		if (hxd.Key.isDown(hxd.Key.DOWN)) {
			var move = direc.clone();
			move.scale(-2 * dt);

			var res = pos.add(move);
			model.setPosition(res.x, res.y, res.z);
		}

		if (hxd.Key.isDown(hxd.Key.RIGHT)) {
			direc.transform(h3d.Matrix.R(0, 0, 1.5 * dt));
			model.setDirection(direc);
		}

		if (hxd.Key.isDown(hxd.Key.LEFT)) {
			direc.transform(h3d.Matrix.R(0, 0, -1.5 * dt));
			model.setDirection(direc);
		}

		debug.text = "Position: x=" + model.x + " y=" + model.y + " z=" + model.z;
	}

	static function main() {
		hxd.Res.initEmbed();

		new Main();
	}
}
