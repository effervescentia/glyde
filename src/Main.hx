import core.Game;
import core.World;
import h2d.Text;
import h3d.Vector;
import h3d.scene.fwd.DirLight;

class Main extends hxd.App {
	private var game:Game;
	private var world:World;
	private var debug:Text;

	// methods

	override function init() {
		s3d.lightSystem.ambientLight.set(0.4, 0.4, 0.4);

		world = new World(s3d);
		world.populate();

		game = new Game(s3d);

		var dirLight = new DirLight(new Vector(-1, 3, -10), s3d);
		dirLight.enableSpecular = true;

		var font = hxd.res.DefaultFont.get();

		debug = new Text(font, s2d);
		debug.x = debug.y = 5;
	}

	override function update(dt:Float) {
		game.update(dt);

		debug.text = game.toString();
	}

	static function main() {
		hxd.Res.initEmbed();

		new Main();
	}
}
