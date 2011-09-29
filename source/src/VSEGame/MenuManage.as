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
	import flash.text.TextField;
	import flash.ui.Keyboard;
	import flash.utils.*;
	
	import wumedia.vector.*;

	public class MenuManage extends Sprite
	{
		protected var mMainMenu:MainMenu;
		protected var mHowToMenu:HowToMenu;
		
		//View objects
		protected var mCamera:Camera3D;
		protected var mView:View3D;
		protected var mTimer:Timer;
		protected var mIsKeyPressed:Boolean;
		
		public var mSelectedMenu:Number;
		
		public var log:TextField;
		
		public function MenuManage()
		{			
			mTimer = new Timer(1);
			//mTimer.addEventListener(TimerEvent.TIMER,TimerFunc);
			mTimer.start();
			mIsKeyPressed = false;
			
			addEventListener(Event.ADDED_TO_STAGE, Init);
		}
		
		protected function Init(ev : Event) : void
		{
			removeEventListener(Event.ADDED_TO_STAGE, Init);
			
			log = new TextField();
			log.width = 500;
			log.height = 200;
			log.x=0;
			log.y=0;
			stage.addChild(log);
			log.text = "log file added to stage";
			
			//addEventListener(KeyboardEvent.KEY_UP, keyEventUp);
			//addEventListener(KeyboardEvent.KEY_DOWN, knopje);
			selectedMenu = 0; // START MAIN MENU
			trace(mSelectedMenu);
		}
		
		/*protected function keyEventUp(event:KeyboardEvent):void
		{
			log.text = "Key up event";
			mIsKeyPressed = false;
		}
		
		protected function knopje(ev:KeyboardEvent):void
		{
			log.text ="Key down event";
			if(mIsKeyPressed == false)
			{
				if(stage.contains(mMainMenu) && ev.keyCode == Keyboard.ENTER)
				{
					mIsKeyPressed = true;
					switch(mMainMenu.mMenuSelection)
					{
						case 0:
							break;
						case 1:
							if(stage.contains(mMainMenu))
							{
								stage.removeChild(mMainMenu);
							}
							stage.addChild(mHowToMenu);
							break;
						case 2:
							break;
						case 3:
							break;
					}
				}
			
				if(stage.contains(mHowToMenu) && ev.keyCode == Keyboard.ENTER)
				{
					mIsKeyPressed = true;
					switch(mHowToMenu.mMenuSelection)
					{
						case 0:
							if(stage.contains(mHowToMenu))
							{
								stage.removeChild(mHowToMenu);
							}							
							stage.addChild(mMainMenu);
							break;
					}
				}
			}
		}*/
		
		/*
		protected function TimerFunc(ev : TimerEvent) : void
		{
			//mView.render();
			if(mMainMenu.mMenuFlag == true && stage.contains(mMainMenu))
			{				
				switch(mMainMenu.mMenuSelection)
				{
					case 0:
						break;
					case 1:
						if(stage.contains(mMainMenu))
						{
							mMainMenu.removeEventListener(KeyboardEvent.KEY_DOWN,mMainMenu.keyEventDown);
							stage.removeChild(mMainMenu);
							
						}
						stage.addChild(mHowToMenu);
						mHowToMenu.addEventListener(KeyboardEvent.KEY_DOWN,mHowToMenu.keyEventDown);
						break;
					case 2:
						break;
					case 3:
						break;
				}
			}
			else if(mHowToMenu.mMenuFlag == true && stage.contains(mHowToMenu))
			{
				switch(mHowToMenu.mMenuSelection)
				{
					case 0:
						if(stage.contains(mHowToMenu))
						{
							stage.removeChild(mHowToMenu);
							mHowToMenu.removeEventListener(KeyboardEvent.KEY_DOWN,mHowToMenu.keyEventDown);
						}							
						stage.addChild(mMainMenu);
						mMainMenu.addEventListener(KeyboardEvent.KEY_DOWN,mMainMenu.keyEventDown);
						break;
				}
			}
		}
		*/
		
		public function set selectedMenu(val:Number):void
		{
			trace("setter")
			mSelectedMenu = val;
			
			switch(mSelectedMenu)
			{
				case 0: // MAIN MENU
					mMainMenu = new MainMenu(mSelectedMenu);
					addChild(mMainMenu);
					trace('JIPPIE!');
					break;
				case 1:
					mHowToMenu = new HowToMenu();
					addChild(mHowToMenu);
					break;
			}
		}
		
		public function get selectedMenu():Number
		{
			return mSelectedMenu;
		}
		
	}
}