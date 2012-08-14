package
{
	import org.flixel.*;
	import general.*;

	[SWF(width="1920", height="1080", backgroundColor="#ffffff")]
	[Frame(factoryClass="Preloader")]
	public class Main extends FlxGame
	{
		/**
		 * Constructor
		 */
		public function Main() {
			super(1920, 1080, PlayState, 1);
		}
	}
}
