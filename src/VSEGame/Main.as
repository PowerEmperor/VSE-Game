package VSEGame
{
	import away3d.cameras.*;
	import away3d.containers.*;
	import away3d.core.utils.Cast;
	import away3d.core.utils.Color;
	import away3d.materials.*;
	import away3d.primitives.*;
	
	import flash.display.*;
	import flash.events.*;
	import flash.external.ExternalInterface;
	import flash.ui.Keyboard;
	import flash.utils.*;
	
	import wumedia.vector.*;
	
	[SWF(width="500", height="400", frameRate="60")]
	
	public class Main extends Sprite
	{
		//protected var mTruckLoader:TruckLoader;		
		//protected var mTruckSteering:TruckSteering;
		
		protected var mStartGame:StartGame;
		
		//protected var mTrailerLoader:TrailerLoader;
		//protected var mTruckSteering:TruckSteering;
		
		protected var mMenuManage:MenuManage;
		
		public function Main()
		{
			
			mStartGame = new StartGame();
			stage.addChild(mStartGame);

			//mTrailerLoader = new TrailerLoader();
			//stage.addChild(mTrailerLoader);
			//mTruckSteering = new TruckSteering();
			//stage.addChild(mTruckSteering);
			
			//mMenuManage = new MenuManage();
			//stage.addChild(mMenuManage);
			
			//var mMainMenu:MainMenu = new MainMenu();
			//stage.addChild(mMainMenu);
			
			
		}
	}
}

