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
	import away3d.core.clip.RectangleClipping;
	import away3d.core.math.*;
	import away3d.core.render.Renderer;
	import away3d.core.utils.*;
	import away3d.events.*;
	import away3d.lights.*;  
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
		////////////////////////////////////////////////////////////
		//This is Camera and View stuff.
		////////////////////////////////////////////////////////////
		
		public var mView : View3D;
		public var mScene:Scene3D;
		public var mCamera:Camera3D;
		
		
		
		////////////////////////////////////////////////////////////
		//These are the model holders.
		
		protected var mGameLoader:GameLoader;
		public var mTruckContainer:ObjectContainer3D;
		public var mLevelContainer:ObjectContainer3D;
		
		public var mRedBuildingContainer:ObjectContainer3D;
		public var mBlueBuildingContainer:ObjectContainer3D;
		
		////////////////////////////////////////////////////////////
		//This is for the Speed and Keyboard Control
		
		private var speed:Number = 0;
		
		private var mKeyRight:Boolean = false;
		private var mKeyLeft:Boolean = false;
		private var mKeyForward:Boolean = false;
		private var mKeyReverse:Boolean = false;
		private var mKeySpace:Boolean = false;
		
		////////////////////////////////////////////////////////////
		//These are for Textfields.
		
		public var mSpeedMeter:TextField;
		
		public var mShowPosX:TextField;
		public var mShowPosZ:TextField;
		
		public var mTimer:TextField;
		[Embed (source="data/vera.swf", mimeType="application/octet-stream")] private var mVera : Class;
		
		////////////////////////////////////////////////////////////
		//These are for Test Collision Cubes.
		
		public var mPlayerCubeTest:Cube = new Cube();
		public var mBuildingCubeTest:Cube = new Cube();
		
		
		public function Game()
		{
			////////////////////////////////////////////////////////////
			//These are the model holders.
			////////////////////////////////////////////////////////////
			
			mGameLoader = new GameLoader();
			
			mTruckContainer = new ObjectContainer3D();
			mLevelContainer = new ObjectContainer3D();
			
			mRedBuildingContainer = new ObjectContainer3D();
			mBlueBuildingContainer = new ObjectContainer3D();
			
			////////////////////////////////////////////////////////////
			//View Creator.
			
			mView = new View3D({x:320, y:360});
			addChild(mView);
			
			mView.clipping = new RectangleClipping( { minX:-320, maxX:320, minY:-480, maxY:480 } );
			
			mScene = mView.scene;
			mCamera = mView.camera;
			
			Init();
			
			addEventListener(Event.ADDED_TO_STAGE, GameCreate, false, 0, true);
			addEventListener(Event.REMOVED_FROM_STAGE, GameDestroy, false, 0, true);
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
			
			mScene.addChild(mPlayerCubeTest);
			mScene.addChild(mBuildingCubeTest);
			
			mScene.addChild(mGameLoader.TestBorderCube);
			mScene.addChild(mGameLoader.TestBorder2Cube);
			mScene.addChild(mGameLoader.TestBorder3Cube);
			mScene.addChild(mGameLoader.TestBorder4Cube);
			mScene.addChild(mGameLoader.pillar);
			
			mScene.addChild(mRedBuildingContainer);
			mScene.addChild(mBlueBuildingContainer);
			
			mGameLoader.mPlayerLoader.x = mTruckContainer.x;
			mGameLoader.mPlayerLoader.y = mTruckContainer.y;
			mGameLoader.mPlayerLoader.z = mTruckContainer.z;
			
			//Start pos of the Player.	
			mGameLoader.mBBPlayer.SetPosition(new b2Vec2(158,30));
			mGameLoader.mBBPlayer.SetAngle((Math.PI/2 * 3));
			
					
			mTruckContainer.x = mGameLoader.mBBPlayer.GetPosition().x;
			mTruckContainer.y = 0;
			mTruckContainer.z = mGameLoader.mBBPlayer.GetPosition().y;
			
			mPlayerCubeTest.x = mTruckContainer.x;
			mPlayerCubeTest.y = mTruckContainer.y;
			mPlayerCubeTest.z = mTruckContainer.z;
			
			mPlayerCubeTest.width = mGameLoader.mPlayerRec.width;
			mPlayerCubeTest.height = 1;
			mPlayerCubeTest.depth = mGameLoader.mPlayerRec.height;
			
			
			
			mBuildingCubeTest.x = mGameLoader.mBBBlueBuilding.GetPosition().x;
			mBuildingCubeTest.y = 0;
			mBuildingCubeTest.z = mGameLoader.mBBBlueBuilding.GetPosition().y;
			
			mBuildingCubeTest.width = mGameLoader.mBlueBuildingRec.width;
			mBuildingCubeTest.height = 1;
			mBuildingCubeTest.depth = mGameLoader.mBlueBuildingRec.height;
			
			
			var TestCubeMaterial:ShadingColorMaterial = new ShadingColorMaterial();   
			TestCubeMaterial.ambient = 0xFF9900;   
			TestCubeMaterial.diffuse = 0xFF9900;   
			TestCubeMaterial.specular = 0xFF9900;  
			
			mPlayerCubeTest.material = TestCubeMaterial;
			mBuildingCubeTest.material = TestCubeMaterial;
			
			//mTruckContainer.rotationY = 0;
			
			
			//Pos of buildings.
			
			mRedBuildingContainer.x = 0;
			mRedBuildingContainer.y = 0;
			mRedBuildingContainer.z = 0;
			
			//mRedBuildingContainer.min
			
			mBlueBuildingContainer.x = 50;
			mBlueBuildingContainer.y = 0;
			mBlueBuildingContainer.z = 0;
			
			mTruckContainer.scale(1);
			mLevelContainer.scale(1);
			
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
			mTruckContainer.rotationY = mGameLoader.mBBPlayer.GetAngle() * (180/Math.PI) + 90;
			
			mTruckContainer.x = mGameLoader.mBBPlayer.GetPosition().x;
			mTruckContainer.z = mGameLoader.mBBPlayer.GetPosition().y;
			
			mRedBuildingContainer.x = mGameLoader.mBBRedBuilding.GetPosition().x
			mRedBuildingContainer.z = mGameLoader.mBBRedBuilding.GetPosition().y
				
			mBlueBuildingContainer.x = mGameLoader.mBBBlueBuilding.GetPosition().x
			mBlueBuildingContainer.z = mGameLoader.mBBBlueBuilding.GetPosition().y
			
			mPlayerCubeTest.x = mTruckContainer.x;
			mPlayerCubeTest.y = mTruckContainer.y;
			mPlayerCubeTest.z = mTruckContainer.z;
			

			
			mBuildingCubeTest.x = mGameLoader.mBBBlueBuilding.GetPosition().x;
			mBuildingCubeTest.y = 0;
			mBuildingCubeTest.z = mGameLoader.mBBBlueBuilding.GetPosition().y;
		}
		
		private function mKeyDownHandler(ev : KeyboardEvent) : void
		{
			//trace('huygjhk');
			switch (ev.keyCode) 
			{  
				case 38:  
					//trace('U There?');
					//UP KEY is up  
					mKeyForward = true;  
					break;  
				case 39:  
					//RIGHT KEY is up  
					mKeyRight = true;  
					break;  
				case 37:  
					//LEFT Key is up  
					mKeyLeft = true;  
					break;  
				case 40:  
					//DOWN KEY is up  
					mKeyReverse = true;  
					break;  
				case 32:
					mKeySpace = true;
					break;
			}  
		}
		
		private function mKeyUpHandler(ev : KeyboardEvent) : void
		{
			switch (ev.keyCode) 
			{  
				case 38:  
					//UP KEY is up  
					mKeyForward = false;  
					break;  
				case 39:  
					//RIGHT KEY is up  
					mKeyRight = false;  
					break;  
				case 37:  
					//LEFT Key is up  
					mKeyLeft = false;  
					break;  
				case 40:  
					//DOWN KEY is up  
					mKeyReverse = false;  
					break;  
				case 32:
					mKeySpace = false;
					break;
			}  
		}
		
		protected function onEnterFrame(ev:Event) : void
		{			
			mGameLoader.mWorld.Step(1/30,10,10);
			
			updateBody();
			HandlePlayer();
			
			mSpeedMeter.text = 'Speed Meter = '+ (speed).toFixed(0);
			
			mShowPosX.text = 'X CollsionBox = '+ (mGameLoader.mBBPlayer.GetPosition().x).toFixed(0);
			mShowPosZ.text = 'Z CollsionBox = '+ (mGameLoader.mBBPlayer.GetPosition().y).toFixed(0);
			
			
			mCamera.lookAt(mTruckContainer.position);
			mCamera.x = mTruckContainer.x - ((5) * Math.sin(mTruckContainer.rotationY * Math.PI / 180));
			mCamera.z = mTruckContainer.z - ((5) * Math.cos(mTruckContainer.rotationY * Math.PI / 180));
			mCamera.y = 1;
			
			mView.render();
			
		}
		
		private function updateBody ():void 
		{
			mGameLoader.mBBPlayer.SetLinearVelocity(new b2Vec2(0,0));  
			
			
			if (mKeyLeft && (speed > 3 || speed < -3)) mGameLoader.mBBPlayer.SetAngle(mGameLoader.mBBPlayer.GetAngle() - 0.025);  
			if (mKeyRight && (speed > 3 || speed < -3)) mGameLoader.mBBPlayer.SetAngle(mGameLoader.mBBPlayer.GetAngle() + 0.025);  
			
			var angle:Number = mGameLoader.mBBPlayer.GetAngle() - Math.PI/2;  
			var playerVelocity:b2Vec2 = mGameLoader.mBBPlayer.GetLinearVelocity();  
			
			if (mKeyForward) 
			{  
				if(speed < 80)
				{
					speed++;
				}
				
				playerVelocity.x -= speed*Math.sin(angle);
				playerVelocity.y -= speed*Math.cos(angle);
				
			}  
			if (mKeyReverse) 
			{  
				if(speed > -40)
				{
					speed--;
				}
				playerVelocity.x -= speed*Math.sin(angle);
				playerVelocity.y -= speed*Math.cos(angle);
			}  		
			
			if(mKeySpace)
			{
				if(speed > 0.01)
				{
					speed -= 3;
				}
				
				if(speed < -0.01)
				{
					speed += 3;
				}
			}
			
			if(!mKeyReverse && !mKeyForward)
			{
				if(speed > 0)
				{
					speed -= 0.5;
					
					playerVelocity.x -= speed*Math.sin(angle);  
					playerVelocity.y -= speed*Math.cos(angle);  
				}
				
				if(speed < 0)
				{
					speed += 0.5;
					
					playerVelocity.x -= speed*Math.sin(angle);  
					playerVelocity.y -= speed*Math.cos(angle);  
				}
				
				if(speed > -3 && speed < 3)
				{
				speed = 0;
				}
			}
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