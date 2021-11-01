import actors.Actor;
import actors.Character;
import actors.Powerup;

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

class Main extends hxd.App {
	private var world:World;
	private var debug:h2d.Text;

	private var characters:Array<Character> = new Array();
	private var powerups:Array<Powerup> = new Array();

	private function getActors() {
		var characterActors:ActorArray = characters;
		var powerupActors:ActorArray = powerups;

		var actors = new Array<Actor>();

		actors = actors.concat(characterActors);
		actors = actors.concat(powerupActors);

		return actors;
	}

	override function init() {
		world = new World(s3d);
		world.populate();

		s3d.lightSystem.ambientLight.set(0.4, 0.4, 0.4);

		var cache = new h3d.prim.ModelCache();

		var player1 = new Character("main character", cache);

		characters.push(player1);

		for (_ in 1...1000) {
			powerups.push(new Powerup(cache));
		}

		for (actor in getActors()) {
			actor.attach(s3d);
		}

		var dirLight = new h3d.scene.fwd.DirLight(new h3d.Vector(-1, 3, -10), s3d);
		dirLight.enableSpecular = true;

		player1.follow(s3d);

		var font = hxd.res.DefaultFont.get();

		debug = new h2d.Text(font, s2d);
		debug.x = debug.y = 5;

		cache.dispose();
	}

	override function update(dt:Float) {
		for (actor in getActors()) {
			actor.update(dt);
		}

		var collision = false;

		for (powerup in powerups) {
			for (character in characters) {
				if (character.collide(powerup.getBounds())) {
					collision = true;
				}
			}
		}

		debug.text = "collision: " + collision + "\n" + characters.map((actor) -> actor.toString()).join("\n");
	}

	static function main() {
		hxd.Res.initEmbed();

		new Main();
	}
}
