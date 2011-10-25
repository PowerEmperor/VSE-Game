package VSEGame
{
	import away3d.animators.*;
	import away3d.cameras.*;
	import away3d.containers.*;
	import away3d.core.base.*;
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
		
		public function Game()
		{
			mGameLoader = new GameLoader();
			mTruckContainer = new ObjectContainer3D();
			mLevelContainer = new ObjectContainer3D();
			
			mView = new View3D({x:320, y:360});
			addChild(mView);
			
			mScene = mView.scene;
			mCamera = mView.camera;
			
			Init();
			
			addEventListener(Event.ADDED_TO_STAGE, GameCreate);
			addEventListener(Event.REMOVED_FROM_STAGE, GameDestroy);
		}
		
		public function Init() : void
		{
			mTruckContainer.addChild(mGameLoader.mTruck);
			mLevelContainer.addChild(mGameLoader.mLevel);
			
			//mScene.addChild(mGameLoader.mLevel);
			mScene.addChild(mTruckContainer);
			mScene.addChild(mLevelContainer);
			
			mGameLoader.mTruck.x = mTruckContainer.x;
			mGameLoader.mTruck.y = mTruckContainer.y;
			mGameLoader.mTruck.z = mTruckContainer.z;
			
			mTruckContainer.x = -260;
			mTruckContainer.y = 0;
			mTruckContainer.z = -168;
			mTruckContainer.rotationY = 90;
			mTruckContainer.scale(1);
			
			mLevelContainer.scale(1);
		}
		
		private function HandlePlayer() : void
		{
			
			mTruckContainer.x += (speed * Math.sin(mTruckContainer.rotationY*(Math.PI/180)));
			mTruckContainer.z += (speed * Math.cos(mTruckContainer.rotationY*(Math.PI/180)));
			
			//Stopping Code
			
			if (keyForwardPressed == false)
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
			}
			
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
				
				if(speed < 0)speed += 0.3;
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
			
			//trace('test');
			/*switch( ev.keyCode )
			{
				
				case Keyboard.UP:
					
					keyForwardPressed = true;
					keyPressed = true;
					
					if(speed < 0)speed += 0.25;
					if (speed < 55){speed += 0.1;}
					
				break;
				
				
				case Keyboard.DOWN:
					
					keyReversePressed = true;
					keyPressed = true;
					
					if(speed > 0)speed -= 0.25;
					if(speed > -25)speed -= 0.1;
					
				break;
				
				
				case Keyboard.LEFT:
					
					keyLeftPressed = true;
					
					if (speed!=0)mTruckContainer.rotationY -= 2;
					
				break;
				
				
				case Keyboard.RIGHT:
					
					keyRightPressed = true;
					
					if (speed!=0)mTruckContainer.rotationY += 2;
					
				break;
			}*/
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
		
		
		protected function onEnterFrame(ev:Event) : void
		{
			trace('Speed', speed);
			//trace('X', mTruck.x);
			//trace('Z Level', mLevel.z);
			//trace('Z Truck', mTruck.z);
			//trace('Z Camera', mView.z);
			
			trace('X', mTruckContainer.x);
			trace('Y', mTruckContainer.y);
			trace('Z', mTruckContainer.z);
			
			//mView.camera.y = -(stage.mouseY - stage.stageHeight/2);
			//mView.camera.x = stage.mouseX - stage.stageWidth/2;
			
			HandlePlayer();
			/*
			trace(mTruck);
			trace(mLevel);
			trace(mTruckContainer);
			trace(speed);
			*/
			
			mCamera.lookAt(mTruckContainer.position);
			mCamera.x = mTruckContainer.x - ((5) * Math.sin(mTruckContainer.rotationY * Math.PI / 180));
			mCamera.z = mTruckContainer.z - ((5) * Math.cos(mTruckContainer.rotationY * Math.PI / 180));
			mCamera.y = 1.5;
			

			//mCamera.lookAt(mGameLoader.mTruck.position);
			//mView.forceUpdate=1;
			mView.render();
			
		}
		
		public function GameDestroy(ev : Event) : void
		{
			stage.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			stage.removeEventListener( KeyboardEvent.KEY_DOWN, mKeyDownHandler);
			stage.removeEventListener( KeyboardEvent.KEY_UP, mKeyUpHandler );
		}

		public function GameCreate(ev : Event) : void
		{
			stage.addEventListener(KeyboardEvent.KEY_DOWN, mKeyDownHandler);
			stage.addEventListener(KeyboardEvent.KEY_UP, mKeyUpHandler );
			stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
	}
}