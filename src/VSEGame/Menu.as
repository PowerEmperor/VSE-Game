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
		[Embed (source="data/Main_Menu.png")] private var MainMenu:Class;
		
		[Embed (source="data/vera.swf", mimeType="application/octet-stream")] private var mVera : Class;
		
		protected var mMainMenuPlane:Plane;
		protected var mBitmapMaterial:BitmapMaterial;
		
		//FONT VARS
		protected var mFontVera:ByteArray;
		
		protected var mKeyPressed:Boolean;
		
		//protected var GameRunning:Boolean;
		
		protected var mArrow:TextField3D;
		
		public var mMenuSelection:int
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
			mBitmapMaterial = new BitmapMaterial(Cast.bitmap(MainMenu));
			
			//Create font file
			mFontVera = new mVera() as ByteArray;
			VectorText.extractFont(mFontVera);
		}
		
		protected function CreateScene():void
		{
			//Create the Background plane and add the Texture
			mMainMenuPlane = new Plane();
			mMainMenuPlane.width = 640;
			mMainMenuPlane.height = 480;
			mMainMenuPlane.x = 0;
			mMainMenuPlane.y = 0;
			mMainMenuPlane.yUp = false;
			mMainMenuPlane.material = mBitmapMaterial;
			mMainMenuPlane.bothsides = true;
			mView.scene.addChild(mMainMenuPlane);
			
			//The Arrow key Text field
			mArrow = new TextField3D('Vera Sans');
			mArrow.size = 25;
			mArrow.width = 500;
			mArrow.x = -250;
			mArrow.y = 100;
			mArrow.text = "»";
			mArrow.material = new ColorMaterial(0x990E17);
			mView.scene.addChild(mArrow);
		}
		
		public function keyEventUp(event:KeyboardEvent):void
		{
			mKeyPressed = false;
		}
		
		public function keyEventDown(event:KeyboardEvent):void
		{
			if(mKeyPressed == false)
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
						}
						
						if (mMenuSelection == 1)
							//Die(1);
						
						if (mMenuSelection == 2)
							//Die(2);
						
						if (mMenuSelection == 3)
							//Die(3);
						break;
				}
			}
		} // keyEventDown'
		
		public function onEnterFrame(ev : Event) : void
		{
			switch(mMenuSelection)
			{
				case 0:
					mArrow.y = 110;
					break;
				case 1:
					mArrow.y = 70;
					break;
				case 2:
					mArrow.y = 30;
					break;
				case 3:
					mArrow.y = -10;
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