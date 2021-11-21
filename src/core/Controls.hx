package core;

import data.Abilities;
import h3d.Matrix;
import act.Actor;
import hxd.Key;

class Controls {
	private static var BASE_SPEED = 2;
	private static var BASE_ACCELERATION = 1.5;
	private static var BASE_TURN = 1.5;

	public var acceleration:Float = 0;

	private var actor:Actor;
	private var abilities:Abilities;

	public function new(actor:Actor, abilities:Abilities) {
		this.actor = actor;
		this.abilities = abilities;
	}

	private function getDirectionalVector(scale:Float) {
		var vec = actor.getDirection().clone();
		vec.scale(scale);

		return vec;
	}

	private function drive(dt:Float, pos:h3d.Vector) {
		var move = getDirectionalVector(BASE_SPEED * dt * abilities.speed);

		actor.setPosition(pos.add(move));
	}

	private function turn(dt:Float) {
		var direc = actor.getDirection();
		direc.transform(Matrix.R(0, 0, BASE_TURN * dt));
		actor.setDirection(direc);
	}

	private function accelerate(dt:Float) {
		acceleration += dt;
	}

	private function decelerate(dt:Float, pos:h3d.Vector) {
		var move = getDirectionalVector(BASE_ACCELERATION * acceleration * dt);

		actor.setPosition(pos.add(move));

		acceleration = Math.max(0, acceleration - dt);
	}

	public function update(dt:Float) {
		var pos = actor.getPosition();

		/* vvv just for testing purposes vvv */
		var isUp = Key.isDown(Key.UP);
		var isDown = Key.isDown(Key.DOWN);

		if (isUp && !isDown) {
			drive(dt, pos);
		}

		if (isDown && !isUp) {
			drive(-dt, pos);
		}
		/* ^^^ just for testing purposes ^^^ */

		if (Key.isDown(Key.SPACE)) {
			accelerate(dt);
		} else if (acceleration > 0) {
			decelerate(dt, pos);
		}

		var isRight = Key.isDown(Key.RIGHT);
		var isLeft = Key.isDown(Key.LEFT);

		if (isRight && !isLeft) {
			turn(dt);
		}

		if (isLeft && !isRight) {
			turn(-dt);
		}
	}
}
