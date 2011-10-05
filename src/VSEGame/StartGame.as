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
	
	public class StartGame extends Sprite
	{
		
		public var mView : View3D;
		protected var mCamera:Camera;
		protected var mGameLoader:GameLoader;
		public var mTruck:Object3D;
		
		public function StartGame()
		{
			mGameLoader = new GameLoader();
			addChild(mGameLoader);
			
			mTruck = mGameLoader.mTruck;
			mCamera = new Camera(mTruck.position);
			addChild(mCamera);
			
			mView = new View3D();
			mView.x = 250;
			mView.y = 200;
			addChild(mView);
			
			mView.camera = mCamera.mCamera;
			mView.scene.addChild(mTruck);
			
			addEventListener(Event.ENTER_FRAME, OnEnterFrame);
		}
		
		protected function OnEnterFrame(ev:Event) : void
		{
			mView.camera.y = -(stage.mouseY - stage.stageHeight/2);
			mView.camera.x = stage.mouseX - stage.stageWidth/2;
			
			mView.scene.addChild(mTruck);
			mView.render();
		}
	}
}
