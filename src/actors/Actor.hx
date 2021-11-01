package actors;

interface Actor {
	public function attach(scene:h3d.scene.Scene):Void;

	public function update(dt:Float):Void;

	public function collide(bounds:h3d.col.Bounds):Bool;

	public function toString():String;
}
