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
		
		////////////////////////////////////////////////////////////
		// This code is not needed for the import of a 3DS file.
		////////////////////////////////////////////////////////////
		
		//[Embed(source="data/Truck.png")]
		//private var TruckBitmap:Class;

		//[Embed (source="data/Level/Road_100M_Texture.png")] private var RoadBitmap:Class;
		//public var mLevelTexture:BitmapMaterial;
		
		////////////////////////////////////////////////////////////
		
		
		
		//public var mTruck:Object3D = Obj.load("data/Truck.obj",{material:TruckBitmap,scaling:1,screenZOffset: 10, bothsides: false});
		
		//public var mLevel:Object3D = Obj.load("data/Level_Test3.obj", {material:RoadBitmap, scaling:1,x:0,y:0,z:0,rotationX:0,rotationY:0,rotationZ:0, bothsides: true});
		
		public var mPlayerMax3DS:Max3DS;
		public var mPlayerLoader:LoaderCube;
		public var mPlayerModel:ObjectContainer3D;
		
		public var mLevelMax3DS:Max3DS;
		public var mLevelLoader:LoaderCube;
		public var mLevelModel:ObjectContainer3D;
		
		public var mRedBuildingMax3DS:Max3DS;
		public var mRedBuildingLoader:LoaderCube;
		public var mRedBuildingModel:ObjectContainer3D;
		
		public var mBlueBuildingMax3DS:Max3DS;
		public var mBlueBuildingLoader:LoaderCube;
		public var mBlueBuildingModel:ObjectContainer3D;
		
		public function GameLoader()
		{
			LoadPlayer();
			LoadLevel();
		}
		
		public function LoadPlayer() : void
		{
			mPlayerMax3DS = new Max3DS();
			
			mPlayerMax3DS.centerMeshes = true;
			
			mPlayerLoader = new LoaderCube();
			mPlayerLoader.loaderSize = 200;
			mPlayerLoader.addOnSuccess(onPlayerSuccess);
			mPlayerLoader.loadGeometry("data/Player/Truck.3DS", mPlayerMax3DS);
			mPlayerLoader.screenZOffset = 10;
		}
		
		public function LoadLevel() : void
		{
			////////////////////////////////////////////////////////////
			// This code is for the Level.
			
			mLevelMax3DS = new Max3DS();
			
			mLevelMax3DS.centerMeshes = true;
			
			mLevelLoader = new LoaderCube();
			mLevelLoader.loaderSize = 200;
			mLevelLoader.addOnSuccess(onLevelSuccess);
			mLevelLoader.loadGeometry("data/Level/Final_Level.3DS", mLevelMax3DS);
			mLevelLoader.screenZOffset = 1;
			
			////////////////////////////////////////////////////////////
			// This code is for the 2 Building.
			
			mRedBuildingMax3DS = new Max3DS();
			
			mRedBuildingMax3DS.centerMeshes = true;
			
			mRedBuildingLoader = new LoaderCube();
			mRedBuildingLoader.loaderSize = 200;
			mRedBuildingLoader.addOnSuccess(onRedBuildingSuccess);
			mRedBuildingLoader.loadGeometry("data/Level/Red_Building.3DS", mRedBuildingMax3DS);
			mRedBuildingLoader.screenZOffset = 2;
			
			
			mBlueBuildingMax3DS = new Max3DS();
			
			mBlueBuildingMax3DS.centerMeshes = true;
			
			mBlueBuildingLoader = new LoaderCube();
			mBlueBuildingLoader.loaderSize = 200;
			mBlueBuildingLoader.addOnSuccess(onBlueBuildingSuccess);
			mBlueBuildingLoader.loadGeometry("data/Level/Blue_Building.3DS", mBlueBuildingMax3DS);
			mBlueBuildingLoader.screenZOffset = 3;
		}
		
		private function onPlayerSuccess(event:Event):void
		{
			mPlayerModel = mPlayerLoader.handle as ObjectContainer3D;
			mPlayerModel.rotationX = 90;
		}
		
		private function onLevelSuccess(event:Event):void
		{
			mLevelModel = mLevelLoader.handle as ObjectContainer3D;
			mLevelModel.rotationX = 90;
		}
		
		private function onRedBuildingSuccess(event:Event):void
		{
			mRedBuildingModel = mRedBuildingLoader.handle as ObjectContainer3D;
			mRedBuildingModel.rotationX = 90;
		}
		
		private function onBlueBuildingSuccess(event:Event):void
		{
			mBlueBuildingModel = mBlueBuildingLoader.handle as ObjectContainer3D;
			mBlueBuildingModel.rotationX = 90;
		}

	}
}