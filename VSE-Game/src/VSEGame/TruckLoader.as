package VSEGame
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
	
	import flash.display.Scene;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.BitmapFilter;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.BitmapFilterType;
	import flash.filters.GlowFilter;
	import flash.geom.Vector3D;
	
	import wumedia.vector.*;
	
	[SWF(width="500", height="400", frameRate="60")]
	
	public class TruckLoader extends Sprite
	{	
		// variables
		var move:Boolean = false;
		var lastPanAngle:Number;
		var lastTiltAngle:Number;
		var lastMouseX:Number;
		var lastMouseY:Number;
		//var mCamera:Camera3D;
		var mView:View3D;
		var sky:Sphere;
		public var mTruck:Object3D = Max3DS.load("data/Truck.3DS");
		
		
		public function TruckLoader()
		{
			// Create and set up the camera
			/*camera = new HoverCamera3D({zoom:2, focus:100, distance:25});
			camera.panAngle = 0;
			camera.tiltAngle = 0;
			camera.hover(true);
			camera.yfactor = 2;
			camera.
			view = new View3D({scene:scene, camera:camera, renderer:Renderer.CORRECT_Z_ORDER});
			// add to display
			addChild(view);
			// Adjust view 
			view.x = 250; 
			view.y = 200;*/
			
			/*mCamera = new Camera3D();
			mCamera.fov = 90; // in degrees
			//	mCamera.target = mTruck;
			mCamera.zoom = 1;
			mCamera.x = 0;
			mCamera.y = 0;
			mCamera.z = 0;
			mCamera.focus = 100;*/
			
			var mCcamera : TargetCamera3D = new TargetCamera3D();
			mCcamera.z = -100;
			mCcamera.y = -100;
			
			mCcamera.target = mTruck;
			
			
			
			mView = new View3D();
			mView.x = 250;
			mView.y = 200;
			//mView.camera = mCamera;
			addChild(mView);
			mView.camera = mCcamera;
			
			mTruck.scale(3);
			//trace('Z Truck', mTruck.z);
			//  var mTruck:Object3D = Obj.load("data/mTruck.obj",{autoLoadTextures: true});
			//mView.scene.addChild(mTrailer);
			
			
			
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		function onEnterFrame(e:Event):void
		{
			mView.render();
			mView.scene.addChild(mTruck);
			
			trace('X Truck', mTruck.x);
			trace('Y Truck', mTruck.y);
			trace('Z Truck', mTruck.z);
			//trace('Z Truck', mTruck.z);
			/*camera.x = mTruck.x;
			camera.y = mTruck.y;
			camera.z = mTruck.z;
			
			if (move)
			{
			camera.panAngle = cameraSpeed*(stage.mouseX - lastMouseX) + lastPanAngle;
			camera.tiltAngle = cameraSpeed*(stage.mouseY - lastMouseY) + lastTiltAngle;
			}*/
			//camera.hover();
			//mView.render();
		}
	}
}