package VSEGame // Jeroen's Code (Gefixed voor Stephans werk(plus er zit veel van internet tussen))
{
	import away3d.cameras.*;
	import away3d.containers.*;
	import away3d.core.base.*;
	import away3d.core.render.Renderer;
	import away3d.core.utils.Cast;
	import away3d.loaders.Ase;
	import away3d.loaders.Collada;
	import away3d.loaders.Loader3D;
	import away3d.loaders.Max3DS;
	import away3d.loaders.Obj;
	import away3d.materials.*;
	import away3d.primitives.*;
	
	import flash.display.MovieClip;
	import flash.display.Scene;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.filters.BitmapFilter;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.BitmapFilterType;
	import flash.filters.GlowFilter;
	import flash.geom.Vector3D;
	import flash.ui.Keyboard;
	
	public class TruckSteering extends Sprite
	{
		//Settings
		protected var mTruckLoader:TruckLoader;
		
		//INTERNET CODE! Maar wel wat je nog nodig hebt aan Vars.
		/*private var speed:Number = 0;
		private var speedMax:Number = 8;
		private var speedMaxReverse:Number = -3;
		private var speedAcceleration:Number = .15;
		private var speedDeceleration:Number = .90;
		private var groundFriction:Number = .95;
		
		private var steering:Number = 0;
		private var steeringMax:Number = 2;
		private var steeringAcceleration:Number = .10;
		private var steeringFriction:Number = .98;
		
		private var velocityX:Number = 0;
		private var velocityY:Number = 0;
		private var velocityZ:Number = 0;
	
		// Waarom staat hier een dubbele declaratie?
		private var up:Boolean = false;
		private var down:Boolean = false;
		private var left:Boolean = false;
		private var right:Boolean = false;
		
		private var myCount:int =0;
		private var scene:Scene3D;
		private var camera:Camera3D;
		private var view:View3D;
		
		private var renderNow:Boolean = true;
		private var myDiceScale:Number = 30;*/
		
		// Code van stephan dat ik weet.
		private var mCamera:Camera3D;
		private var mView:View3D;
		
		private var topSpeed:Number = 0;
		private var topSteer:Number = 0;
		private var speed:Number = 0;
		private var steer:Number = 0;
		
		private var keyRight:Boolean = false;
		private var keyLeft:Boolean = false;
		private var keyForward:Boolean = false;
		private var keyReverse:Boolean = false;
		
		private var keyPressed:Boolean = false;
		
		public var mTruck:Object3D;
		
		public function TruckSteering():void 
		{
			mTruckLoader = new TruckLoader();
			addChild(mTruckLoader);
			
			addEventListener(Event.ADDED_TO_STAGE, Init);
			
		}
		
		public function Init(ev : Event) : void
		{
			removeEventListener(Event.ADDED_TO_STAGE, Init);
			
			stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			stage.addEventListener( KeyboardEvent.KEY_DOWN, mKeyDownHandler );
			stage.addEventListener( KeyboardEvent.KEY_UP, mKeyUpHandler );
			
			mView = mTruckLoader.mView;
			mTruck = mTruckLoader.mTruck;
			//mCamera = mTruckLoader.mCamera;
		}
		
		private function onEnterFrame( e:Event ):void 
		{
			//trace(speed);
			//trace('X', mTruck.x);
			//trace('Z Truck', mTruck.z);
			//trace('Z Camera', mView.z);
			mUpdateTruck();
			mView.render();	
			
			//mView.scene.addChild(mTruck);
		}
		
		
		private function mUpdateTruck():void
		{
			
			var roll :Number = speed*.2;
			
			if(Math.abs(steer)<50)
			{
				mTruck.rotationZ =  steer;
				mTruck.rotationZ =  -steer;
			}
			else
			{
				mTruck.rotationZ =  50;
				mTruck.rotationZ =  -50;
			}
			
			
			// Sturen
			mTruck.rotationY+= speed * steer /500  ;
			mTruck.y=mTruck.x;
			
			mTruck.x+=1.4*speed*Math.sin(Math.PI*(mTruck.rotationY)/180)/20;
			mTruck.z+=1.4*speed*Math.cos(Math.PI*(mTruck.rotationY)/180)/20;
			
			// Handle Speed
			
			if (keyPressed == false)
			{
				if (speed > 0)
				{
					speed -= 0.1;
				}
				
				if (speed > -0.0002 && speed < 0.0002)
				{
					speed = 0;	
				}
				
				if (speed < 0)
				{
					speed += 0.1;
				}
				
				// Steer
				if (steer > 0)
				{
					steer -= 1;
				}
				
				if (steer > -0.0002 && steer < 0.0002)
				{
					steer = 0;	
				}
				
				if (steer < 0)
				{
					steer += 1;
				}
			}
		}
		
		private function mKeyDownHandler(ev : KeyboardEvent):void
		{
			//trace('test');
			switch( ev.keyCode )
			{
				
				case Keyboard.UP:
					//trace('up');
					if (speed < 55)
					{
						keyPressed = true;
						speed +=  1;
					}
					break;
				
				
				case Keyboard.DOWN:
					//trace('down');
					if (speed > -25)
					{
						keyPressed = true;
						speed -=  1;
					}
					break;
				
				
				case Keyboard.LEFT:
					
					if (steer < 49)
					{
						keyPressed = true;
						steer += 1;
					}
					break;
				
				
				case Keyboard.RIGHT:
					if (steer > -49)
					{
						keyPressed = true;
						steer -= 1;
					}
					break;
			}
		}
		
		private function mKeyUpHandler(ev : KeyboardEvent):void
		{
			keyPressed = false;
		}
	}
	
}