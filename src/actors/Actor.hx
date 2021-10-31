package actors;

interface Actor {
	public function attach(scene:h3d.scene.Scene):Void;

	public function update(dt:Float):Void;

	public function toString():String;
}
