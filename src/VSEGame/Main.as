
package VSEGame
{
	import flash.display.*;
	import flash.events.*;
	import flash.external.ExternalInterface;
	import flash.ui.Keyboard;
	import flash.utils.*;
	
	import flashx.textLayout.formats.BackgroundColor;
	
	import wumedia.vector.*;
	
	[SWF(width="640", height="480", frameRate="60", backgroundColor = "0x00CCFF")]
	
	public class Main extends Sprite
	{

		protected var mGameManage:GameManage;

		public function Main()
		{
			stage.quality = StageQuality.LOW;
			
			mGameManage = new GameManage();
			stage.addChild(mGameManage);

		}
	}
}

