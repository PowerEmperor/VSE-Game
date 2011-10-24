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
	import away3d.loaders.AWData;
	import away3d.loaders.Ase;
	import away3d.loaders.Collada;
	import away3d.loaders.Loader3D;
	import away3d.loaders.Max3DS;
	import away3d.loaders.utils.*;
	import away3d.materials.*;
	import away3d.primitives.*;
	
	import flash.display.*;
	import flash.events.*;
	import flash.external.ExternalInterface;
	import flash.ui.Keyboard;
	import flash.utils.*;
	
	import mx.core.BitmapAsset;
	
	public class GameLoader extends Sprite
	{
		[Embed(source="data/Truck.png")]
		private var TruckBitmap:Class;
		
		public var mTruck:Object3D = Obj.load("data/Truck.obj",{material:TruckBitmap,scaling:1,screenZOffset: 10, bothsides: false});
		
		public var mLevel:Object3D = Obj.load("data/Level_Test.obj", {scaling:1,x:0,y:0,z:0,rotationX:0,rotationY:0,rotationZ:0,screenZOffset: -11, bothsides: false});
		
		public function GameLoader()
		{
			
		}
	}
}