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
	
	public class GameLoader extends Sprite
	{
		public var mTruck:Object3D = Obj.load("data/Truck.OBJ");
		
		public function GameLoader()
		{
			
			addEventListener(Event.ADDED_TO_STAGE, InitPlayer);
			addEventListener(Event.ADDED_TO_STAGE, InitTrailer);
			addEventListener(Event.ADDED_TO_STAGE, InitWorld);
		}
		
		protected function InitPlayer(ev:Event)
		{
			removeEventListener(Event.ADDED_TO_STAGE, InitPlayer);
			
			mTruck.y = 0;
			mTruck.x = 0;
			mTruck.z = 0;
			mTruck.rotationX = 0;
			mTruck.rotationY = 180;
			mTruck.rotationZ = 0;
			mTruck.scale(6);

		}
		protected function InitTrailer(ev:Event)
		{
			removeEventListener(Event.ADDED_TO_STAGE, InitTrailer);
			
			
		}
		protected function InitWorld(ev:Event)
		{
			removeEventListener(Event.ADDED_TO_STAGE, InitWorld);
			
			
		}
	}
}