package VSEGame
{
	import away3d.cameras.*;
	import away3d.containers.*;
	import away3d.core.utils.Cast;
	import away3d.materials.*;
	import away3d.primitives.*;
	
	import flash.display.*;
	import flash.events.*;
	import flash.ui.Keyboard;
	import flash.utils.*;
	
	import wumedia.vector.*;
	
	//[SWF(width="500", height="400", frameRate="60")]
	
	public class HowToMenu extends Sprite
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
		
		// KEYBOARD CHECK
		protected var mIsKeyPressed:Boolean;
		
		// Game state constants. Use these 
		public var mMenuSelection:int = 0;
		
		//View objects
		protected var mCamera:Camera3D;
		protected var mView:View3D;
		
		//Timer object
		protected var mTimer:Timer;

		
		protected var mXML_Text:XMLLoader;
		
		protected var mHowTo:TextField3D;
		protected var mBack:TextField3D;
		protected var mArrow:TextField3D;
		
		public var mMenuFlag:Boolean;
		
		public function HowToMenu()
		{
			mMenuFlag = false;
			addEventListener(Event.ADDED_TO_STAGE, Init);
			addEventListener(Event.ADDED_TO_STAGE, GetResources);
			addEventListener(Event.ADDED_TO_STAGE, CreateScene);
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
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		protected function CreateScene(ev : Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, CreateScene);
			
			//Create the Background plane and add the Texture
			mBackgroundPlane = new Plane();
			mBackgroundPlane.width = 500;
			mBackgroundPlane.height = 400;
			mBackgroundPlane.yUp = false;
			mBackgroundPlane.material = mBitmapMaterial;
			mBackgroundPlane.bothsides = true;
			mView.scene.addChild(mBackgroundPlane);
			
			/*//The Textfields for the Main Menu (This with help from the Lang.XML)
			mStart = new TextField3D('Vera Sans');
			mStart.size = 25;
			mStart.width = 500;
			mStart.x = -200;
			mStart.y = 100;
			mStart.material = new ColorMaterial(0x990E17);
			mView.scene.addChild(mStart)*/
			
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
			//mXML_Text = new XML_Loader();
			
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
		
		protected function onEnterFrame(ev : Event) : void
		{			
			mView.render();
		}
		
		protected function TimerFunc(ev : TimerEvent) :void
		{
			//This checks if the XML loading is done
			/*if(xml_text.Loaded)
			{
			//If yes put the XML data in the correct Textfields
			// Main Menu
			_Start.text = xml_text.XML_Data.language.START[xml_text.lang_id];
			_HowtoPlay.text = xml_text.XML_Data.language.HOWTOPLAY[xml_text.lang_id];
			_HighScore.text = xml_text.XML_Data.language.HIGHSCORE[xml_text.lang_id];
			_Options.text = xml_text.XML_Data.language.OPTIONS[xml_text.lang_id];
			
			// How to Play Menu
			_HowtoPlayExplain.text = xml_text.XML_Data.language.HOWTOPLAY_EXPLAIN[xml_text.lang_id].toString();
			}*/
			
			// Set the position of the menu cursor (Arrow)
			switch(mMenuSelection)
			{
				case 0:
					mArrow.y = -110;
					break;
			}
		}
		
		protected function keyEventUp(event:KeyboardEvent):void
		{
			mIsKeyPressed = false;
		}
		
		public function keyEventDown(event:KeyboardEvent):void
		{
			if(mIsKeyPressed == false)
			{
				switch(event.keyCode)
				{			
					case Keyboard.ENTER:
							mMenuFlag = true;
						break;
				}
			}
		} // keyEventDown
	}
}