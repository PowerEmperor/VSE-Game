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
	
	public class MainMenu extends Sprite
	{
		// ALL THE RESOURCES
		
		//EMBEDED RESOURCES
		//BITMAPS
		[Embed (source="data/Menu_Background.png")] private var mBackground:Class;
		//FONTS
		[Embed (source="data/vera.swf", mimeType="application/octet-stream")] private var mVera : Class;
		
		// SOUNDS
		
		//PRIMS
		protected var mBackgroundPlane:Plane;
		protected var mBitmapMaterial:BitmapMaterial;
		
		//FONT VARS
		protected var mFontVera:ByteArray;
		
		// 3D TEXT
		protected var mStart:TextField3D;
		protected var mHowtoPlay:TextField3D;
		protected var mHighScore:TextField3D;
		protected var mOptions:TextField3D;
		protected var mArrow:TextField3D;
		
		//XML DATA
		protected var mXML_Text:XMLLoader;
		
		// KEYBOARD CHECK
		protected var mIsKeyPressed:Boolean;
		
		// Game state constants. Use these 
		public var mMenuSelection:int
		protected var localSelectedMenu:int = new int();
		public var mMenuFlag:Boolean
		
		//View objects
		protected var mCamera:Camera3D;
		protected var mView:View3D;
		
		//Timer object
		protected var mTimer:Timer;
		
		public function MainMenu(selectedMenu:int)
		{
			localSelectedMenu = selectedMenu;
			addEventListener(Event.ADDED_TO_STAGE, Init);
			addEventListener(Event.ADDED_TO_STAGE, GetResources);
			addEventListener(Event.ADDED_TO_STAGE, CreateScene);
			
			mMenuFlag = false;
		}
		
		protected function Init(ev : Event) : void
		{
			removeEventListener(Event.ADDED_TO_STAGE, Init);
			
			stage.addEventListener(KeyboardEvent.KEY_UP, keyEventUp);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyEventDown);
			
			mIsKeyPressed = false;
			
			mCamera = new Camera3D();
			mCamera.fov = 90; // in degrees
			mCamera.zoom = 1;
			
			mView = new View3D();
			mView.x = 250;
			mView.y = 200;
			mView.camera = mCamera;
			addChild(mView);
			
			mTimer = new Timer(1);
			mTimer.addEventListener(TimerEvent.TIMER,TimerFunc);
			mTimer.start();
			
			
			//addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		protected function CreateScene(ev : Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, CreateScene);
			
			//Create the Background plane and add the Texture
			mBackgroundPlane = new Plane();
			mBackgroundPlane.width = 400;
			mBackgroundPlane.height = 400;
			mBackgroundPlane.x = 100;
			mBackgroundPlane.yUp = false;
			mBackgroundPlane.material = mBitmapMaterial;
			mBackgroundPlane.bothsides = true;
			mView.scene.addChild(mBackgroundPlane);
			
			//The Textfields for the Main Menu (This with help from the Lang.XML)
			mStart = new TextField3D('Vera Sans');
			mStart.size = 25;
			mStart.width = 500;
			mStart.x = -200;
			mStart.y = 100;
			mStart.material = new ColorMaterial(0x990E17);
			mView.scene.addChild(mStart)
			
			mHowtoPlay = new TextField3D('Vera Sans');
			mHowtoPlay.size = 25;
			mHowtoPlay.width = 500;
			mHowtoPlay.x = -200;
			mHowtoPlay.y = 60;
			mHowtoPlay.material = new ColorMaterial(0x990E17);
			mView.scene.addChild(mHowtoPlay);
			
			mHighScore = new TextField3D('Vera Sans');
			mHighScore.size = 25;
			mHighScore.width = 500;
			mHighScore.x = -200;
			mHighScore.y = 20;
			mHighScore.material = new ColorMaterial(0x990E17);
			mView.scene.addChild(mHighScore);
			
			mOptions = new TextField3D('Vera Sans');
			mOptions.size = 25;
			mOptions.width = 500;
			mOptions.x = -200;
			mOptions.y = -20;
			mOptions.material = new ColorMaterial(0x990E17);
			mView.scene.addChild(mOptions);
			
			//The Arrow key Text field
			mArrow = new TextField3D('Vera Sans');
			mArrow.size = 25;
			mArrow.width = 500;
			mArrow.x = -225;
			mArrow.y = 100;
			mArrow.text = "»";
			mArrow.material = new ColorMaterial(0x990E17);
			mView.scene.addChild(mArrow);
			
			//Starts the XML Loader to load the XML Data
			mXML_Text = new XMLLoader();
			
		}
		
		protected function GetResources(ev : Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, GetResources);
			
			//Cast bitmaps
			mBitmapMaterial = new BitmapMaterial(Cast.bitmap(mBackground));
			
			//Create font file
			mFontVera = new mVera() as ByteArray;
			VectorText.extractFont(mFontVera);
		}
		
		protected function TimerFunc(ev : TimerEvent) :void
		{
			mView.render();
			
			//This checks if the XML loading is done
			if(mXML_Text.Loaded)
			{
				//If yes put the XML data in the correct Textfields
				// Main Menu
				mStart.text = mXML_Text.XML_Data.language.START[mXML_Text.LanguageId];
				mHowtoPlay.text = mXML_Text.XML_Data.language.HOWTOPLAY[mXML_Text.LanguageId];
				mHighScore.text = mXML_Text.XML_Data.language.HIGHSCORE[mXML_Text.LanguageId];
				mOptions.text = mXML_Text.XML_Data.language.OPTIONS[mXML_Text.LanguageId];
			}
			
			// Set the position of the menu cursor (Arrow)
			switch(mMenuSelection)
			{
				case 0:
					mArrow.y = 100;
					break;
				case 1:
					mArrow.y = 60;
					break;
				case 2:
					mArrow.y = 20;
					break;
				case 3:
					mArrow.y = -20;
					break;
			}
		}
		
		public function keyEventUp(event:KeyboardEvent):void
		{
			mIsKeyPressed = false;
		}
		
		public function keyEventDown(event:KeyboardEvent):void
		{
			if(mIsKeyPressed == false)
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
						mIsKeyPressed = true;
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
						mIsKeyPressed = true;
						break;
					
					case Keyboard.ENTER:
						trace("PRESSING ENTER");
						if (mMenuSelection == 0)
							Die(0); trace("Selection 0");
						if (mMenuSelection == 1)
								Die(1);
						if (mMenuSelection == 2)
								Die(2);
						if (mMenuSelection == 3)
								Die(3);
						
							mMenuFlag = true;
						break;
				}
			}
		} // keyEventDown'
		
		public function Die(newSelectedMenu:int):void 
		{
			trace("PRESSING STUFF");
			removeEventListener(KeyboardEvent.KEY_DOWN, keyEventDown);
			removeEventListener(KeyboardEvent.KEY_UP, keyEventUp);
			//parent.mSelectedMenu = newSelectedMenu;
		} // Die()
	}
}