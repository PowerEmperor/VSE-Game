//////////////////////////////////////////////////
// TO FIX!
//////////////////////////////////////////////////

//////////////////////////////////////////////////
/////////////!DONE!/////////////////
// Maak Extra menu keuze aan bij het menu laten zien. Want het mag niet meer met RunGame = true of false.
// Hierdoor kan ik er geen goede keuze gemaakt worden.
/////////////!DONE!/////////////////

//////////////////////////////////////////////////
// Maak een Ingame Menu Texture.
// En zorg dat deze goed overloopt.
//////////////////////////////////////////////////

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
	
	public class Menu extends Sprite
	{		
		public var mMenuLoader:MenuLoader = new MenuLoader();
		
		public var mKeyPressed:Boolean;
		
		//protected var GameRunning:Boolean;
		
		public var mMenuSelection:int
		public var mHowToMenuSelection:int;
		public var mHighscoreMenuSelection:int;
		public var mOptionsMenuSelection:int;
		
		//////////////////////////////////////////////////
		//The Vars for the check in what menu part there in. This is for the Controls
		//////////////////////////////////////////////////
		
		public var mMainMenu:Boolean;
		public var mHowToMenu:Boolean;
		public var mHighscoreMenu:Boolean;
		public var mOptionsMenu:Boolean;
		
		//////////////////////////////////////////////////
		// Ingame Vars
		
		public var mIngameMenu:Boolean;
		public var mHowToIngameMenu:Boolean;
		public var mHighscoreIngameMenu:Boolean;
		public var mOptionsIngameMenu:Boolean;
		
		//////////////////////////////////////////////////
		// The Vars for the Language settings.
		//////////////////////////////////////////////////
		
		public var mIsEnglish:Boolean;
		public var mIsDutch:Boolean;
		
		public var mRunGame:Boolean;
		
		public var mGlobalMenuSelection:int;
		
		//public var mGame:Game;
		
		//View objects
		protected var mCamera:Camera3D;
		protected var mView:View3D;
		
		public function Menu()
		{
			Init();

			CreateScene();
			
			addEventListener(Event.ADDED_TO_STAGE, MenuCreate);
			addEventListener(Event.REMOVED_FROM_STAGE, MenuDestroy);
		}
		
		public function Init() : void
		{
			mKeyPressed = false;
			mRunGame = false;
			
			mMainMenu = true;
			mHowToMenu = false;
			mHighscoreMenu = false;
			mOptionsMenu = false;
			
			mIngameMenu = false;
			mHowToIngameMenu = false;
			mHighscoreIngameMenu = false;
			mOptionsIngameMenu = false;
			
			mGlobalMenuSelection = 0;
			
			mCamera = new Camera3D();
			mCamera.fov = 90; // in degrees
			mCamera.zoom = 1;
			
			mView = new View3D();
			mView.x = 320;
			mView.y = 240;
			mView.camera = mCamera;
			addChild(mView);
		}
		
		protected function CreateScene():void
		{					
			mView.scene.addChild(mMenuLoader.mEN_MainMenuPlane);
			mView.scene.addChild(mMenuLoader.mEN_HowToMenuPlane);
			mView.scene.addChild(mMenuLoader.mEN_HighscoreMenuPlane);
			mView.scene.addChild(mMenuLoader.mEN_OptionsMenuPlane);
			
			mView.scene.addChild(mMenuLoader.mNL_MainMenuPlane);
			mView.scene.addChild(mMenuLoader.mNL_HowToMenuPlane);
			mView.scene.addChild(mMenuLoader.mNL_HighscoreMenuPlane);
			mView.scene.addChild(mMenuLoader.mNL_OptionsMenuPlane);
			
			mView.scene.addChild(mMenuLoader.mEN_IngameMenuPlane);
			mView.scene.addChild(mMenuLoader.mEN_HowToIngameMenuPlane);
			mView.scene.addChild(mMenuLoader.mEN_HighscoreIngameMenuPlane);
			mView.scene.addChild(mMenuLoader.mEN_OptionsIngameMenuPlane);
			
			mView.scene.addChild(mMenuLoader.mNL_IngameMenuPlane);
			mView.scene.addChild(mMenuLoader.mNL_HowToIngameMenuPlane);
			mView.scene.addChild(mMenuLoader.mNL_HighscoreIngameMenuPlane);
			mView.scene.addChild(mMenuLoader.mNL_OptionsIngameMenuPlane);
			
			mView.scene.addChild(mMenuLoader.mArrow);
			
			mIsEnglish = true;
			mIsDutch = false;
			
			MenuState();
		}
		
		public function keyEventUp(event:KeyboardEvent):void
		{
			mKeyPressed = false;
		}
		
		public function keyEventDown(event:KeyboardEvent):void
		{
			////////////////////////////////////////////////////////////
			// These are the Controls for the Main Menu
			////////////////////////////////////////////////////////////
			
			if (mMainMenu == true && mKeyPressed == false && mRunGame == false)
			{
				switch(event.keyCode)
				{						
					case Keyboard.DOWN:
						trace("PRESSING DOWN");
						if(mMenuSelection != 3)
						{
							mMenuSelection++;
						}
						else
						{
							mMenuSelection = 0;
						}
						mKeyPressed = true;
						break;
					
					case Keyboard.UP:
						trace("PRESSING UP");
						if(mMenuSelection != 0)
						{
							mMenuSelection--;
						}
						else
						{
							mMenuSelection = 3;
						}
						mKeyPressed = true;
						break;
					
					case Keyboard.ENTER:
						trace("PRESSING ENTER");
						
						if (mMenuSelection == 0)
						{					
							mMainMenu = false;
							
							mMenuSelection = 10;
							
							mRunGame = true;
							
							mGlobalMenuSelection = 1;
							
							trace(mGlobalMenuSelection);
							
							mKeyPressed = true;
						}
						
						if (mMenuSelection == 1)
						{															
							mHowToMenu = true;
							mMainMenu = false;
							
							mMenuSelection = 4;
							
							mKeyPressed = true;
							
							MenuState();
						}
						
						if (mMenuSelection == 2)
						{															
							mHighscoreMenu = true;
							mMainMenu = false;
							
							mMenuSelection = 5;
							
							mKeyPressed = true;
							
							MenuState();
						}
						
						if (mMenuSelection == 3)
						{
							mOptionsMenu = true;
							mMainMenu = false;
							
							mMenuSelection = 6;
							
							mKeyPressed = true;
							
							MenuState();
						}
						break;
				}
			} // End Main Menu Control Code.
			
			////////////////////////////////////////////////////////////
			// These are the Controls for the How To Play Menu
			
			if (mHowToMenu == true && mKeyPressed == false)
			{						
				if(event.keyCode == Keyboard.ENTER)
				{
					if (mMenuSelection == 4)
					{						
						mHowToMenu = false;
						mMainMenu = true;
						
						mMenuSelection = 1;
						
						mKeyPressed = true;
						
						MenuState();
					}
				}
			} // End How To Play Control Code.
			
			////////////////////////////////////////////////////////////
			// These are the Controls for the Highscore Menu
			
			if (mHighscoreMenu == true && mKeyPressed == false)
			{
				if(event.keyCode == Keyboard.ENTER)
				{
					if (mMenuSelection == 5)
					{						
						mHighscoreMenu = false;
						mMainMenu = true;
						
						mMenuSelection = 2;
						
						mKeyPressed = true;
						
						MenuState();
					}
				}
			}// End Highscore Control Code.
			
			////////////////////////////////////////////////////////////
			// These are the Controls for the Options Menu
			
			if (mOptionsMenu == true && mKeyPressed == false)
			{
				switch(event.keyCode)
				{						
					case Keyboard.DOWN:
						trace("PRESSING DOWN");
						if(mMenuSelection != 8)
						{
							mMenuSelection++;
						}
						else
						{
							mMenuSelection = 6;
						}
						mKeyPressed = true;
						break;
					
					case Keyboard.UP:
						trace("PRESSING UP");
						if(mMenuSelection != 6)
						{
							mMenuSelection--;
						}
						else
						{
							mMenuSelection = 8;
						}
						mKeyPressed = true;
						break;
					
					case Keyboard.ENTER:
						trace("PRESSING ENTER");
						
						if (mMenuSelection == 6)
						{
							mIsEnglish = true;
							mIsDutch = false;
							mKeyPressed = true;
							
							MenuState();
						}
						
						if (mMenuSelection == 7)
						{
							mIsDutch = true;
							mIsEnglish = false;
							mKeyPressed = true;
							
							MenuState();
						}
						
						if (mMenuSelection == 8)
						{							
							mOptionsMenu = false;
							mMainMenu = true;
							
							mMenuSelection = 3;
							
							mKeyPressed = true;
							
							MenuState();
						}
				}
			}// End Options Control Code.
			
			//////////////////////////////////////////////////
			// These are the Controls for the Ingame Menu
			//////////////////////////////////////////////////
			
			if (mIngameMenu == true && mKeyPressed == false && mRunGame == true)
			{
				switch(event.keyCode)
				{						
					case Keyboard.DOWN:
						trace("PRESSING DOWN");
						if(mMenuSelection != 14)
						{
							mMenuSelection++;
						}
						else
						{
							mMenuSelection = 10;
						}
						mKeyPressed = true;
						break;
					
					case Keyboard.UP:
						trace("PRESSING UP");
						if(mMenuSelection != 10)
						{
							mMenuSelection--;
						}
						else
						{
							mMenuSelection = 14;
						}
						mKeyPressed = true;
						break;
					
					case Keyboard.ENTER:
						trace("PRESSING ENTER");
						
						if (mMenuSelection == 10)
						{
							mIngameMenu = false;
							
							mGlobalMenuSelection = 2;
							
							trace(mGlobalMenuSelection);
							
							mMenuSelection = 10;
							
							mKeyPressed = true;
						}
						
						if (mMenuSelection == 11)
						{															
							mHowToIngameMenu = true;
							mIngameMenu = false;
							
							mMenuSelection = 4;
							
							mKeyPressed = true;
							
							MenuState();
						}
						
						if (mMenuSelection == 12)
						{															
							mHighscoreIngameMenu = true;
							mIngameMenu = false;
							
							mMenuSelection = 5;
							
							mKeyPressed = true;
							
							MenuState();
						}
						
						if (mMenuSelection == 13)
						{
							mOptionsIngameMenu = true;
							mIngameMenu = false;
							
							mMenuSelection = 6;
							
							mKeyPressed = true;
							
							MenuState();
						}
						
						////////////////////////////////////////////////////////////
						// End Game Goto Main Menu
						if (mMenuSelection == 14)
						{
							//mGlobalMenuSelection = 4;
							
							mRunGame = false;
							mMainMenu = true;
							mIngameMenu = false;
							
							mMenuSelection = 0;
							
							
							
							mKeyPressed = true;
							
							
							MenuState();
						}
						break;
				}
			} // End Main Menu Control Code.
			
			////////////////////////////////////////////////////////////
			// These are the Controls for the How To Play Menu
			
			if (mHowToIngameMenu == true && mKeyPressed == false)
			{						
				if(event.keyCode == Keyboard.ENTER)
				{
					if (mMenuSelection == 4)
					{						
						mHowToMenu = false;
						mMainMenu = true;
						
						mMenuSelection = 1;
						
						mKeyPressed = true;
						
						MenuState();
					}
				}
			} // End How To Play Control Code.
			
			////////////////////////////////////////////////////////////
			// These are the Controls for the Highscore Menu
			
			if (mHighscoreIngameMenu == true && mKeyPressed == false)
			{
				if(event.keyCode == Keyboard.ENTER)
				{
					if (mMenuSelection == 5)
					{						
						mHighscoreMenu = false;
						mMainMenu = true;
						
						mMenuSelection = 2;
						
						mKeyPressed = true;
						
						MenuState();
					}
				}
			}// End Highscore Control Code.
			
			////////////////////////////////////////////////////////////
			// These are the Controls for the Options Menu
			
			if (mOptionsIngameMenu == true && mKeyPressed == false)
			{
				switch(event.keyCode)
				{						
					case Keyboard.DOWN:
						trace("PRESSING DOWN");
						if(mMenuSelection != 8)
						{
							mMenuSelection++;
						}
						else
						{
							mMenuSelection = 6;
						}
						mKeyPressed = true;
						break;
					
					case Keyboard.UP:
						trace("PRESSING UP");
						if(mMenuSelection != 6)
						{
							mMenuSelection--;
						}
						else
						{
							mMenuSelection = 8;
						}
						mKeyPressed = true;
						break;
					
					case Keyboard.ENTER:
						trace("PRESSING ENTER");
						
						if (mMenuSelection == 6)
						{
							mIsEnglish = true;
							mIsDutch = false;
							mKeyPressed = true;
							
							MenuState();
						}
						
						if (mMenuSelection == 7)
						{
							mIsDutch = true;
							mIsEnglish = false;
							mKeyPressed = true;
							
							MenuState();
						}
						
						if (mMenuSelection == 8)
						{							
							mOptionsMenu = false;
							mMainMenu = true;
							
							mMenuSelection = 3;
							
							mKeyPressed = true;
							
							MenuState();
						}
				}
			}// End Options Control Code.
			
		} // keyEventDown'
		
		
		public function MenuState() : void
		{	
			////////////////////////////////////////////////////////////
			// The English Language Setting
			////////////////////////////////////////////////////////////
			
			if (mMainMenu == true && mIsEnglish == true)
			{
				mMenuLoader.mEN_MainMenuPlane.visible = true;
			}
			else
			{
				mMenuLoader.mEN_MainMenuPlane.visible = false;
			}
			
			if (mHowToMenu == true && mIsEnglish == true)
			{
				mMenuLoader.mEN_HowToMenuPlane.visible = true;
			}
			else
			{
				mMenuLoader.mEN_HowToMenuPlane.visible = false;
			}
			
			if (mHighscoreMenu == true && mIsEnglish == true)
			{
				mMenuLoader.mEN_HighscoreMenuPlane.visible = true;
			}
			else
			{
				mMenuLoader.mEN_HighscoreMenuPlane.visible = false;
			}
			
			if (mOptionsMenu == true && mIsEnglish == true)
			{
				mMenuLoader.mEN_OptionsMenuPlane.visible = true;
			}
			else
			{
				mMenuLoader.mEN_OptionsMenuPlane.visible = false;
			}			
			
			////////////////////////////////////////////////////////////
			// The Dutch Language Setting
			
			if (mMainMenu == true && mIsDutch == true)
			{
				mMenuLoader.mNL_MainMenuPlane.visible = true;
			}
			else
			{
				mMenuLoader.mNL_MainMenuPlane.visible = false;
			}
			
			if (mHowToMenu == true && mIsDutch == true)
			{
				mMenuLoader.mNL_HowToMenuPlane.visible = true;
			}
			else
			{
				mMenuLoader.mNL_HowToMenuPlane.visible = false;
			}
			
			if (mHighscoreMenu == true && mIsDutch == true)
			{
				mMenuLoader.mNL_HighscoreMenuPlane.visible = true;
			}
			else
			{
				mMenuLoader.mNL_HighscoreMenuPlane.visible = false;
			}
			
			if (mOptionsMenu == true && mIsDutch == true)
			{
				mMenuLoader.mNL_OptionsMenuPlane.visible = true;
			}
			else
			{
				mMenuLoader.mNL_OptionsMenuPlane.visible = false;
			}	

			////////////////////////////////////////////////////////////
			// The English Language Setting
			////////////////////////////////////////////////////////////
			
			if (mIngameMenu == true && mIsEnglish == true)
			{
				mMenuLoader.mEN_IngameMenuPlane.visible = true;
			}
			else
			{
				mMenuLoader.mEN_IngameMenuPlane.visible = false;
			}
			
			if (mHowToIngameMenu == true && mIsEnglish == true)
			{
				mMenuLoader.mEN_HowToIngameMenuPlane.visible = true;
			}
			else
			{
				mMenuLoader.mEN_HowToIngameMenuPlane.visible = false;
			}
			
			if (mHighscoreIngameMenu == true && mIsEnglish == true)
			{
				mMenuLoader.mEN_HighscoreIngameMenuPlane.visible = true;
			}
			else
			{
				mMenuLoader.mEN_HighscoreIngameMenuPlane.visible = false;
			}
			
			if (mOptionsIngameMenu == true && mIsEnglish == true)
			{
				mMenuLoader.mEN_OptionsIngameMenuPlane.visible = true;
			}
			else
			{
				mMenuLoader.mEN_OptionsIngameMenuPlane.visible = false;
			}			
			
			////////////////////////////////////////////////////////////
			// The Dutch Language Setting
			
			if (mIngameMenu == true && mIsDutch == true)
			{
				mMenuLoader.mNL_IngameMenuPlane.visible = true;
			}
			else
			{
				mMenuLoader.mNL_IngameMenuPlane.visible = false;
			}
			
			if (mHowToIngameMenu == true && mIsDutch == true)
			{
				mMenuLoader.mNL_HowToIngameMenuPlane.visible = true;
			}
			else
			{
				mMenuLoader.mNL_HowToIngameMenuPlane.visible = false;
			}
			
			if (mHighscoreIngameMenu == true && mIsDutch == true)
			{
				mMenuLoader.mNL_HighscoreIngameMenuPlane.visible = true;
			}
			else
			{
				mMenuLoader.mNL_HighscoreIngameMenuPlane.visible = false;
			}
			
			if (mOptionsIngameMenu == true && mIsDutch == true)
			{
				mMenuLoader.mNL_OptionsIngameMenuPlane.visible = true;
			}
			else
			{
				mMenuLoader.mNL_OptionsIngameMenuPlane.visible = false;
			}	
		} 
		
		public function onEnterFrame(ev : Event) : void
		{
			switch(mMenuSelection)
			{
				////////////////////////////////////////////////////////////
				//Main Menu Arrow
				////////////////////////////////////////////////////////////
				case 0:
					mMenuLoader.mArrow.y = 110;
					mMenuLoader.mArrow.x = -250;
					break;
				case 1:
					mMenuLoader.mArrow.y = 70;
					mMenuLoader.mArrow.x = -250;
					break;
				case 2:
					mMenuLoader.mArrow.y = 30;
					mMenuLoader.mArrow.x = -250;
					break;
				case 3:
					mMenuLoader.mArrow.y = -10;
					mMenuLoader.mArrow.x = -250;
					break;
				
				////////////////////////////////////////////////////////////
				// How To Play Arrow
				case 4:
					mMenuLoader.mArrow.y = -191.5;
					mMenuLoader.mArrow.x = -303;
					break;
				
				////////////////////////////////////////////////////////////
				// Highscore Menu Arrow
				case 5:
					mMenuLoader.mArrow.y = -191.5;
					mMenuLoader.mArrow.x = -303;
					break;
				
				////////////////////////////////////////////////////////////
				// Options Menu Arrow
				case 6:
					mMenuLoader.mArrow.y = 63;
					mMenuLoader.mArrow.x = -303;
					break;
				case 7:
					mMenuLoader.mArrow.y = 38;
					mMenuLoader.mArrow.x = -303;
					break;
				case 8:
					mMenuLoader.mArrow.y = -191.5;
					mMenuLoader.mArrow.x = -303;
					break;
				
				////////////////////////////////////////////////////////////
				//Ingame Menu
				////////////////////////////////////////////////////////////
				
				case 10:
					mMenuLoader.mArrow.y = 110;
					mMenuLoader.mArrow.x = -250;
					break;
				case 11:
					mMenuLoader.mArrow.y = 70;
					mMenuLoader.mArrow.x = -250;
					break;
				case 12:
					mMenuLoader.mArrow.y = 30;
					mMenuLoader.mArrow.x = -250;
					break;
				case 13:
					mMenuLoader.mArrow.y = -10;
					mMenuLoader.mArrow.x = -250;
					break;
				case 14:
					mMenuLoader.mArrow.y = -50;
					mMenuLoader.mArrow.x = -250;
					break;
			}
			
			mView.render();
		}
		
		public function MenuDestroy(ev : Event) : void
		{
			trace('U Dead')
			stage.removeEventListener( KeyboardEvent.KEY_DOWN, keyEventDown);
			stage.removeEventListener( KeyboardEvent.KEY_UP, keyEventUp );
			stage.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		public function MenuCreate(ev : Event) : void
		{
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyEventDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyEventUp );
			stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
	}
}