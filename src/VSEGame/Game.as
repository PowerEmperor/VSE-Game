package VSEGame
{
	import away3d.animators.*;
	import away3d.cameras.*;
	import away3d.containers.*;
	import away3d.core.base.*;
	import away3d.core.clip.RectangleClipping;
	import away3d.core.math.*;
	import away3d.core.render.Renderer;
	import away3d.core.utils.*;
	import away3d.events.*;
	import away3d.loaders.*;
	import away3d.loaders.Ase;
	import away3d.loaders.Collada;
	import away3d.loaders.Loader3D;
	import away3d.loaders.Max3DS;
	import away3d.loaders.utils.*;
	import away3d.materials.*;
	import away3d.primitives.*;
	import away3d.primitives.Cube;
	
	import flash.display.*;
	import flash.events.*;
	import flash.external.ExternalInterface;
	import flash.text.TextField;
	import flash.ui.Keyboard;
	import flash.utils.*;
	
	public class Game extends Sprite
	{
		
		public var mView : View3D;
		public var mScene:Scene3D;
		public var mCamera:Camera3D;
		
		//protected var mCamera:Camera;
		protected var mGameLoader:GameLoader;
		
		//public var mTruck:Sphere;
		
		public var mTruckContainer:ObjectContainer3D;
		public var mLevelContainer:ObjectContainer3D;
		
		public var mRedBuildingContainer:ObjectContainer3D;
		public var mBlueBuildingContainer:ObjectContainer3D;
		
		//public var mTruck:Object3D;
		
		//public var mLevel:Object3D;
		
		private var topSpeed:Number = 0;
		private var topSteer:Number = 0;
		private var speed:Number = 0;
		private var steer:Number = 0;
		
		private var keyRight:Boolean = false;
		private var keyLeft:Boolean = false;
		private var keyForward:Boolean = false;
		private var keyReverse:Boolean = false;
		
		private var keyRightPressed:Boolean = false;
		private var keyLeftPressed:Boolean = false;
		private var keyForwardPressed:Boolean = false;
		private var keyReversePressed:Boolean = false;
		
		private var keyPressed:Boolean = false;
		
		[Embed (source="data/vera.swf", mimeType="application/octet-stream")] private var mVera : Class;
		
		public var mSpeedMeter:TextField;
		
		public var mShowPosX:TextField;
		public var mShowPosZ:TextField;
		
		public var mTimer:TextField;
		
		public function Game()
		{
			mGameLoader = new GameLoader();
			
			mTruckContainer = new ObjectContainer3D();
			mLevelContainer = new ObjectContainer3D();
			
			mRedBuildingContainer = new ObjectContainer3D();
			mBlueBuildingContainer = new ObjectContainer3D();
			
			mView = new View3D({x:320, y:360});
			addChild(mView);
			
			mView.clipping = new RectangleClipping( { minX:-320, maxX:320, minY:-480, maxY:480 } );
			
			mScene = mView.scene;
			mCamera = mView.camera;
			
			Init();
			
			addEventListener(Event.ADDED_TO_STAGE, GameCreate);
			addEventListener(Event.REMOVED_FROM_STAGE, GameDestroy);
		}
		
		public function Init() : void
		{
			mTruckContainer.addChild(mGameLoader.mPlayerLoader);
			mLevelContainer.addChild(mGameLoader.mLevelLoader);
			
			mRedBuildingContainer.addChild(mGameLoader.mRedBuildingLoader);
			mBlueBuildingContainer.addChild(mGameLoader.mBlueBuildingLoader);
			
			//Add the 3d Models to the Scene.
			
			mScene.addChild(mTruckContainer);
			mScene.addChild(mLevelContainer);
			
			mScene.addChild(mRedBuildingContainer);
			mScene.addChild(mBlueBuildingContainer);
			
			mGameLoader.mPlayerLoader.x = mTruckContainer.x;
			mGameLoader.mPlayerLoader.y = mTruckContainer.y;
			mGameLoader.mPlayerLoader.z = mTruckContainer.z;
			
			//Start pos of the Player.
			
			mTruckContainer.x = 316;
			mTruckContainer.y = 0;
			mTruckContainer.z = -278;
			mTruckContainer.rotationY = 0;
			mTruckContainer.scale(2);
			
			//Pos of buildings.
			
			mRedBuildingContainer.x = 0;
			mRedBuildingContainer.y = 0;
			mRedBuildingContainer.z = 0;
			
			//mRedBuildingContainer.min
			
			mBlueBuildingContainer.x = 50;
			mBlueBuildingContainer.y = 0;
			mBlueBuildingContainer.z = 0;
			
			mLevelContainer.scale(2);
			
			MakeHUD();
		}
		
		public function MakeHUD() : void
		{
			mSpeedMeter = new TextField();
			mSpeedMeter.width = 500;
			mSpeedMeter.height = 200;
			mSpeedMeter.x=0;
			mSpeedMeter.y=0;
			addChild(mSpeedMeter);
			
			
			mShowPosX = new TextField();
			mShowPosX.width = 500;
			mShowPosX.height = 200;
			mShowPosX.x=0;
			mShowPosX.y=15;
			addChild(mShowPosX);

			mShowPosZ = new TextField();
			mShowPosZ.width = 500;
			mShowPosZ.height = 200;
			mShowPosZ.x=0;
			mShowPosZ.y=30;
			addChild(mShowPosZ);
			
			
			mTimer = new TextField();
			mTimer.width = 500;
			mTimer.height = 200;
			mTimer.x=0;
			mTimer.y=45;
			addChild(mTimer);
		}
		
		private function HandlePlayer() : void
		{
			
			mTruckContainer.x += (speed * Math.sin(mTruckContainer.rotationY*(Math.PI/180)));
			mTruckContainer.z += (speed * Math.cos(mTruckContainer.rotationY*(Math.PI/180)));
			
			//////////////////////////////////////////////////
			//Stopping Code.
			//Putting this inactive during the fix for "Finding a way to press multiple buttons". 
			//////////////////////////////////////////////////
			
			/*if (keyForwardPressed == false)
			{
			if (speed > 0)
			{
			speed -= 0.05;
			}
			}
			
			if (keyReversePressed == false)
			{
			if (speed < 0)
			{
			speed += 0.05;
			}
			}*/
			
			//////////////////////////////////////////////////
			//At this way the truck will stop.
			
			if (keyPressed == false)
			{
				if (speed > -0.4 && speed < 0.4)
				{
					speed = 0;	
				}
			}
		}
		
		private function mKeyDownHandler(ev : KeyboardEvent) : void
		{
			
			if (ev.keyCode == Keyboard.UP)
			{
				keyForwardPressed = true;
				keyPressed = true;
				
				if(speed < 0)speed += 0.5;
				if (speed < 25){speed += 0.1;}
			}
			
			if (ev.keyCode == Keyboard.DOWN)
			{
				keyReversePressed = true;
				keyPressed = true;
				
				if(speed > 0)speed -= 0.3;
				if(speed > -12)speed -= 0.1;
			}
			
			if (ev.keyCode == Keyboard.LEFT)
			{
				keyLeftPressed = true;
				
				if (speed!=0)mTruckContainer.rotationY -= 2;
			}
			
			if (ev.keyCode == Keyboard.RIGHT)
			{
				keyRightPressed = true;
				
				if (speed!=0)mTruckContainer.rotationY += 2;
			}
			
			if ( ev.keyCode == Keyboard.SPACE)
			{
				if(speed < 0)speed += 0.5;
				if(speed > 0)speed -= 0.5;
			}
		}
		
		private function mKeyUpHandler(ev : KeyboardEvent) : void
		{
			if (keyForwardPressed == true)
			{
				keyForwardPressed = false;
			}
			
			if (keyReversePressed == true)
			{
				keyReversePressed = false;
			}
			
			if (keyLeftPressed == true)
			{
				keyLeftPressed = false;
			}
			
			if (keyRightPressed == true)
			{
				keyRightPressed = false;
			}
			
			keyPressed = false;
		}
		
		//////////////////////////////////////////////////
		//A try for pressing multiple Buttons.
		//This Failed :(
		//////////////////////////////////////////////////
		
		/*
		private function mKeyLeftDownHandler(ev : KeyboardEvent) : void
		{
		if (ev.keyCode == Keyboard.LEFT)
		{
		keyLeftPressed = true;
		
		if (speed!=0)mTruckContainer.rotationY -= 2;
		}
		}
		
		private function mKeyRightDownHandler(ev : KeyboardEvent) : void
		{
		if (ev.keyCode == Keyboard.RIGHT)
		{
		keyRightPressed = true;
		
		if (speed!=0)mTruckContainer.rotationY += 2;
		}
		}
		
		private function mKeyLeftUpHandler(ev : KeyboardEvent) : void
		{
		
		if (keyLeftPressed == true)
		{
		keyLeftPressed = false;
		}
		
		keyPressed = false;
		}
		
		private function mKeyRightUpHandler(ev : KeyboardEvent) : void
		{
		if (keyRightPressed == true)
		{
		keyRightPressed = false;
		}
		
		keyPressed = false;
		}
		
		private function mKeyUpHandler(ev : KeyboardEvent) : void
		{
		if (keyForwardPressed == true)
		{
		keyForwardPressed = false;
		}
		
		if (keyReversePressed == true)
		{
		keyReversePressed = false;
		}			
		keyPressed = false;
		}*/
		
		//////////////////////////////////////////////////
		//A try for pressing multiple Buttons.
		//This Failed :(
		//////////////////////////////////////////////////
		
		protected function onEnterFrame(ev:Event) : void
		{			
			mSpeedMeter.text = 'Speed Meter = '+ (speed*10).toFixed(0);
			
			mShowPosX.text = 'X = '+ (mTruckContainer.x).toFixed(0);
			mShowPosZ.text = 'Z = '+ (mTruckContainer.z).toFixed(0);
			
			mTimer.text = 'Time = '+ (speed/60).toFixed(0);
			
			trace('X', mTruckContainer.x);
			trace('Y', mTruckContainer.y);
			trace('Z', mTruckContainer.z);

			HandlePlayer();
			
			mCamera.lookAt(mTruckContainer.position);
			mCamera.x = mTruckContainer.x - ((5) * Math.sin(mTruckContainer.rotationY * Math.PI / 180));
			mCamera.z = mTruckContainer.z - ((5) * Math.cos(mTruckContainer.rotationY * Math.PI / 180));
			mCamera.y = 1.5;
			
			mView.render();
			
		}
		
		public function GameDestroy(ev : Event) : void
		{
			stage.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			stage.removeEventListener( KeyboardEvent.KEY_DOWN, mKeyDownHandler);
			stage.removeEventListener( KeyboardEvent.KEY_UP, mKeyUpHandler );
		}
		
		public function GameReset(ev : Event) : void
		{
			mTruckContainer.x = -260;
			mTruckContainer.y = 0;
			mTruckContainer.z = -168;
		}
		
		public function GameCreate(ev : Event) : void
		{
			stage.addEventListener(KeyboardEvent.KEY_DOWN, mKeyDownHandler);
			stage.addEventListener(KeyboardEvent.KEY_UP, mKeyUpHandler);
			
			stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			
			
			//////////////////////////////////////////////////
			//A try for pressing multiple Buttons.
			//This Failed.
			//////////////////////////////////////////////////
			
			/*stage.addEventListener(KeyboardEvent.KEY_DOWN, mKeyLeftDownHandler);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, mKeyRightDownHandler);
			
			stage.addEventListener(KeyboardEvent.KEY_UP, mKeyLeftUpHandler);
			stage.addEventListener(KeyboardEvent.KEY_UP, mKeyRightUpHandler);*/
		}
	}
}