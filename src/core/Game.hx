package core;

import act.Actor;
import act.Character;
import act.Powerup;
import h3d.col.Bounds;
import h3d.scene.Scene;

abstract ActorArray(Array<Actor>) from Array<Actor> to Array<Actor> {
	inline function new(array:Array<Actor>) {
		this = array;
	}

	@:from
	static function fromCharacterArray(array:Array<Character>) {
		return new ActorArray(Lambda.array(Lambda.map(array, function(character:Character):Actor {
			return character;
		})));
	}

	@:from
	static function fromPowerupArray(array:Array<Powerup>) {
		return new ActorArray(Lambda.array(Lambda.map(array, function(character:Powerup):Actor {
			return character;
		})));
	}
}

class Game {
	private var characters:Array<Character> = new Array();
	private var powerups:Array<Powerup> = new Array();

	public function new(scene:Scene) {
		var cache = new h3d.prim.ModelCache();

		var player1 = new Character("main character", cache);

		characters.push(player1);

		for (_ in 0...3000) {
			powerups.push(Std.random(2) == 0 ? Powerup.SpeedUp(cache) : Powerup.LiftUp(cache));
		}

		for (actor in getActors()) {
			actor.attach(scene);
		}

		player1.follow(scene);

		cache.dispose();
	}

	// getters

	private function getActors() {
		var characterActors:ActorArray = characters;
		var powerupActors:ActorArray = powerups;

		var actors = new Array<Actor>();

		actors = actors.concat(characterActors);
		actors = actors.concat(powerupActors);

		return actors;
	}

	// methods

	public function update(dt:Float) {
		for (actor in getActors()) {
			actor.update(dt);
		}

		for (powerup in powerups) {
			for (character in characters) {
				if (!powerup.used && character.collide(powerup.getBounds())) {
					powerup.apply(character);
					powerups.remove(powerup);
					return;
				}
			}
		}
	}

	public function toString() {
		return characters.map((actor) -> actor.toString()).join("\n");
	}
}
