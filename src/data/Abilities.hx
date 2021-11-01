package data;

enum Modifier {
	Health(delta:Float);
	Speed(delta:Float);
	Boost(delta:Float);
	Charge(delta:Float);
	Turn(delta:Float);
	Offense(delta:Float);
	Defense(delta:Float);
	Weight(delta:Float);
	Lift(delta:Float);
}

class Abilities {
	private static var MIN_HEALTH = 5;
	private static var MIN_SPEED = 0.5;
	private static var MIN_BOOST = 0.5;
	private static var MIN_CHARGE = 0.5;
	private static var MIN_TURN = 0.5;
	private static var MIN_OFFENSE = 0.5;
	private static var MIN_DEFENSE = 0.5;
	private static var MIN_WEIGHT = 0.5;
	private static var MIN_LIFT = 0.5;

	public var health(default, null):Float = MIN_HEALTH;
	public var speed(default, null):Float = 1;
	public var boost(default, null):Float = 1;
	public var charge(default, null):Float = 1;
	public var turn(default, null):Float = 1;
	public var offense(default, null):Float = 1;
	public var defense(default, null):Float = 1;
	public var weight(default, null):Float = 1;
	public var lift(default, null):Float = 1;

	public function new() {}

	// methods

	public function apply(mods:Array<Modifier>) {
		for (mod in mods) {
			switch (mod) {
				case Health(delta):
					{
						health = Math.max(MIN_HEALTH, health + delta);
					}
				case Speed(delta):
					{
						speed = Math.max(MIN_SPEED, speed + delta);
					}
				case Boost(delta):
					{
						boost = Math.max(MIN_BOOST, boost + delta);
					}
				case Charge(delta):
					{
						charge = Math.max(MIN_CHARGE, charge + delta);
					}
				case Turn(delta):
					{
						turn = Math.max(MIN_TURN, turn + delta);
					}
				case Offense(delta):
					{
						offense = Math.max(MIN_OFFENSE, offense + delta);
					}
				case Defense(delta):
					{
						defense = Math.max(MIN_DEFENSE, defense + delta);
					}
				case Weight(delta):
					{
						weight = Math.max(MIN_WEIGHT, weight + delta);
					}
				case Lift(delta):
					{
						lift = Math.max(MIN_LIFT, lift + delta);
					}
			}
		}
	}

	public function toString() {
		return "health: " + health + ",top speed: " + speed + ", boost: " + boost + ", charge: " + charge + ", turn: " + turn + ", offense: " + offense
			+ ", defense: " + defense + ", weight: " + weight + ", lift: " + lift;
	}
}
