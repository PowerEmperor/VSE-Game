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
		[Embed (source="data/Menu/EN_Main_Menu.png")] private var EN_MainMenu:Class;
		[Embed (source="data/Menu/EN_HowTo_Menu.png")] private var EN_HowToMenu:Class;
		[Embed (source="data/Menu/EN_Highscore_Menu.png")] private var EN_HighscoreMenu:Class;
		[Embed (source="data/Menu/EN_Options_Menu.png")] private var EN_OptionsMenu:Class;
		
		[Embed (source="data/Menu/NL_Main_Menu.png")] private var NL_MainMenu:Class;
		[Embed (source="data/Menu/NL_HowTo_Menu.png")] private var NL_HowToMenu:Class;
		[Embed (source="data/Menu/NL_Highscore_Menu.png")] private var NL_HighscoreMenu:Class;
		[Embed (source="data/Menu/NL_Options_Menu.png")] private var NL_OptionsMenu:Class;
		
		[Embed (source="data/vera.swf", mimeType="application/octet-stream")] private var mVera : Class;
		
		//The English Planes and Material.
		protected var mEN_MainMenuPlane:Plane;
		protected var mEN_HowToMenuPlane:Plane;
		protected var mEN_HighscoreMenuPlane:Plane;
		protected var mEN_OptionsMenuPlane:Plane;
		
		protected var mEN_MenuMaterial:BitmapMaterial;
		protected var mEN_HowToMenuMaterial:BitmapMaterial;
		protected var mEN_HighscoreMenuMaterial:BitmapMaterial;
		protected var mEN_OptionsMenuMaterial:BitmapMaterial;
		
		//The Dutch Planes and Material.
		protected var mNL_MainMenuPlane:Plane;
		protected var mNL_HowToMenuPlane:Plane;
		protected var mNL_HighscoreMenuPlane:Plane;
		protected var mNL_OptionsMenuPlane:Plane;
		
		protected var mNL_MenuMaterial:BitmapMaterial;
		protected var mNL_HowToMenuMaterial:BitmapMaterial;
		protected var mNL_HighscoreMenuMaterial:BitmapMaterial;
		protected var mNL_OptionsMenuMaterial:BitmapMaterial;
		
		//FONT VARS
		protected var mFontVera:ByteArray;
		
		protected var mKeyPressed:Boolean;
		
		//protected var GameRunning:Boolean;
		
		protected var mArrow:TextField3D;
		
		public var mMenuSelection:int
		public var mHowToMenuSelection:int;
		public var mHighscoreMenuSelection:int;
		public var mOptionsMenuSelection:int;
		
		//The Vars for the check in what menu part there in. This is for the Controls
		public var mMainMenu:Boolean;
		public var mHowToMenu:Boolean;
		public var mHighscoreMenu:Boolean;
		public var mOptionsMenu:Boolean;
		
		// The Vars for the Language settings.
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
			
			GetResources();
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
		
		protected function GetResources():void
		{			
			//Cast bitmaps
			mEN_MenuMaterial = new BitmapMaterial(Cast.bitmap(EN_MainMenu));
			mEN_HowToMenuMaterial = new BitmapMaterial(Cast.bitmap(EN_HowToMenu));
			mEN_HighscoreMenuMaterial = new BitmapMaterial(Cast.bitmap(EN_HighscoreMenu));
			mEN_OptionsMenuMaterial = new BitmapMaterial(Cast.bitmap(EN_OptionsMenu));
			
			mNL_MenuMaterial = new BitmapMaterial(Cast.bitmap(NL_MainMenu));
			mNL_HowToMenuMaterial = new BitmapMaterial(Cast.bitmap(NL_HowToMenu));
			mNL_HighscoreMenuMaterial = new BitmapMaterial(Cast.bitmap(NL_HighscoreMenu));
			mNL_OptionsMenuMaterial = new BitmapMaterial(Cast.bitmap(NL_OptionsMenu));
			
			//Create font file
			mFontVera = new mVera() as ByteArray;
			VectorText.extractFont(mFontVera);
			
		}
		
		protected function CreateScene():void
		{			
			//Create the Background plane and add the Texture
			//This is for the English Language
			mEN_MainMenuPlane = new Plane();
			mEN_MainMenuPlane.width = 640;
			mEN_MainMenuPlane.height = 480;
			mEN_MainMenuPlane.x = 0;
			mEN_MainMenuPlane.y = 0;
			mEN_MainMenuPlane.yUp = false;
			mEN_MainMenuPlane.material = mEN_MenuMaterial;
			mEN_MainMenuPlane.bothsides = true;
			mView.scene.addChild(mEN_MainMenuPlane);
			
			mEN_HowToMenuPlane = new Plane();
			mEN_HowToMenuPlane.width = 640;
			mEN_HowToMenuPlane.height = 480;
			mEN_HowToMenuPlane.x = 0;
			mEN_HowToMenuPlane.y = 0;
			mEN_HowToMenuPlane.yUp = false;
			mEN_HowToMenuPlane.material = mEN_HowToMenuMaterial;
			mEN_HowToMenuPlane.bothsides = true;
			mView.scene.addChild(mEN_HowToMenuPlane);
			
			mEN_HighscoreMenuPlane = new Plane();
			mEN_HighscoreMenuPlane.width = 640;
			mEN_HighscoreMenuPlane.height = 480;
			mEN_HighscoreMenuPlane.x = 0;
			mEN_HighscoreMenuPlane.y = 0;
			mEN_HighscoreMenuPlane.yUp = false;
			mEN_HighscoreMenuPlane.material = mEN_HighscoreMenuMaterial;
			mEN_HighscoreMenuPlane.bothsides = true;
			mView.scene.addChild(mEN_HighscoreMenuPlane);
			
			mEN_OptionsMenuPlane = new Plane();
			mEN_OptionsMenuPlane.width = 640;
			mEN_OptionsMenuPlane.height = 480;
			mEN_OptionsMenuPlane.x = 0;
			mEN_OptionsMenuPlane.y = 0;
			mEN_OptionsMenuPlane.yUp = false;
			mEN_OptionsMenuPlane.material = mEN_OptionsMenuMaterial;
			mEN_OptionsMenuPlane.bothsides = true;
			mView.scene.addChild(mEN_OptionsMenuPlane);
			
			//This is for the Dutch Language
			mNL_MainMenuPlane = new Plane();
			mNL_MainMenuPlane.width = 640;
			mNL_MainMenuPlane.height = 480;
			mNL_MainMenuPlane.x = 0;
			mNL_MainMenuPlane.y = 0;
			mNL_MainMenuPlane.yUp = false;
			mNL_MainMenuPlane.material = mNL_MenuMaterial;
			mNL_MainMenuPlane.bothsides = true;
			mView.scene.addChild(mNL_MainMenuPlane);
			
			mNL_HowToMenuPlane = new Plane();
			mNL_HowToMenuPlane.width = 640;
			mNL_HowToMenuPlane.height = 480;
			mNL_HowToMenuPlane.x = 0;
			mNL_HowToMenuPlane.y = 0;
			mNL_HowToMenuPlane.yUp = false;
			mNL_HowToMenuPlane.material = mNL_HowToMenuMaterial;
			mNL_HowToMenuPlane.bothsides = true;
			mView.scene.addChild(mNL_HowToMenuPlane);
			
			mNL_HighscoreMenuPlane = new Plane();
			mNL_HighscoreMenuPlane.width = 640;
			mNL_HighscoreMenuPlane.height = 480;
			mNL_HighscoreMenuPlane.x = 0;
			mNL_HighscoreMenuPlane.y = 0;
			mNL_HighscoreMenuPlane.yUp = false;
			mNL_HighscoreMenuPlane.material = mNL_HighscoreMenuMaterial;
			mNL_HighscoreMenuPlane.bothsides = true;
			mView.scene.addChild(mNL_HighscoreMenuPlane);
			
			mNL_OptionsMenuPlane = new Plane();
			mNL_OptionsMenuPlane.width = 640;
			mNL_OptionsMenuPlane.height = 480;
			mNL_OptionsMenuPlane.x = 0;
			mNL_OptionsMenuPlane.y = 0;
			mNL_OptionsMenuPlane.yUp = false;
			mNL_OptionsMenuPlane.material = mNL_OptionsMenuMaterial;
			mNL_OptionsMenuPlane.bothsides = true;
			mView.scene.addChild(mNL_OptionsMenuPlane);

			
			//The Arrow key Text field
			mArrow = new TextField3D('Vera Sans');
			mArrow.size = 25;
			mArrow.width = 500;
			mArrow.x = -250;
			mArrow.y = 100;
			mArrow.text = "»";
			mArrow.material = new ColorMaterial(0x990E17);
			mView.scene.addChild(mArrow);
			
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
			// These are the Controls for the Main Menu
			if (mMainMenu == true && mKeyPressed == false)
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
		} // keyEventDown'
		
		public function MenuState() : void
		{	
			
			mEN_MainMenuPlane.visible = true;
			mEN_HowToMenuPlane.visible = false;
			mEN_HighscoreMenuPlane.visible = false;
			mEN_OptionsMenuPlane.visible = false;
			
			mNL_MainMenuPlane.visible = false;
			mNL_HowToMenuPlane.visible = false;
			mNL_HighscoreMenuPlane.visible = false;
			mNL_OptionsMenuPlane.visible = false;
			
			// The English Language Setting
			if (mMainMenu == true && mIsEnglish == true)
			{
				mEN_MainMenuPlane.visible = true;
			}
			else
			{
				mEN_MainMenuPlane.visible = false;
			}
			
			if (mHowToMenu == true && mIsEnglish == true)
			{
				mEN_HowToMenuPlane.visible = true;
			}
			else
			{
				mEN_HowToMenuPlane.visible = false;
			}
			
			if (mHighscoreMenu == true && mIsEnglish == true)
			{
				mEN_HighscoreMenuPlane.visible = true;
			}
			else
			{
				mEN_HighscoreMenuPlane.visible = false;
			}
			
			if (mOptionsMenu == true && mIsEnglish == true)
			{
				mEN_OptionsMenuPlane.visible = true;
			}
			else
			{
				mEN_OptionsMenuPlane.visible = false;
			}			
			
			// The Dutch Language Setting
			if (mMainMenu == true && mIsDutch == true)
			{
				mNL_MainMenuPlane.visible = true;
			}
			else
			{
				mNL_MainMenuPlane.visible = false;
			}
			
			if (mHowToMenu == true && mIsDutch == true)
			{
				mNL_HowToMenuPlane.visible = true;
			}
			else
			{
				mNL_HowToMenuPlane.visible = false;
			}
			
			if (mHighscoreMenu == true && mIsDutch == true)
			{
				mNL_HighscoreMenuPlane.visible = true;
			}
			else
			{
				mNL_HighscoreMenuPlane.visible = false;
			}
			
			if (mOptionsMenu == true && mIsDutch == true)
			{
				mNL_OptionsMenuPlane.visible = true;
			}
			else
			{
				mNL_OptionsMenuPlane.visible = false;
			}	
		}
		
		public function onEnterFrame(ev : Event) : void
		{
			switch(mMenuSelection)
			{
				//Main Menu Arrow
				case 0:
					mArrow.y = 110;
					mArrow.x = -250;
					break;
				case 1:
					mArrow.y = 70;
					mArrow.x = -250;
					break;
				case 2:
					mArrow.y = 30;
					mArrow.x = -250;
					break;
				case 3:
					mArrow.y = -10;
					mArrow.x = -250;
					break;
				
				// How To Play Arrow
				case 4:
					mArrow.y = -191.5;
					mArrow.x = -303;
					break;
				
				// Highscore Menu Arrow
				case 5:
					mArrow.y = -191.5;
					mArrow.x = -303;
					break;
				
				// Options Menu Arrow
				case 6:
					mArrow.y = 63;
					mArrow.x = -303;
					break;
				case 7:
					mArrow.y = 38;
					mArrow.x = -303;
					break;
				case 8:
					mArrow.y = -191.5;
					mArrow.x = -303;
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