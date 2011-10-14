
package VSEGame
{
	import flash.display.*;
	import flash.events.*;
	import flash.external.ExternalInterface;
	import flash.ui.Keyboard;
	import flash.utils.*;
	
	import wumedia.vector.*;
	
	[SWF(width="640", height="480", frameRate="60")]
	
	public class Main extends Sprite
	{

		protected var mMenuManage:MenuManage;

		public function Main()
		{
			
			mMenuManage = new MenuManage();
			stage.addChild(mMenuManage);

		}
	}
}

