package core;

import h3d.scene.Scene;
import h3d.scene.World;

class World extends h3d.scene.World {
	public static var CHUNK_COUNT = 64;
	public static var WORLD_SIZE = 128;

	public function new(s3d:Scene) {
		super(CHUNK_COUNT, WORLD_SIZE, s3d);
	}

	public function populate() {
		done();
	}
}
