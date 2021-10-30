import hxsl.Types.Matrix;

var numberOfChunks = 64;
var worldSize = 256;

class Main extends hxd.App {
	var model:h3d.scene.Object;

	override function init() {
		s3d.lightSystem.ambientLight.set(0.4, 0.4, 0.4);

		var cache = new h3d.prim.ModelCache();

		model = cache.loadModel(hxd.Res.star);
		s3d.addChild(model);

		var dirLight = new h3d.scene.fwd.DirLight(new h3d.Vector(-1, 3, -10), s3d);
		dirLight.enableSpecular = true;

		new h3d.scene.CameraController(5, s3d).loadFromCamera();

		cache.dispose();
	}

	override function update(dt:Float) {
		var direc = model.getLocalDirection();
		var pos = model.getRelPos(s3d).getPosition();

		if (hxd.Key.isDown(hxd.Key.UP)) {
			var move = direc.clone();
			move.w = 5 * dt;

			pos.add(move);

			model.setPosition(move.x, pos.y, pos.z);
		}

		if (hxd.Key.isDown(hxd.Key.DOWN))
			model.y -= 5 * dt;

		if (hxd.Key.isDown(hxd.Key.RIGHT)) {
			direc.transform(Matrix.R(0, 0, 1.5 * dt));
			model.setDirection(direc);
		}

		if (hxd.Key.isDown(hxd.Key.LEFT)) {
			direc.transform(Matrix.R(0, 0, -1.5 * dt));
			model.setDirection(direc);
		}
	}

	static function main() {
		hxd.Res.initEmbed();

		new Main();
	}
}
