package act;

import h3d.scene.Scene;
import h3d.col.Bounds;

interface Actor {
	public function attach(scene:Scene):Void;

	public function update(dt:Float):Void;

	public function collide(bounds:Bounds):Bool;

	public function getBounds():Bounds;

	public function toString():String;
}
