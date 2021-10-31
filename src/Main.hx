import actors.Character;

var numberOfChunks = 64;
var worldSize = 256;

class Main extends hxd.App {
	var actors:Array<actors.Actor> = new Array();
	var debug:h2d.Text;

	override function init() {
		s3d.lightSystem.ambientLight.set(0.4, 0.4, 0.4);

		var cache = new h3d.prim.ModelCache();

		var character = new actors.Character("main player", cache);

		actors.push(character);

		for (actor in actors) {
			actor.attach(s3d);
		}

		var dirLight = new h3d.scene.fwd.DirLight(new h3d.Vector(-1, 3, -10), s3d);
		dirLight.enableSpecular = true;

		new h3d.scene.CameraController(5, s3d).loadFromCamera();

		character.follow(s3d);

		var font = hxd.res.DefaultFont.get();

		debug = new h2d.Text(font, s2d);
		debug.x = debug.y = 5;

		cache.dispose();
	}

	override function update(dt:Float) {
		for (actor in actors) {
			actor.update(dt);
		}

		debug.text = actors.map((actor) -> actor.toString()).join("\n");
	}

	static function main() {
		hxd.Res.initEmbed();

		new Main();
	}
}
