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
	import flash.geom.Vector3D;
	import flash.ui.Keyboard;
	import flash.utils.*;
	
	import wumedia.vector.*;
	
	//[SWF(width="500", height="400", frameRate="60")]
	
	public class Camera extends Sprite
	{
		public var mCamera : TargetCamera3D = new TargetCamera3D();
		public var mTarget:Vector3D; 
		
		public function Camera(target:Vector3D)
		{
			mTarget = target;

			Init();
			
			addEventListener(Event.ENTER_FRAME, OnEnterFrame);
		}
		
		protected function Init() : void
		{
			//mCamera.focus = 100;
			//mCamera.zoom = 1;
			

		}
		
		protected function OnEnterFrame(ev:Event) : void
		{
			
			mCamera.x = mTarget.x + 10;
			mCamera.y = mTarget.y + 100;
			mCamera.z = mTarget.z + 20;
			
			mCamera.target.position = mTarget;
			mCamera.target.position.y -= 200;
		}
	}
}