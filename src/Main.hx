import h3d.col.Bounds;

class Main extends hxd.App {
	private var game:Game;
	private var world:World;
	private var worldBounds:Bounds;
	private var debug:h2d.Text;

	// methods

	override function init() {
		s3d.lightSystem.ambientLight.set(0.4, 0.4, 0.4);

		world = new World(s3d);
		world.populate();
		worldBounds = Bounds.fromValues(0, 0, 0, World.WORLD_SIZE, World.WORLD_SIZE, 15);

		game = new Game(s3d);

		var dirLight = new h3d.scene.fwd.DirLight(new h3d.Vector(-1, 3, -10), s3d);
		dirLight.enableSpecular = true;

		var font = hxd.res.DefaultFont.get();

		debug = new h2d.Text(font, s2d);
		debug.x = debug.y = 5;
	}

	override function update(dt:Float) {
		game.update(worldBounds, dt);

		debug.text = game.toString();
	}

	static function main() {
		hxd.Res.initEmbed();

		new Main();
	}
}
