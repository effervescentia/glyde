class World extends h3d.scene.World {
	private static var CHUNK_COUNT = 64;
	private static var WORLD_SIZE = 128;

	private var powerup:h3d.scene.World.WorldModel;
	private var collision:Bool;

	public function new(s3d:h3d.scene.Scene) {
		super(CHUNK_COUNT, WORLD_SIZE, s3d);
	}

	public function populate() {
		powerup = loadModel(hxd.Res.powerup);

		for (i in 0...1000) {
			var x = Math.random() * WORLD_SIZE;
			var y = Math.random() * WORLD_SIZE;

			add(powerup, x, y, 0, 1, hxd.Math.srand(Math.PI));
		}

		done();
	}

	public function collidePowerup(actor:actors.Actor) {
		collision = false;

		for (chunk in chunks) {
			for (elem in chunk.elements) {
				var bounds = elem.model.bounds.clone();

				bounds.transform(elem.transform);

				if (actor.collide(bounds)) {
					collision = true;
				}
			}
		}
	}

	override public function toString() {
		return "World:\n  has collision: " + collision + "\n  child count: " + numChildren;
	}
}
