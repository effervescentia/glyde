package actors;

import h3d.col.Bounds;

interface Actor {
	public function attach(scene:h3d.scene.Scene):Void;

	public function update(worldBounds:Bounds, dt:Float):Void;

	public function collide(bounds:Bounds):Bool;

	public function getBounds():Bounds;

	public function toString():String;
}
