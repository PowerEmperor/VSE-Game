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

	public class GameManage extends Sprite
	{
		protected var mMenu:Menu;
		protected var mGame:Game;
		
		protected var mGameRunningCheck:Boolean;
		protected var mMenuRunningCheck:Boolean;
		
		protected var mIsKeyPressed:Boolean;
		
		//public var log:TextField;
		
		public function GameManage()
		{
			mIsKeyPressed = false;
			
			mMenu = new Menu();
			mGame = new Game();
			
			addChild(mMenu);

			addEventListener(Event.ADDED_TO_STAGE, Init);
		}
		
		protected function Init(ev : Event) : void
		{
			stage.addEventListener(KeyboardEvent.KEY_UP, keyEventIngameUp);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyEventIngameDown);
			stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		protected function onEnterFrame(ev : Event) : void
		{
			////////////////////////////////////////////////////////////
			// Go To Game
			if (mMenu.mGlobalMenuSelection == 1)
			{					
				addChild(mGame);
				mGame.GameCreate(ev);
				
				mGameRunningCheck = true;

				removeChild(mMenu);
				
				mMenu.mGlobalMenuSelection = 0;
			}
			
			////////////////////////////////////////////////////////////
			// Go To Game from Pause.
			if (mMenu.mGlobalMenuSelection == 2)
			{					
				//addChild(mGame);
				mGame.GameCreate(ev);
				
				mGameRunningCheck = true;
				
				removeChild(mMenu);
				
				mMenu.mGlobalMenuSelection = 0;
			}
			
			////////////////////////////////////////////////////////////
			// Go To Ingame Menu
			if (mMenu.mGlobalMenuSelection == 3 && mGameRunningCheck == true)
			{
				mMenu.mIngameMenu = true;
				mMenu.MenuState();
				
				addChild(mMenu);
				
				mGameRunningCheck = false;

				//removeChild(mGame);
				
				mGame.GameDestroy(ev);
				
				mMenu.mGlobalMenuSelection = 0;
			}
			
			////////////////////////////////////////////////////////////
			// Go To Main Menu and Reset the game
			if (mMenu.mGlobalMenuSelection == 4 && mGameRunningCheck == true)
			{
				mGame.GameReset(ev);
				mMenu.mGlobalMenuSelection = 0;
			}
			
		}
		
		protected function keyEventIngameUp(event:KeyboardEvent) : void
		{
			mIsKeyPressed = false;
		}
		
		protected function keyEventIngameDown (event:KeyboardEvent) : void
		{
			if(mIsKeyPressed == false)
			{
				if(event.keyCode == Keyboard.ESCAPE && mGameRunningCheck == true)
				{
					trace('ESCAPE');
					mMenu.mGlobalMenuSelection = 3;
					mIsKeyPressed = true;
				}
			}
		}		
	}
}