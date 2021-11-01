import data.Abilities;
import actors.Actor;
import actors.Character;
import actors.Powerup;
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
	private var collision = false;

	public function new(scene:Scene) {
		var cache = new h3d.prim.ModelCache();

		var player1 = new Character("main character", cache);

		characters.push(player1);

		for (_ in 0...3000) {
			powerups.push(new Powerup(cache, [Speed(0.1)]));
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

	public function update(worldBounds:Bounds, dt:Float) {
		for (actor in getActors()) {
			actor.update(worldBounds, dt);
		}

		collision = false;

		for (powerup in powerups) {
			for (character in characters) {
				if (!powerup.used && character.collide(powerup.getBounds())) {
					collision = true;
					powerup.apply(character);
					powerups.remove(powerup);
					return;
				}
			}
		}
	}

	public function toString() {
		return "collision: " + collision + "\n" + characters.map((actor) -> actor.toString()).join("\n");
	}
}
