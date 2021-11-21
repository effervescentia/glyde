package act;

import h3d.scene.Object;
import h3d.Vector;
import h3d.scene.Scene;
import h3d.col.Bounds;

abstract class Actor {
	private var model:Object;

	public abstract function update(dt:Float):Void;

	public abstract function toString():String;

	// getters

	public function getBounds() {
		return model.getBounds();
	}

	public function getDirection() {
		return model.getLocalDirection();
	}

	public function getPosition() {
		return model.getRelPos(model.parent).getPosition();
	}

	// setters

	public function setDirection(direc:Vector) {
		model.setDirection(direc);
	}

	public function setPosition(pos:Vector) {
		model.setPosition(pos.x, pos.y, pos.z);
	}

	// methods

	public function attach(scene:Scene) {
		scene.addChild(model);
	}

	public function collide(bounds:Bounds) {
		return getBounds().collide(bounds);
	}
}
