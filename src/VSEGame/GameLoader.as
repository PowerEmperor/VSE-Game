package VSEGame
{
	import Box2D.Collision.Shapes.*;
	import Box2D.Collision.b2AABB;
	import Box2D.Common.Math.*;
	import Box2D.Dynamics.*;
	
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
	import flash.geom.Rectangle;
	import flash.ui.Keyboard;
	import flash.utils.*;
	
	import mx.core.BitmapAsset;
	
	public class GameLoader extends Sprite
	{
		////////////////////////////////////////////////////////////
		//The Level Loader.
		
		public var mLevelMax3DS:Max3DS;
		public var mLevelLoader:LoaderCube;
		public var mLevelModel:ObjectContainer3D;		
		
		////////////////////////////////////////////////////////////
		//The Player Loader.
		
		public var mPlayerMax3DS:Max3DS;
		public var mPlayerLoader:LoaderCube;
		public var mPlayerModel:ObjectContainer3D;
		
		////////////////////////////////////////////////////////////
		//The Building Loaders.
		
		public var mRedBuildingMax3DS:Max3DS;
		public var mRedBuildingLoader:LoaderCube;
		public var mRedBuildingModel:ObjectContainer3D;
		
		public var mBlueBuildingMax3DS:Max3DS;
		public var mBlueBuildingLoader:LoaderCube;
		public var mBlueBuildingModel:ObjectContainer3D;
		
		////////////////////////////////////////////////////////////
		//These are the Bounding Boxes.
		
		public var mWorld:b2World;
		
		public var mBBPlayer:b2Body;
		
		public var mBBRedBuilding:b2Body;
		public var mBBBlueBuilding:b2Body;
		
		public var mBBUpWall:b2Body;
		public var mBBDownWall:b2Body;
		public var mBBLeftWall:b2Body;
		public var mBBRightWall:b2Body;
		
		////////////////////////////////////////////////////////////
		//These are the Collision Rectangles.
		
		public var mPlayerRec:Rectangle = new Rectangle(316,-278,5,5);
		
		public var mRedBuildingRec:Rectangle = new Rectangle(100,0,44,38);
		public var mBlueBuildingRec:Rectangle = new Rectangle(-100,0,44,38);
		
		public var mUpWallRec:Rectangle = new Rectangle(0,0,400,1);
		public var mDownWallRec:Rectangle = new Rectangle(0,0,400,1);
		public var mLeftWallRec:Rectangle = new Rectangle(0,0,1,400);
		public var mRightWallRec:Rectangle = new Rectangle(0,0,1,400);
		
		////////////////////////////////////////////////////////////
		//These are the Test Border Cubes
		
		//public var TestBorderCube:Cube = new Cube();
		//public var TestBorder2Cube:Cube = new Cube();
		//public var TestBorder3Cube:Cube = new Cube();
		//public var TestBorder4Cube:Cube = new Cube();
		
		//public var pillar:Cylinder = new Cylinder({radius:8, height: 60});  
		
		public function GameLoader()
		{			
			LoadWorld();
			CreateWorld();
			
			LoadPlayer();
		}
		
		public function CreateWorld() : void
		{
			mWorld = new b2World(new b2Vec2(0,0), true);
			
			////////////////////////////////////////////////////////////
			//The Player.
			
			var bodyDef:b2BodyDef = CreateBoxDef(mPlayerRec);
			bodyDef.type = b2Body.b2_dynamicBody;
			bodyDef.allowSleep = false;
			var bodyFixture:b2FixtureDef = CreateBoxFixture(mPlayerRec);
			
			mBBPlayer = mWorld.CreateBody(bodyDef);
			mBBPlayer.CreateFixture(bodyFixture);	
			
			////////////////////////////////////////////////////////////
			//This is for Creating a "Name" for the Collision object.
			
			var data:Object = {};
			data.type = "Building";
			
			////////////////////////////////////////////////////////////
			//Red Building.
			
			bodyDef = CreateBoxDef(mRedBuildingRec);
			bodyDef.type = b2Body.b2_staticBody;
			bodyDef.linearDamping = 20;
			bodyFixture = CreateBoxFixture(mRedBuildingRec);
			bodyFixture.density = 1;
			
			mBBRedBuilding = mWorld.CreateBody(bodyDef);
			mBBRedBuilding.CreateFixture(bodyFixture);
			mBBRedBuilding.SetUserData(data);
			
			////////////////////////////////////////////////////////////
			//Blue Building.
			
			bodyDef = CreateBoxDef(mBlueBuildingRec);
			bodyDef.type = b2Body.b2_staticBody;
			bodyDef.linearDamping = 20;
			bodyFixture = CreateBoxFixture(mBlueBuildingRec);
			bodyFixture.density = 1;
			
			mBBBlueBuilding = mWorld.CreateBody(bodyDef);
			mBBBlueBuilding.CreateFixture(bodyFixture);
			mBBBlueBuilding.SetUserData(data);
			
			////////////////////////////////////////////////////////////
			//The Roundabout.
			
			bodyDef = new b2BodyDef();
			bodyDef.position.Set(p2m(163), p2m(154));
			bodyDef.type = b2Body.b2_staticBody;
			var bodyShape:b2CircleShape = new b2CircleShape();
			bodyShape.SetRadius (p2m(8));
			bodyFixture = new b2FixtureDef();
			bodyFixture.shape = bodyShape;
			bodyFixture.density = 1;
			
			var Roundabout:b2Body = mWorld.CreateBody(bodyDef);  
			Roundabout.CreateFixture(bodyFixture);  
			Roundabout.SetUserData(data);  
			
			/*pillar.rotationX = 0;
			pillar.z = 154;
			pillar.x = 163;
			pillar.y = 0;*/
						
			////////////////////////////////////////////////////////////
			//The Borders.
			// The North Wall.
			
			bodyDef = CreateBoxDef(mUpWallRec);
			bodyDef.type = b2Body.b2_staticBody;
			bodyDef.linearDamping = 20;
			bodyFixture = CreateBoxFixture(mUpWallRec);
			bodyFixture.density = 1;
			
			mBBUpWall = mWorld.CreateBody(bodyDef);
			mBBUpWall.CreateFixture(bodyFixture);
			mBBUpWall.SetUserData(data);
			
			////////////////////////////////////////////////////////////
			//The Southern Wall.
			
			bodyDef = CreateBoxDef(mDownWallRec);
			bodyDef.type = b2Body.b2_staticBody;
			bodyDef.linearDamping = 20;
			bodyFixture = CreateBoxFixture(mDownWallRec);
			bodyFixture.density = 1;
			
			mBBDownWall = mWorld.CreateBody(bodyDef);
			mBBDownWall.CreateFixture(bodyFixture);
			mBBDownWall.SetUserData(data);
			
			////////////////////////////////////////////////////////////
			//The West Wall.
			
			bodyDef = CreateBoxDef(mLeftWallRec);
			bodyDef.type = b2Body.b2_staticBody;
			bodyDef.linearDamping = 20;
			bodyFixture = CreateBoxFixture(mLeftWallRec);
			bodyFixture.density = 1;
			
			mBBLeftWall = mWorld.CreateBody(bodyDef);
			mBBLeftWall.CreateFixture(bodyFixture);
			mBBLeftWall.SetUserData(data);
			
			////////////////////////////////////////////////////////////
			//The East Wall.
			
			bodyDef = CreateBoxDef(mRightWallRec);
			bodyDef.type = b2Body.b2_staticBody;
			bodyDef.linearDamping = 20;
			bodyFixture = CreateBoxFixture(mRightWallRec);
			bodyFixture.density = 1;
			
			mBBRightWall = mWorld.CreateBody(bodyDef);
			mBBRightWall.CreateFixture(bodyFixture);
			mBBRightWall.SetUserData(data);
			
			
			////////////////////////////////////////////////////////////
			//This sets the Position of the Borders.
			
			mBBUpWall.SetPosition(new b2Vec2(0,200));
			mBBDownWall.SetPosition(new b2Vec2(0,-200));
			mBBLeftWall.SetPosition(new b2Vec2(-200,0));
			mBBRightWall.SetPosition(new b2Vec2(200,0));
			
			////////////////////////////////////////////////////////////
			//The Test Cubes.
			
			/*TestBorderCube.x = mBBUpWall.GetPosition().x;
			TestBorderCube.y = 0;
			TestBorderCube.z = mBBUpWall.GetPosition().y;
			
			TestBorderCube.width = mUpWallRec.width;
			TestBorderCube.height = 10;
			TestBorderCube.depth = mUpWallRec.height;
			
			
			TestBorder2Cube.x = mBBDownWall.GetPosition().x;
			TestBorder2Cube.y = 0;
			TestBorder2Cube.z = mBBDownWall.GetPosition().y;
			
			TestBorder2Cube.width = mDownWallRec.width;
			TestBorder2Cube.height = 10;
			TestBorder2Cube.depth = mDownWallRec.height;
			
			
			TestBorder3Cube.x = mBBLeftWall.GetPosition().x;
			TestBorder3Cube.y = 0;
			TestBorder3Cube.z = mBBLeftWall.GetPosition().y;
			
			TestBorder3Cube.width = mLeftWallRec.width;
			TestBorder3Cube.height = 10;
			TestBorder3Cube.depth = mLeftWallRec.height;
			
			
			TestBorder4Cube.x = mBBRightWall.GetPosition().x;
			TestBorder4Cube.y = 0;
			TestBorder4Cube.z = mBBRightWall.GetPosition().y;
			
			TestBorder4Cube.width = mRightWallRec.width;
			TestBorder4Cube.height = 10;
			TestBorder4Cube.depth = mRightWallRec.height;*/
		}

		private function CreateBoxDef(rec:Rectangle) : b2BodyDef
		{
			var bodyDef:b2BodyDef = new b2BodyDef();
			bodyDef.position.Set(p2m(rec.x + rec.width/2), p2m(rec.y + rec.height/2));
			bodyDef.type = b2Body.b2_staticBody;
			bodyDef.angularDamping = 10;
			return bodyDef;
		}
		
		private function CreateBoxFixture(rec:Rectangle) : b2FixtureDef
		{
			var bodyShape:b2PolygonShape = new b2PolygonShape();
			bodyShape.SetAsBox (p2m(rec.width/2), p2m(rec.height/2));
			var bodyFixture:b2FixtureDef = new b2FixtureDef();
			bodyFixture.shape = bodyShape;
			bodyFixture.density = 1;
			bodyFixture.restitution = 0;
			return bodyFixture;
		}      
		
		private function p2m(pixel:Number):Number {  
			return pixel;  
		}  
		
		private function m2p(m:Number):Number {  
			return m * 30;  
		}  
		
		public function LoadWorld() : void
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